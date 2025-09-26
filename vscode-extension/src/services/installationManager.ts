import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';
import * as yauzl from 'yauzl';
import { promisify } from 'util';
import { Platform, InstallationScope } from '../types/platform';
import { BundleInfo } from '../types/github';
import { PlatformDetector } from './platformDetector';
import { Logger } from '../utils/logger';

const readFile = promisify(fs.readFile);
const writeFile = promisify(fs.writeFile);
const mkdir = promisify(fs.mkdir);
const access = promisify(fs.access);
const unlink = promisify(fs.unlink);
const rmdir = promisify(fs.rmdir);

/**
 * Installation result information
 */
export interface InstallationResult {
    success: boolean;
    installedPath: string;
    installedFiles: string[];
    version: string;
    scope: InstallationScope;
    platform: Platform;
    error?: string;
}

/**
 * Service for managing OLAF component installations
 */
export class InstallationManager {
    private static instance: InstallationManager;
    private readonly logger: Logger;
    private readonly platformDetector: PlatformDetector;

    private constructor() {
        this.logger = Logger.getInstance();
        this.platformDetector = PlatformDetector.getInstance();
    }

    public static getInstance(): InstallationManager {
        if (!InstallationManager.instance) {
            InstallationManager.instance = new InstallationManager();
        }
        return InstallationManager.instance;
    }

    /**
     * Install OLAF components from a bundle
     */
    public async installBundle(
        bundleBuffer: Buffer,
        bundleInfo: BundleInfo,
        scope: InstallationScope,
        onProgress?: (progress: number, message: string) => void
    ): Promise<InstallationResult> {
        try {
            this.logger.info(`Starting installation of ${bundleInfo.filename} with scope: ${scope}`);

            const platform = await this.platformDetector.detectPlatform();
            const metadataPath = this.platformDetector.getInstallationPath(platform.platform, scope);
            
            // For project scope, extract files to project root; for others use the standard path
            const extractionPath = scope === InstallationScope.PROJECT 
                ? vscode.workspace.workspaceFolders?.[0]?.uri.fsPath || ''
                : metadataPath;

            // Update progress
            onProgress?.(10, 'Preparing installation directory...');

            // Ensure metadata directory exists
            await this.ensureDirectoryExists(metadataPath);
            
            // Ensure extraction directory exists (if different from metadata)
            if (extractionPath !== metadataPath) {
                await this.ensureDirectoryExists(extractionPath);
            }

            // Update progress
            onProgress?.(20, 'Extracting bundle...');

            // Extract bundle to the appropriate location
            const extractedFiles = await this.extractBundle(bundleBuffer, extractionPath, onProgress);

            // Update progress
            onProgress?.(80, 'Finalizing installation...');

            // Create installation metadata (always in metadata path)
            await this.createInstallationMetadata(metadataPath, bundleInfo, scope, platform.platform, extractedFiles, extractionPath);

            // Update progress
            onProgress?.(90, 'Updating configuration...');

            // Update platform-specific configuration if needed
            await this.updatePlatformConfiguration(platform.platform, scope, extractionPath);

            // Update progress
            onProgress?.(100, 'Installation completed successfully!');

            const result: InstallationResult = {
                success: true,
                installedPath: extractionPath,
                installedFiles: extractedFiles,
                version: bundleInfo.version,
                scope,
                platform: platform.platform
            };

            this.logger.info(`Installation completed successfully at: ${extractionPath}`);
            return result;

        } catch (error) {
            this.logger.error('Installation failed', error as Error);
            
            return {
                success: false,
                installedPath: '',
                installedFiles: [],
                version: bundleInfo.version,
                scope,
                platform: Platform.UNKNOWN,
                error: (error as Error).message
            };
        }
    }

