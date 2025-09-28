import * as crypto from 'crypto';
import * as fs from 'fs';
import * as path from 'path';
import { xxh64 } from '@node-rs/xxhash';
import { FileIntegrityInfo, ModificationInfo, IntegrityReport } from '../types/integrityTypes';

/**
 * Service for calculating and verifying file integrity using multiple hash algorithms
 */
export class FileIntegrityService {
    private static readonly CHUNK_SIZE = 64 * 1024; // 64KB chunks for large files
    private static readonly CURRENT_VERSION = '1.0.0';

    /**
     * Calculate comprehensive integrity information for a single file
     */
    async calculateFileIntegrity(filePath: string): Promise<FileIntegrityInfo> {
        const stats = await fs.promises.stat(filePath);
        
        // Calculate both hash algorithms efficiently in a single pass
        const hashes = await this.calculateFileHashes(filePath);
        
        return {
            path: filePath,
            sha256: hashes.sha256,
            xxhash64: hashes.xxhash64,
            size: stats.size,
            mtime: stats.mtime.toISOString(),
            permissions: stats.mode.toString(8),
            isExecutable: !!(stats.mode & fs.constants.S_IXUSR),
            isSymlink: stats.isSymbolicLink(),
            symlinkTarget: stats.isSymbolicLink() ? await fs.promises.readlink(filePath) : undefined
        };
    }

    /**
     * Calculate integrity information for multiple files in parallel
     */
    async calculateFilesIntegrity(filePaths: string[], concurrency: number = 5): Promise<FileIntegrityInfo[]> {
        const results: FileIntegrityInfo[] = [];
        const semaphore = new Semaphore(concurrency);

        const promises = filePaths.map(async (filePath) => {
            await semaphore.acquire();
            try {
                const integrity = await this.calculateFileIntegrity(filePath);
                results.push(integrity);
            } finally {
                semaphore.release();
            }
        });

        await Promise.all(promises);
        
        // Sort results by path to maintain consistent ordering
        return results.sort((a, b) => a.path.localeCompare(b.path));
    }

    /**
     * Verify file integrity against expected values using hybrid approach
     */
    async verifyFileIntegrity(filePath: string, expected: FileIntegrityInfo): Promise<ModificationInfo> {
        try {
            // Quick checks first (size and modification time)
            const stats = await fs.promises.stat(filePath);
            
            // Size check - fastest verification
            if (stats.size !== expected.size) {
                return {
                    isModified: true,
                    verificationType: 'size',
                    originalIntegrity: expected,
                    currentState: { 
                        path: filePath,
                        size: stats.size,
                        mtime: stats.mtime.toISOString()
                    }
                };
            }

            // Time check - if file is newer than installation, it might be modified
            const currentMtime = stats.mtime.toISOString();
            if (currentMtime > expected.mtime) {
                // File appears to be modified based on timestamp, verify with hash
                const currentIntegrity = await this.calculateFileIntegrity(filePath);
                
                return {
                    isModified: currentIntegrity.sha256 !== expected.sha256,
                    modifiedAt: currentMtime,
                    verificationType: 'hash',
                    originalIntegrity: expected,
                    currentState: currentIntegrity
                };
            }

            // Fast hash check for files that haven't changed timestamp
            const buffer = await fs.promises.readFile(filePath);
            const currentXxhash = xxh64(buffer).toString(16);
            
            if (currentXxhash !== expected.xxhash64) {
                // xxHash doesn't match, verify with SHA-256
                const currentIntegrity = await this.calculateFileIntegrity(filePath);
                
                return {
                    isModified: currentIntegrity.sha256 !== expected.sha256,
                    modifiedAt: currentMtime,
                    verificationType: 'hash',
                    originalIntegrity: expected,
                    currentState: currentIntegrity
                };
            }

            // File appears unchanged
            return {
                isModified: false,
                verificationType: 'time',
                originalIntegrity: expected
            };

        } catch (error) {
            if ((error as any).code === 'ENOENT') {
                return {
                    isModified: true,
                    verificationType: 'missing',
                    originalIntegrity: expected
                };
            }
            throw error;
        }
    }

    /**
     * Verify integrity of all files in parallel
     */
    async verifyAllFiles(files: FileIntegrityInfo[], concurrency: number = 5): Promise<Map<string, ModificationInfo>> {
        const results = new Map<string, ModificationInfo>();
        const semaphore = new Semaphore(concurrency);

        const promises = files.map(async (fileInfo) => {
            await semaphore.acquire();
            try {
                const result = await this.verifyFileIntegrity(fileInfo.path, fileInfo);
                results.set(fileInfo.path, result);
            } finally {
                semaphore.release();
            }
        });

        await Promise.all(promises);
        return results;
    }

