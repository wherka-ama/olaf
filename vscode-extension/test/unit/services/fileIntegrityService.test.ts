import * as assert from 'assert';
import * as fs from 'fs';
import * as path from 'path';
import * as os from 'os';
import { FileIntegrityService } from '../../../src/services/fileIntegrityService';
import { FileIntegrityInfo, ModificationInfo } from '../../../src/types/integrityTypes';

suite('FileIntegrityService Tests', () => {
    let integrityService: FileIntegrityService;
    let tempDir: string;
    let testFile1: string;
    let testFile2: string;

    setup(async () => {
        integrityService = new FileIntegrityService();
        
        // Create temporary directory for test files
        tempDir = await fs.promises.mkdtemp(path.join(os.tmpdir(), 'olaf-integrity-test-'));
        testFile1 = path.join(tempDir, 'test1.txt');
        testFile2 = path.join(tempDir, 'test2.txt');

        // Create test files with known content
        await fs.promises.writeFile(testFile1, 'Hello World', 'utf8');
        await fs.promises.writeFile(testFile2, 'Test Content for File 2', 'utf8');
    });

    teardown(async () => {
        // Clean up temporary directory
        try {
            await fs.promises.rm(tempDir, { recursive: true, force: true });
        } catch (error) {
            // Ignore cleanup errors
        }
    });

    test('calculateFileIntegrity should calculate correct hashes and metadata', async () => {
        const integrity = await integrityService.calculateFileIntegrity(testFile1);

        assert.strictEqual(integrity.path, testFile1);
        assert.strictEqual(typeof integrity.sha256, 'string');
        assert.strictEqual(integrity.sha256.length, 64); // SHA-256 is 64 hex characters
        assert.strictEqual(typeof integrity.xxhash64, 'string');
        assert.strictEqual(integrity.size, 11); // "Hello World" is 11 bytes
        assert.strictEqual(typeof integrity.mtime, 'string');
        assert.strictEqual(typeof integrity.permissions, 'string');
        assert.strictEqual(typeof integrity.isExecutable, 'boolean');
        assert.strictEqual(typeof integrity.isSymlink, 'boolean');
    });

    test('calculateFilesIntegrity should process multiple files in parallel', async () => {
        const filePaths = [testFile1, testFile2];
        const results = await integrityService.calculateFilesIntegrity(filePaths, 2);

        assert.strictEqual(results.length, 2);
        assert.strictEqual(results[0].path, testFile1);
        assert.strictEqual(results[1].path, testFile2);
        assert.strictEqual(results[0].size, 11); // "Hello World"
        assert.strictEqual(results[1].size, 23); // "Test Content for File 2"
    });

    test('verifyFileIntegrity should detect intact files correctly', async () => {
        // Calculate original integrity
        const originalIntegrity = await integrityService.calculateFileIntegrity(testFile1);

        // Verify immediately (should be intact)
        const verification = await integrityService.verifyFileIntegrity(testFile1, originalIntegrity);

        assert.strictEqual(verification.isModified, false);
        assert.strictEqual(verification.verificationType, 'time');
        assert.strictEqual(verification.originalIntegrity.path, testFile1);
    });

    test('verifyFileIntegrity should detect size changes', async () => {
        // Calculate original integrity
        const originalIntegrity = await integrityService.calculateFileIntegrity(testFile1);

        // Modify file (change size)
        await fs.promises.writeFile(testFile1, 'Hello World - Modified!', 'utf8');

        // Verify (should detect size change)
        const verification = await integrityService.verifyFileIntegrity(testFile1, originalIntegrity);

        assert.strictEqual(verification.isModified, true);
        assert.strictEqual(verification.verificationType, 'size');
        assert.strictEqual(verification.currentState?.size, 23); // New size
    });

    test('verifyFileIntegrity should detect content changes with same size', async () => {
        // Create file with specific content
        const sameContentFile = path.join(tempDir, 'same-size.txt');
        await fs.promises.writeFile(sameContentFile, 'Hello World', 'utf8'); // 11 bytes

        // Calculate original integrity
        const originalIntegrity = await integrityService.calculateFileIntegrity(sameContentFile);

        // Wait a bit to ensure different timestamp
        await new Promise(resolve => setTimeout(resolve, 10));

        // Modify content but keep same size
        await fs.promises.writeFile(sameContentFile, 'Goodbye All', 'utf8'); // Also 11 bytes

        // Verify (should detect content change via hash)
        const verification = await integrityService.verifyFileIntegrity(sameContentFile, originalIntegrity);

        assert.strictEqual(verification.isModified, true);
        assert.strictEqual(verification.verificationType, 'hash');
        assert.notStrictEqual(verification.currentState?.sha256, originalIntegrity.sha256);
    });

    test('verifyFileIntegrity should detect missing files', async () => {
        // Calculate original integrity
        const originalIntegrity = await integrityService.calculateFileIntegrity(testFile1);

        // Remove file
        await fs.promises.unlink(testFile1);

        // Verify (should detect missing file)
        const verification = await integrityService.verifyFileIntegrity(testFile1, originalIntegrity);

        assert.strictEqual(verification.isModified, true);
        assert.strictEqual(verification.verificationType, 'missing');
    });

    test('verifyAllFiles should process multiple files and return results map', async () => {
        const file1Integrity = await integrityService.calculateFileIntegrity(testFile1);
        const file2Integrity = await integrityService.calculateFileIntegrity(testFile2);
        const files = [file1Integrity, file2Integrity];

        // Modify one file
        await fs.promises.writeFile(testFile2, 'Modified content', 'utf8');

        const results = await integrityService.verifyAllFiles(files, 2);

        assert.strictEqual(results.size, 2);
        assert.strictEqual(results.get(testFile1)?.isModified, false); // Intact
        assert.strictEqual(results.get(testFile2)?.isModified, true);  // Modified
    });

    test('calculateBundleHash should calculate SHA-256 for bundle files', async () => {
        // Create a test "bundle" file
        const bundleFile = path.join(tempDir, 'test-bundle.zip');
        await fs.promises.writeFile(bundleFile, 'Mock bundle content', 'utf8');

        const hash = await integrityService.calculateBundleHash(bundleFile);

        assert.strictEqual(typeof hash, 'string');
        assert.strictEqual(hash.length, 64); // SHA-256 is 64 hex characters
    });

    test('verifyBundleIntegrity should verify bundle hashes correctly', async () => {
        // Create a test bundle file
        const bundleFile = path.join(tempDir, 'test-bundle.zip');
        await fs.promises.writeFile(bundleFile, 'Mock bundle content', 'utf8');

        // Calculate hash
        const expectedHash = await integrityService.calculateBundleHash(bundleFile);

        // Verify with correct hash
        const isValid = await integrityService.verifyBundleIntegrity(bundleFile, expectedHash);
        assert.strictEqual(isValid, true);

        // Verify with incorrect hash
        const isInvalid = await integrityService.verifyBundleIntegrity(bundleFile, 'invalid-hash');
        assert.strictEqual(isInvalid, false);
    });

    test('generateIntegrityReport should create comprehensive reports', async () => {
        // Create mock modification data
        const file1Integrity = await integrityService.calculateFileIntegrity(testFile1);
        const file2Integrity = await integrityService.calculateFileIntegrity(testFile2);

        const modifications = new Map<string, ModificationInfo>();
        modifications.set(testFile1, {
            isModified: false,
            verificationType: 'time',
            originalIntegrity: file1Integrity
        });
        modifications.set(testFile2, {
            isModified: true,
            verificationType: 'hash',
            originalIntegrity: file2Integrity,
            currentState: { ...file2Integrity, sha256: 'modified-hash' }
        });

        const report = integrityService.generateIntegrityReport(modifications);

        assert.strictEqual(report.totalFiles, 2);
        assert.strictEqual(report.intactFiles, 1);
        assert.strictEqual(report.modifiedFiles, 1);
        assert.strictEqual(report.deletedFiles, 0);
        assert.strictEqual(report.corruptedFiles, 0);
        assert.strictEqual(report.modifications.length, 2);
        assert.strictEqual(typeof report.summary, 'string');
        assert.strictEqual(typeof report.generatedAt, 'string');
    });

    test('generateIntegrityReport should handle different file states', async () => {
        const file1Integrity = await integrityService.calculateFileIntegrity(testFile1);
        
        const modifications = new Map<string, ModificationInfo>();
        
        // Intact file
        modifications.set('/path/intact.txt', {
            isModified: false,
            verificationType: 'time',
            originalIntegrity: file1Integrity
        });

        // Modified file
        modifications.set('/path/modified.txt', {
            isModified: true,
            verificationType: 'hash',
            originalIntegrity: file1Integrity,
            currentState: { ...file1Integrity, sha256: 'new-hash' }
        });

        // Deleted file
        modifications.set('/path/deleted.txt', {
            isModified: true,
            verificationType: 'missing',
            originalIntegrity: file1Integrity
        });

        // Corrupted file (size mismatch)
        modifications.set('/path/corrupted.txt', {
            isModified: true,
            verificationType: 'size',
            originalIntegrity: file1Integrity,
            currentState: { ...file1Integrity, size: 999 }
        });

        const report = integrityService.generateIntegrityReport(modifications);

        assert.strictEqual(report.totalFiles, 4);
        assert.strictEqual(report.intactFiles, 1);
        assert.strictEqual(report.modifiedFiles, 1);
        assert.strictEqual(report.deletedFiles, 1);
        assert.strictEqual(report.corruptedFiles, 1);

        // Check recommendations
        const intactMod = report.modifications.find(m => m.file === '/path/intact.txt');
        assert.strictEqual(intactMod?.recommendation, 'remove');

        const modifiedMod = report.modifications.find(m => m.file === '/path/modified.txt');
        assert.strictEqual(modifiedMod?.recommendation, 'preserve');

        const deletedMod = report.modifications.find(m => m.file === '/path/deleted.txt');
        assert.strictEqual(deletedMod?.recommendation, 'ignore');

        const corruptedMod = report.modifications.find(m => m.file === '/path/corrupted.txt');
        assert.strictEqual(corruptedMod?.recommendation, 'restore');
    });
});