    /**
     * Uninstall OLAF components
     */
    public async uninstall(scope: InstallationScope): Promise<boolean> {
        try {
            this.logger.info(`Starting uninstallation with scope: ${scope}`);

            const platform = await this.platformDetector.detectPlatform();
            const installationPath = this.platformDetector.getInstallationPath(platform.platform, scope);

            // Check if installation exists
            try {
                await access(installationPath);
            } catch {
                this.logger.warn(`No installation found at: ${installationPath}`);
                return true; // Nothing to uninstall
            }

            // Read installation metadata to get list of installed files
            const metadataPath = path.join(installationPath, '.olaf-metadata.json');
            let installedFiles: string[] = [];

            try {
                const metadata = await this.readInstallationMetadata(installationPath);
                installedFiles = metadata.installedFiles || [];
            } catch {
                this.logger.warn('Could not read installation metadata, removing entire directory');
            }

            // Remove installed files
            if (installedFiles.length > 0) {
                for (const file of installedFiles) {
                    try {
                        await unlink(path.join(installationPath, file));
                    } catch (error) {
                        this.logger.warn(`Failed to remove file: ${file}`, error as Error);
                    }
                }
            }

            // Remove installation directory
            try {
                await rmdir(installationPath, { recursive: true });
            } catch (error) {
                this.logger.error('Failed to remove installation directory', error as Error);
                return false;
            }

            this.logger.info(`Uninstallation completed successfully from: ${installationPath}`);
            return true;

        } catch (error) {
            this.logger.error('Uninstallation failed', error as Error);
            return false;
        }
    }

    /**
     * Get current installation information
     */
    public async getInstallationInfo(scope: InstallationScope): Promise<any | null> {
        try {
            const platform = await this.platformDetector.detectPlatform();
            const installationPath = this.platformDetector.getInstallationPath(platform.platform, scope);

            return await this.readInstallationMetadata(installationPath);
        } catch {
            return null;
        }
    }

