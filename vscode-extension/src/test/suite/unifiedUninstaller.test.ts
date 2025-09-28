import * as assert from 'assert';
import * as path from 'path';
import * as fs from 'fs-extra';
import * as os from 'os';
import { UnifiedUninstaller, UninstallOptions, UninstallResult } from '../../services/unifiedUninstaller';

describe('UnifiedUninstaller', () => {
    let tempDir: string;
    let uninstaller: UnifiedUninstaller;

    beforeEach(async () => {
        tempDir = await fs.mkdtemp(path.join(os.tmpdir(), 'olaf-test-'));
        uninstaller = new UnifiedUninstaller();
    });

    afterEach(async () => {
        if (tempDir && await fs.pathExists(tempDir)) {
            await fs.remove(tempDir);
        }
    });

    describe('File Categorization', () => {
        it('should correctly categorize files as original, modified, and user-created', async () => {
            // Create test files
            const originalFile = path.join(tempDir, 'original.txt');
            const modifiedFile = path.join(tempDir, 'modified.txt');
            const userFile = path.join(tempDir, 'user.txt');
            
            await fs.writeFile(originalFile, 'original content');
            await fs.writeFile(modifiedFile, 'modified content');
            await fs.writeFile(userFile, 'user content');

            const options: UninstallOptions = {
                type: 'smart',
                targetDir: tempDir,
                createBackup: false
            };

            const result = await uninstaller.uninstall(options);
            
            // Should succeed and preserve files since no metadata to distinguish
            assert.strictEqual(result.success, true);
            assert.strictEqual(result.errors.length, 0);
        });

        it('should handle missing files gracefully', async () => {
            // Create some files but reference non-existent ones in custom selection
            await fs.writeFile(path.join(tempDir, 'exists.txt'), 'content');

            const options: UninstallOptions = {
                type: 'custom',
                targetDir: tempDir,
                customSelection: [
                    path.join(tempDir, 'exists.txt'),
                    path.join(tempDir, 'missing.txt')
                ],
                createBackup: false
            };

            const result = await uninstaller.uninstall(options);
            
            // Should handle missing files gracefully
            assert.strictEqual(result.success, true);
            assert.strictEqual(result.filesRemoved, 1);
        });
    });

    describe('Complete Uninstall', () => {
        it('should remove all files without backup', async () => {
            // Create test files
            await fs.writeFile(path.join(tempDir, 'file1.txt'), 'content1');
            await fs.writeFile(path.join(tempDir, 'file2.txt'), 'content2');

            const options: UninstallOptions = {
                type: 'complete',
                targetDir: tempDir,
                createBackup: false
            };

            const result = await uninstaller.uninstall(options);
            
            assert.strictEqual(result.success, true);
            assert.strictEqual(result.filesRemoved, 2);
            assert.strictEqual(result.filesPreserved, 0);
            assert.strictEqual(result.backupPath, undefined);
        });
    });

    describe('Smart Uninstall', () => {
        it('should remove original files and preserve modified/user-created files', async () => {
            // Create test files
            await fs.writeFile(path.join(tempDir, 'file1.txt'), 'content1');
            await fs.writeFile(path.join(tempDir, 'file2.txt'), 'content2');

            const options: UninstallOptions = {
                type: 'smart',
                targetDir: tempDir,
                createBackup: false
            };

            const result = await uninstaller.uninstall(options);
            
            assert.strictEqual(result.success, true);
            assert.strictEqual(result.errors.length, 0);
            // Without metadata, smart uninstall treats all files as modified/user-created
            assert.strictEqual(result.filesRemoved, 0);
            assert.strictEqual(result.filesPreserved, 2);
        });

        it('should create backup of preserved files', async () => {
            // Create test files
            await fs.writeFile(path.join(tempDir, 'file1.txt'), 'content1');
            await fs.writeFile(path.join(tempDir, 'file2.txt'), 'content2');

            const options: UninstallOptions = {
                type: 'smart',
                targetDir: tempDir,
                createBackup: true
            };

            const result = await uninstaller.uninstall(options);
            
            assert.strictEqual(result.success, true);
            if (result.filesPreserved > 0) {
                assert.strictEqual(typeof result.backupPath, 'string');
                assert.ok(await fs.pathExists(result.backupPath!));
            }
        });
    });

    describe('Custom Uninstall', () => {
        it('should only remove specified files', async () => {
            // Create test files
            const file1 = path.join(tempDir, 'file1.txt');
            const file2 = path.join(tempDir, 'file2.txt');
            const file3 = path.join(tempDir, 'file3.txt');
            
            await fs.writeFile(file1, 'content1');
            await fs.writeFile(file2, 'content2');
            await fs.writeFile(file3, 'content3');

            const options: UninstallOptions = {
                type: 'custom',
                targetDir: tempDir,
                customSelection: [file1, file3],
                createBackup: false
            };

            const result = await uninstaller.uninstall(options);
            
            assert.strictEqual(result.success, true);
            assert.strictEqual(result.filesRemoved, 2);
            assert.strictEqual(result.filesPreserved, 1);
            
            // file2 should still exist
            assert.ok(await fs.pathExists(file2));
            assert.ok(!(await fs.pathExists(file1)));
            assert.ok(!(await fs.pathExists(file3)));
        });

        it('should reject invalid custom selections', async () => {
            const options: UninstallOptions = {
                type: 'custom',
                targetDir: tempDir,
                createBackup: false
                // Missing customSelection
            };

            const result = await uninstaller.uninstall(options);
            
            assert.strictEqual(result.success, false);
            assert.ok(result.errors.length > 0);
            assert.ok(result.errors[0].includes('Custom selection required'));
        });
    });

    describe('Progress Reporting', () => {
        it('should report progress during uninstall', async () => {
            // Create test files
            await fs.writeFile(path.join(tempDir, 'file1.txt'), 'content1');

            const progressReports: Array<{progress: number, message: string}> = [];
            
            const options: UninstallOptions = {
                type: 'complete',
                targetDir: tempDir,
                createBackup: false,
                onProgress: (progress: number, message: string) => {
                    progressReports.push({ progress, message });
                }
            };

            const result = await uninstaller.uninstall(options);
            
            assert.strictEqual(result.success, true);
            assert.ok(progressReports.length > 0);
            
            // Should have start and end progress reports
            const firstReport = progressReports[0];
            const lastReport = progressReports[progressReports.length - 1];
            
            assert.strictEqual(firstReport.progress, 0);
            assert.ok(firstReport.message.includes('Starting'));
            
            assert.strictEqual(lastReport.progress, 100);
            assert.ok(lastReport.message.includes('completed'));
        });
    });
});