    /**
     * Calculate SHA-256 hash of a bundle file
     */
    async calculateBundleHash(bundlePath: string): Promise<string> {
        const hash = crypto.createHash('sha256');
        const stream = fs.createReadStream(bundlePath, { 
            highWaterMark: FileIntegrityService.CHUNK_SIZE 
        });

        for await (const chunk of stream) {
            hash.update(chunk);
        }

        return hash.digest('hex');
    }

    /**
     * Verify bundle integrity
     */
    async verifyBundleIntegrity(bundlePath: string, expectedHash: string): Promise<boolean> {
        const actualHash = await this.calculateBundleHash(bundlePath);
        return actualHash === expectedHash;
    }

    /**
     * Generate comprehensive integrity report
     */
    generateIntegrityReport(modifications: Map<string, ModificationInfo>): IntegrityReport {
        let modifiedFiles = 0;
        let deletedFiles = 0;
        let corruptedFiles = 0;
        let intactFiles = 0;

        const reportModifications = Array.from(modifications.entries()).map(([file, info]) => {
            let type: 'modified' | 'deleted' | 'corrupted' | 'intact';
            let recommendation: 'preserve' | 'restore' | 'backup' | 'ignore' | 'remove';

            if (info.verificationType === 'missing') {
                type = 'deleted';
                recommendation = 'ignore';
                deletedFiles++;
            } else if (info.isModified) {
                if (info.verificationType === 'hash' && info.currentState?.sha256) {
                    type = 'modified';
                    recommendation = 'preserve';
                    modifiedFiles++;
                } else {
                    type = 'corrupted';
                    recommendation = 'restore';
                    corruptedFiles++;
                }
            } else {
                type = 'intact';
                recommendation = 'remove';
                intactFiles++;
            }

            return {
                file,
                type,
                details: info,
                recommendation
            };
        });

        const totalFiles = modifications.size;
        const summary = this.generateSummaryText(totalFiles, intactFiles, modifiedFiles, deletedFiles, corruptedFiles);

        return {
            totalFiles,
            modifiedFiles,
            deletedFiles,
            corruptedFiles,
            intactFiles,
            modifications: reportModifications,
            summary,
            generatedAt: new Date().toISOString()
        };
    }

    /**
     * Calculate file hashes efficiently in a single pass
     */
    private async calculateFileHashes(filePath: string): Promise<{sha256: string, xxhash64: string}> {
        const sha256Hash = crypto.createHash('sha256');
        
        const stream = fs.createReadStream(filePath, { 
            highWaterMark: FileIntegrityService.CHUNK_SIZE 
        });

        let xxhashBuffer = Buffer.alloc(0);

        for await (const chunk of stream) {
            sha256Hash.update(chunk);
            xxhashBuffer = Buffer.concat([xxhashBuffer, chunk]);
        }

        const xxhash64Value = xxh64(xxhashBuffer);

        return {
            sha256: sha256Hash.digest('hex'),
            xxhash64: xxhash64Value.toString(16)
        };
    }

    /**
     * Generate human-readable summary text
     */
    private generateSummaryText(total: number, intact: number, modified: number, deleted: number, corrupted: number): string {
        const parts = [];
        
        parts.push(`${total} total files tracked`);
        
        if (intact > 0) {
            parts.push(`${intact} intact files (safe to remove)`);
        }
        
        if (modified > 0) {
            parts.push(`${modified} user-modified files (recommend preserving)`);
        }
        
        if (deleted > 0) {
            parts.push(`${deleted} files already deleted`);
        }
        
        if (corrupted > 0) {
            parts.push(`${corrupted} corrupted files (recommend restoring or removing)`);
        }

        return parts.join(', ') + '.';
    }
}

/**
 * Simple semaphore implementation for controlling concurrency
 */
class Semaphore {
    private permits: number;
    private waitQueue: Array<() => void> = [];

    constructor(permits: number) {
        this.permits = permits;
    }

    async acquire(): Promise<void> {
        if (this.permits > 0) {
            this.permits--;
            return Promise.resolve();
        }

        return new Promise<void>((resolve) => {
            this.waitQueue.push(resolve);
        });
    }

    release(): void {
        this.permits++;
        const next = this.waitQueue.shift();
        if (next) {
            this.permits--;
            next();
        }
    }
}
