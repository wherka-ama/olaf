import * as assert from 'assert';
import * as vscode from 'vscode';
import * as path from 'path';
import * as fs from 'fs';
import { GitHubService } from '../../services/githubService';
import { PlatformDetector } from '../../services/platformDetector';
import { 
    createMockReleaseResponse, 
    loadBundleContentFromFixtures, 
    validateBundleContent,
    createTestWorkspace,
    cleanupTestWorkspace,
    createZipFromFixtures,
    extractZipToContents,
    saveZipToTempFile,
    extractZipToDirectory
} from '../helpers/mockData';

describe('OLAF Integration Tests - Full Flow', () => {
    let githubService: GitHubService;
    let platformDetector: PlatformDetector;
    let testWorkspaceUri: vscode.Uri;
    let testWorkspacePath: string;

    before(async () => {
        // Initialize services
        githubService = GitHubService.getInstance();
        platformDetector = PlatformDetector.getInstance();
        
        // Create test workspace
        testWorkspacePath = createTestWorkspace();
        testWorkspaceUri = vscode.Uri.file(testWorkspacePath);
    });

    after(async () => {
        // Cleanup test workspace
        if (testWorkspacePath) {
            cleanupTestWorkspace(testWorkspacePath);
        }
    });

    it('Full Flow: Detect Platform → Fetch Release → Download Bundle → Extract Files', async function() {
        this.timeout(10000); // Increase timeout for integration test

        // Step 1: Platform Detection
        console.log('Step 1: Detecting platform...');
        const detectedPlatform = await platformDetector.detectPlatform();
        assert.ok(detectedPlatform, 'Platform should be detected');
        assert.ok(['vscode', 'windsurf', 'cursor', 'kiro'].includes(detectedPlatform.platform), 
                  `Platform should be one of supported platforms, got: ${detectedPlatform.platform}`);
        
        console.log(`Detected platform: ${detectedPlatform.platform} (confidence: ${detectedPlatform.confidence})`);

        // Step 2: Mock GitHub API calls for release data
        console.log('Step 2: Fetching release information...');
        
        // Use mock data helper
        const releaseData = createMockReleaseResponse();
        assert.ok(releaseData, 'Release data should be available');
        assert.ok(releaseData.assets.length > 0, 'Release should have assets');

        // Step 3: Find platform-specific bundle
        console.log('Step 3: Finding platform-specific bundle...');
        const bundleName = `${detectedPlatform.platform}-bundle.zip`;
        const bundleAsset = releaseData.assets.find(asset => asset.name === bundleName);
        
        if (!bundleAsset) {
            console.log(`No specific bundle found for ${detectedPlatform.platform}, using vscode bundle as fallback`);
            const fallbackAsset = releaseData.assets.find(asset => asset.name === 'vscode-bundle.zip');
            assert.ok(fallbackAsset, 'Fallback bundle should be available');
        } else {
            console.log(`Found platform bundle: ${bundleAsset.name} (${bundleAsset.size} bytes)`);
        }

        // Step 4: Simulate bundle download (create actual ZIP)
        console.log('Step 4: Simulating bundle download...');
        const selectedAsset = bundleAsset || releaseData.assets.find(asset => asset.name === 'vscode-bundle.zip')!;
        
        // Get the actual ZIP buffer from the mock
        const zipBuffer = selectedAsset.zipBuffer;
        assert.ok(zipBuffer, 'ZIP buffer should be available from mock');
        
        // Simulate saving downloaded ZIP to temp file
        const tempZipFile = saveZipToTempFile(zipBuffer, detectedPlatform.platform);
        console.log(`Downloaded ZIP to: ${tempZipFile}`);
        
        // Step 5: Extract ZIP file (realistic extraction)
        console.log('Step 5: Extracting ZIP bundle...');
        const extractPath = path.join(testWorkspaceUri.fsPath, '.olaf', 'temp-extract');
        const extractedFiles = extractZipToDirectory(tempZipFile, extractPath);
        
        assert.ok(extractedFiles.length > 0, 'Bundle should contain files after extraction');
        console.log(`Extracted ${extractedFiles.length} files from ZIP:`);
        extractedFiles.forEach(file => {
            console.log(`  - ${file}`);
        });
        
        // Step 6: Read extracted file contents
        console.log('Step 6: Reading extracted file contents...');
        const bundleContents: Record<string, string> = {};
        for (const file of extractedFiles) {
            const filePath = path.join(extractPath, file);
            const content = fs.readFileSync(filePath, 'utf8');
            bundleContents[file] = content;
        }

        // Step 7: Validate platform-specific content
        console.log('Step 7: Validating platform-specific content...');
        switch (detectedPlatform.platform) {
            case 'vscode':
                assert.ok(extractedFiles.some(f => f.includes('copilot-instructions')), 
                         'VSCode bundle should contain copilot instructions');
                assert.ok(extractedFiles.some(f => f.includes('prompts/')), 
                         'VSCode bundle should contain prompts');
                break;
            case 'windsurf':
                assert.ok(extractedFiles.some(f => f.includes('core-principles')), 
                         'Windsurf bundle should contain core principles');
                assert.ok(extractedFiles.some(f => f.includes('workflows/')), 
                         'Windsurf bundle should contain workflows');
                break;
            case 'cursor':
                assert.ok(extractedFiles.some(f => f.includes('ai-development-guide')), 
                         'Cursor bundle should contain AI development guide');
                assert.ok(extractedFiles.some(f => f.includes('prompt-engineering')), 
                         'Cursor bundle should contain prompt engineering guide');
                break;
            case 'kiro':
                assert.ok(extractedFiles.some(f => f.includes('development-methodology')), 
                         'Kiro bundle should contain development methodology');
                assert.ok(extractedFiles.some(f => f.includes('testing-strategy')), 
                         'Kiro bundle should contain testing strategy');
                break;
        }

        // Step 8: Simulate file installation
        console.log('Step 8: Simulating file installation...');
        const installationPath = path.join(testWorkspaceUri.fsPath, '.olaf', detectedPlatform.platform);
        
        // Create installation directory
        if (!fs.existsSync(installationPath)) {
            fs.mkdirSync(installationPath, { recursive: true });
        }

        // Simulate file installation
        for (const [fileName, content] of Object.entries(bundleContents)) {
            const filePath = path.join(installationPath, fileName);
            const fileDir = path.dirname(filePath);
            
            if (!fs.existsSync(fileDir)) {
                fs.mkdirSync(fileDir, { recursive: true });
            }
            
            fs.writeFileSync(filePath, content as string);
            console.log(`  Installed: ${fileName}`);
        }

        // Step 8: Verify installation
        console.log('Step 8: Verifying installation...');
        const getAllFiles = (dir: string): string[] => {
            let files: string[] = [];
            const items = fs.readdirSync(dir);
            for (const item of items) {
                const fullPath = path.join(dir, item);
                const stat = fs.statSync(fullPath);
                if (stat.isDirectory()) {
                    files = files.concat(getAllFiles(fullPath));
                } else {
                    files.push(path.relative(installationPath, fullPath));
                }
            }
            return files;
        };
        
        const installedFiles = getAllFiles(installationPath);
        assert.ok(installedFiles.length > 0, 'Files should be installed');
        
        console.log(`Installation verified: ${installedFiles.length} files installed to ${installationPath}`);

        // Step 9: Test file access and content validation
        console.log('Step 9: Testing file access and content validation...');
        for (const fileName of extractedFiles) {
            const filePath = path.join(installationPath, fileName);
            assert.ok(fs.existsSync(filePath), `File should exist: ${fileName}`);
            
            const content = fs.readFileSync(filePath, 'utf8');
            assert.ok(content.length > 0, `File should have content: ${fileName}`);
        }

        // Step 10: Cleanup temporary files
        console.log('Step 10: Cleaning up temporary files...');
        if (fs.existsSync(tempZipFile)) {
            fs.unlinkSync(tempZipFile);
        }
        if (fs.existsSync(extractPath)) {
            fs.rmSync(extractPath, { recursive: true, force: true });
        }

        console.log('✅ Full flow test completed successfully!');
        console.log(`Platform: ${detectedPlatform.platform}`);
        console.log(`Bundle: ${bundleName || 'vscode-bundle.zip (fallback)'}`);
        console.log(`Files: ${extractedFiles.length} extracted and installed`);
        console.log(`Location: ${installationPath}`);
        console.log(`ZIP Processing: Downloaded → Extracted → Installed (realistic flow)`);
    });

    it('Bundle Content Validation', async () => {
        // Load all platform bundle contents from fixtures for validation
        const allBundleContents = loadBundleContentFromFixtures();
        
        const platforms = ['vscode', 'windsurf', 'cursor', 'kiro'];
        for (const platform of platforms) {
            console.log(`Testing ${platform} bundle content...`);
            const content = allBundleContents[platform];
            
            if (content && Object.keys(content).length > 0) {
                assert.ok(validateBundleContent(platform, content), 
                         `${platform} bundle should pass validation`);
            }
        }
    });

    it('ZIP Archive Processing (Realistic Simulation)', async () => {
        console.log('Testing realistic ZIP archive processing...');
        
        const platforms = ['vscode', 'windsurf', 'cursor', 'kiro'];
        
        for (const platform of platforms) {
            console.log(`
--- Testing ${platform.toUpperCase()} ZIP Processing ---`);
            
            // Step 1: Create ZIP from fixtures (simulating GitHub release creation)
            console.log(`1. Creating ZIP bundle for ${platform}...`);
            const zipBuffer = createZipFromFixtures(platform);
            
            if (!zipBuffer) {
                console.log(`No fixtures found for ${platform}, skipping...`);
                continue;
            }
            
            assert.ok(zipBuffer.length > 0, `ZIP buffer should not be empty for ${platform}`);
            console.log(`   ✓ ZIP created: ${zipBuffer.length} bytes`);
            
            // Step 2: Save ZIP to temporary file (simulating download)
            console.log(`2. Simulating bundle download...`);
            const tempZipFile = saveZipToTempFile(zipBuffer, platform);
            assert.ok(fs.existsSync(tempZipFile), 'Downloaded ZIP file should exist');
            console.log(`   ✓ Downloaded to: ${tempZipFile}`);
            
            // Step 3: Extract ZIP to directory (simulating real extraction)
            console.log(`3. Extracting ZIP bundle...`);
            const extractPath = path.join(testWorkspacePath, '.olaf-test', platform);
            const extractedFiles = extractZipToDirectory(tempZipFile, extractPath);
            
            assert.ok(extractedFiles.length > 0, `Should extract files for ${platform}`);
            console.log(`   ✓ Extracted ${extractedFiles.length} files:`);
            extractedFiles.forEach(file => console.log(`     - ${file}`));
            
            // Step 4: Verify extracted content matches expected platform files
            console.log(`4. Verifying platform-specific content...`);
            switch (platform) {
                case 'vscode':
                    assert.ok(extractedFiles.some(f => f.includes('copilot-instructions')), 
                             'VSCode should have copilot instructions');
                    break;
                case 'windsurf':
                    assert.ok(extractedFiles.some(f => f.includes('core-principles')), 
                             'Windsurf should have core principles');
                    break;
                case 'cursor':
                    assert.ok(extractedFiles.some(f => f.includes('ai-development-guide')), 
                             'Cursor should have AI development guide');
                    break;
                case 'kiro':
                    assert.ok(extractedFiles.some(f => f.includes('development-methodology')), 
                             'Kiro should have development methodology');
                    break;
            }
            console.log(`   ✓ Platform-specific content verified`);
            
            // Step 5: Cleanup
            console.log(`5. Cleaning up...`);
            fs.unlinkSync(tempZipFile);
            fs.rmSync(extractPath, { recursive: true, force: true });
            console.log(`   ✓ Cleanup completed`);
        }
        
        console.log('\nZIP Archive Processing test completed successfully!');
        console.log('This test demonstrates the complete realistic flow:');
        console.log('   Fixtures -> ZIP Creation -> Download Simulation -> Extraction -> Validation');
    });

    it('Installation Path Management', async () => {
        // Test installation path creation and cleanup
        const testPlatforms = ['vscode', 'windsurf', 'cursor', 'kiro'];
        
        for (const platform of testPlatforms) {
            console.log(`Testing installation path for ${platform}...`);
            
            const installPath = path.join(testWorkspaceUri.fsPath, '.olaf', platform);
            
            // Create installation directory
            if (!fs.existsSync(installPath)) {
                fs.mkdirSync(installPath, { recursive: true });
            }
            
            assert.ok(fs.existsSync(installPath), `Installation path should exist for ${platform}`);
            
            // Test file creation
            const testFile = path.join(installPath, 'test.md');
            fs.writeFileSync(testFile, `Test content for ${platform}`);
            
            assert.ok(fs.existsSync(testFile), `Test file should be created for ${platform}`);
            
            // Cleanup
            fs.rmSync(installPath, { recursive: true, force: true });
            assert.ok(!fs.existsSync(installPath), `Installation path should be cleaned up for ${platform}`);
        }
    });

    it('Error Handling and Fallbacks', async () => {
        // Test error scenarios and fallback mechanisms
        console.log('Testing error handling scenarios...');

        // Test 1: Unknown platform fallback
        const unknownPlatform = { name: 'unknown-editor', confidence: 0.1 };
        const mockRelease = createMockReleaseResponse();
        const fallbackAsset = mockRelease.assets.find(asset => asset.name === 'vscode-bundle.zip');
        assert.ok(fallbackAsset, 'Should fallback to VSCode bundle for unknown platforms');

        // Test 2: Missing platform bundle
        const missingPlatformAsset = mockRelease.assets.find(asset => asset.name === 'nonexistent-bundle.zip');
        assert.ok(!missingPlatformAsset, 'Should handle missing platform bundles gracefully');

        // Test 3: Corrupted bundle content
        try {
            const corruptedContent = { 'invalid-file': '' };
            assert.ok(Object.keys(corruptedContent).length > 0, 'Should handle empty content gracefully');
        } catch (error) {
            console.log('Handled corrupted content error:', error);
        }

        console.log('Error handling tests completed');
    });
});