    /**
     * Check if OLAF is installed in a specific scope
     */
    public async isInstalled(scope: InstallationScope): Promise<boolean> {
        try {
            const platform = await this.platformDetector.detectPlatform();
            const installationPath = this.platformDetector.getInstallationPath(platform.platform, scope);
            const metadataPath = path.join(installationPath, '.olaf-metadata.json');

            await access(metadataPath);
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Get all installation scopes where OLAF is installed
     */
    public async getInstalledScopes(): Promise<InstallationScope[]> {
        const scopes = [InstallationScope.USER, InstallationScope.WORKSPACE, InstallationScope.PROJECT];
        const installedScopes: InstallationScope[] = [];

        for (const scope of scopes) {
            if (await this.isInstalled(scope)) {
                installedScopes.push(scope);
            }
        }

        return installedScopes;
    }

    private async ensureDirectoryExists(dirPath: string): Promise<void> {
        try {
            await access(dirPath);
        } catch {
            await mkdir(dirPath, { recursive: true });
            this.logger.debug(`Created directory: ${dirPath}`);
        }
    }

    private async extractBundle(
        bundleBuffer: Buffer,
        extractPath: string,
        onProgress?: (progress: number, message: string) => void
    ): Promise<string[]> {
        return new Promise((resolve, reject) => {
            const extractedFiles: string[] = [];
            let processedEntries = 0;
            let totalEntries = 0;

            yauzl.fromBuffer(bundleBuffer, { lazyEntries: true }, (err: Error | null, zipfile?: yauzl.ZipFile) => {
                if (err) {
                    reject(err);
                    return;
                }

                if (!zipfile) {
                    reject(new Error('Failed to open zip file'));
                    return;
                }

                totalEntries = zipfile.entryCount;
                this.logger.debug(`Extracting ${totalEntries} entries from bundle to ${extractPath}`);

                zipfile.readEntry();

                zipfile.on('entry', (entry: yauzl.Entry) => {
                    const fileName = entry.fileName;
                    
                    // Skip directories
                    if (fileName.endsWith('/')) {
                        processedEntries++;
                        zipfile.readEntry();
                        return;
                    }

                    // Skip common hidden files but allow important dot directories like .github
                    const isHiddenFile = fileName.startsWith('.') && 
                        !fileName.startsWith('.github/') && 
                        !fileName.startsWith('.vscode/') && 
                        !fileName.startsWith('.olaf/');
                    
                    if (isHiddenFile) {
                        processedEntries++;
                        zipfile.readEntry();
                        return;
                    }

                    const outputPath = path.join(extractPath, fileName);
                    const outputDir = path.dirname(outputPath);

                    // Ensure output directory exists
                    fs.mkdir(outputDir, { recursive: true }, (mkdirErr) => {
                        if (mkdirErr) {
                            reject(mkdirErr);
                            return;
                        }

                        zipfile.openReadStream(entry, (streamErr: Error | null, readStream?: NodeJS.ReadableStream) => {
                            if (streamErr) {
                                reject(streamErr);
                                return;
                            }

                            if (!readStream) {
                                reject(new Error('Failed to open read stream'));
                                return;
                            }

                            const writeStream = fs.createWriteStream(outputPath);
                            
                            readStream.pipe(writeStream);

                            writeStream.on('close', () => {
                                extractedFiles.push(fileName);
                                processedEntries++;
                                
                                // Update progress
                                const progress = 20 + (processedEntries / totalEntries) * 60; // 20-80% for extraction
                                onProgress?.(progress, `Extracting: ${fileName}`);

                                this.logger.debug(`Extracted: ${fileName}`);
                                
                                if (processedEntries === totalEntries) {
                                    resolve(extractedFiles);
                                } else {
                                    zipfile.readEntry();
                                }
                            });

                            writeStream.on('error', (writeErr) => {
                                reject(writeErr);
                            });
                        });
                    });
                });

                zipfile.on('end', () => {
                    if (processedEntries === totalEntries) {
                        resolve(extractedFiles);
                    }
                });

                zipfile.on('error', (zipErr: Error) => {
                    reject(zipErr);
                });
            });
        });
    }

    private async createInstallationMetadata(
        metadataPath: string,
        bundleInfo: BundleInfo,
        scope: InstallationScope,
        platform: Platform,
        installedFiles: string[],
        extractionPath: string
    ): Promise<void> {
        const metadata = {
            version: bundleInfo.version,
            platform: platform,
            scope: scope,
            installedAt: new Date().toISOString(),
            bundleInfo: {
                filename: bundleInfo.filename,
                size: bundleInfo.size,
                platform: bundleInfo.platform
            },
            installedFiles: installedFiles,
            extractionPath: extractionPath
        };

        const metadataFilePath = path.join(metadataPath, '.olaf-metadata.json');
        await writeFile(metadataFilePath, JSON.stringify(metadata, null, 2));
        
        this.logger.debug(`Created installation metadata at: ${metadataFilePath}`);
    }

    private async readInstallationMetadata(installationPath: string): Promise<any> {
        const metadataPath = path.join(installationPath, '.olaf-metadata.json');
        const metadataContent = await readFile(metadataPath, 'utf8');
        return JSON.parse(metadataContent);
    }

    private async updatePlatformConfiguration(
        platform: Platform,
        scope: InstallationScope,
        installationPath: string
    ): Promise<void> {
        try {
            // Platform-specific configuration updates
            switch (platform) {
                case Platform.VSCODE:
                    await this.updateVSCodeConfiguration(scope, installationPath);
                    break;
                case Platform.WINDSURF:
                    await this.updateWindsurfConfiguration(scope, installationPath);
                    break;
                case Platform.KIRO:
                    await this.updateKiroConfiguration(scope, installationPath);
                    break;
                case Platform.CURSOR:
                    await this.updateCursorConfiguration(scope, installationPath);
                    break;
                default:
                    this.logger.debug('No platform-specific configuration updates needed');
            }
        } catch (error) {
            this.logger.warn('Failed to update platform configuration', error as Error);
            // Don't fail the installation for configuration updates
        }
    }

    private async updateVSCodeConfiguration(scope: InstallationScope, installationPath: string): Promise<void> {
        // Add VSCode-specific configuration updates here
        this.logger.debug(`Updating VSCode configuration for scope: ${scope}`);
    }

    private async updateWindsurfConfiguration(scope: InstallationScope, installationPath: string): Promise<void> {
        // Add Windsurf-specific configuration updates here
        this.logger.debug(`Updating Windsurf configuration for scope: ${scope}`);
    }

    private async updateKiroConfiguration(scope: InstallationScope, installationPath: string): Promise<void> {
        // Add Kiro-specific configuration updates here
        this.logger.debug(`Updating Kiro configuration for scope: ${scope}`);
    }

    private async updateCursorConfiguration(scope: InstallationScope, installationPath: string): Promise<void> {
        // Add Cursor-specific configuration updates here
        this.logger.debug(`Updating Cursor configuration for scope: ${scope}`);
    }
}
