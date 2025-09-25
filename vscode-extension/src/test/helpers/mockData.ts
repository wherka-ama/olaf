/**
 * Mock data and utilities for testing OLAF bundle functionality
 */
import AdmZip = require('adm-zip');
import * as path from 'path';
import * as fs from 'fs';
import * as os from 'os';

export interface MockBundleAsset {
    id: number;
    name: string;
    browser_download_url: string;
    size: number;
    content_type: string;
    zipBuffer?: Buffer; // Add ZIP buffer for realistic simulation
}

export interface MockReleaseResponse {
    id: number;
    tag_name: string;
    name: string;
    published_at: string;
    assets: MockBundleAsset[];
}

/**
 * Create actual ZIP files from fixture content
 */
export const createZipFromFixtures = (platform: string): Buffer | null => {
    const fixturesPath = getFixturesPath();
    if (!fixturesPath) {
        return null;
    }
    
    const platformPath = path.join(fixturesPath, `${platform}-bundle`);
    if (!fs.existsSync(platformPath)) {
        return null;
    }
    
    const zip = new AdmZip();
    
    const addFilesRecursively = (dir: string, relativePath: string = '') => {
        try {
            const items = fs.readdirSync(dir);
            for (const item of items) {
                const fullPath = path.join(dir, item);
                const relativeFilePath = relativePath ? path.join(relativePath, item) : item;
                
                if (fs.statSync(fullPath).isDirectory()) {
                    addFilesRecursively(fullPath, relativeFilePath);
                } else {
                    const content = fs.readFileSync(fullPath);
                    zip.addFile(relativeFilePath, content);
                }
            }
        } catch (error) {
            console.error(`Error creating ZIP for ${platform}:`, error);
        }
    };
    
    addFilesRecursively(platformPath);
    return zip.toBuffer();
};

/**
 * Extract ZIP buffer to get file contents (simulating real download + extraction)
 */
export const extractZipToContents = (zipBuffer: Buffer): Record<string, string> => {
    const zip = new AdmZip(zipBuffer);
    const entries = zip.getEntries();
    const contents: Record<string, string> = {};
    
    entries.forEach((entry: any) => {
        if (!entry.isDirectory) {
            contents[entry.entryName] = entry.getData().toString('utf8');
        }
    });
    
    return contents;
};

/**
 * Save ZIP to temporary file (simulating actual download)
 */
export const saveZipToTempFile = (zipBuffer: Buffer, platform: string): string => {
    const tempDir = os.tmpdir();
    const tempFile = path.join(tempDir, `olaf-test-${platform}-${Date.now()}.zip`);
    fs.writeFileSync(tempFile, zipBuffer);
    return tempFile;
};

/**
 * Extract ZIP file to directory (simulating real extraction process)
 */
export const extractZipToDirectory = (zipFilePath: string, extractPath: string): string[] => {
    const zip = new AdmZip(zipFilePath);
    
    if (!fs.existsSync(extractPath)) {
        fs.mkdirSync(extractPath, { recursive: true });
    }
    
    zip.extractAllTo(extractPath, true);
    
    // Return list of extracted files
    const extractedFiles: string[] = [];
    const scanDirectory = (dir: string, relativePath: string = '') => {
        const items = fs.readdirSync(dir);
        for (const item of items) {
            const fullPath = path.join(dir, item);
            const relativeFilePath = relativePath ? path.join(relativePath, item) : item;
            
            if (fs.statSync(fullPath).isDirectory()) {
                scanDirectory(fullPath, relativeFilePath);
            } else {
                extractedFiles.push(relativeFilePath);
            }
        }
    };
    
    scanDirectory(extractPath);
    return extractedFiles;
};

/**
 * Helper to get fixtures path
 */
const getFixturesPath = (): string | null => {
    // Try multiple possible paths for fixtures
    const possiblePaths = [
        path.join(__dirname, '..', '..', '..', 'test', 'fixtures', 'platform-bundles'),
        path.join(__dirname, '..', '..', '..', '..', 'test', 'fixtures', 'platform-bundles'),
        path.join(process.cwd(), 'test', 'fixtures', 'platform-bundles')
    ];
    
    for (const testPath of possiblePaths) {
        if (fs.existsSync(testPath)) {
            return testPath;
        }
    }
    
    return null;
};

/**
 * Mock GitHub release response simulating OLAF bundle releases with actual ZIP data
 */
export const createMockReleaseResponse = (version: string = 'v1.2.3'): MockReleaseResponse => {
    const platforms = ['vscode', 'windsurf', 'cursor', 'kiro'];
    const assets: MockBundleAsset[] = [];
    
    platforms.forEach((platform, index) => {
        const zipBuffer = createZipFromFixtures(platform);
        assets.push({
            id: index + 1,
            name: `${platform}-bundle.zip`,
            browser_download_url: `https://github.com/test-owner/test-repo/releases/download/${version}/${platform}-bundle.zip`,
            size: zipBuffer ? zipBuffer.length : 4096,
            content_type: 'application/zip',
            zipBuffer: zipBuffer || undefined
        });
    });
    
    return {
        id: 123456,
        tag_name: version,
        name: `OLAF Bundle Release ${version}`,
        published_at: '2025-09-16T08:00:00Z',
        assets
    };
};

/**
 * Load actual file content from test fixtures
 */
export const loadBundleContentFromFixtures = (): Record<string, Record<string, string>> => {
    const path = require('path');
    const fs = require('fs');
    
    // Try multiple possible paths for fixtures
    const possiblePaths = [
        path.join(__dirname, '..', '..', '..', 'test', 'fixtures', 'platform-bundles'),
        path.join(__dirname, '..', '..', '..', '..', 'test', 'fixtures', 'platform-bundles'),
        path.join(process.cwd(), 'test', 'fixtures', 'platform-bundles')
    ];
    
    let fixturesPath = '';
    for (const testPath of possiblePaths) {
        if (fs.existsSync(testPath)) {
            fixturesPath = testPath;
            break;
        }
    }
    
    if (!fixturesPath) {
        console.log('No fixtures found, returning empty bundles');
        return {
            vscode: { 'copilot-instructions.md': 'Mock VSCode content' },
            windsurf: { 'core-principles.md': 'Mock Windsurf content' },
            cursor: { 'ai-development-guide.md': 'Mock Cursor content' },
            kiro: { 'development-methodology.md': 'Mock Kiro content' }
        };
    }
    
    console.log(`Loading fixtures from: ${fixturesPath}`);
    const bundles: Record<string, Record<string, string>> = {};
    
    const platforms = ['vscode', 'windsurf', 'cursor', 'kiro'];
    
    for (const platform of platforms) {
        const platformPath = path.join(fixturesPath, `${platform}-bundle`);
        bundles[platform] = {};
        
        if (fs.existsSync(platformPath)) {
            const loadFilesRecursively = (dir: string, relativePath: string = '') => {
                try {
                    const items = fs.readdirSync(dir);
                    for (const item of items) {
                        const fullPath = path.join(dir, item);
                        const relativeFilePath = relativePath ? path.join(relativePath, item) : item;
                        
                        if (fs.statSync(fullPath).isDirectory()) {
                            loadFilesRecursively(fullPath, relativeFilePath);
                        } else {
                            const content = fs.readFileSync(fullPath, 'utf8');
                            bundles[platform][relativeFilePath] = content;
                            console.log(`Loaded: ${platform}/${relativeFilePath}`);
                        }
                    }
                } catch (error) {
                    console.error(`Error loading files from ${dir}:`, error);
                }
            };
            
            loadFilesRecursively(platformPath);
        }
    }
    
    return bundles;
};

/**
 * Validate that a bundle contains expected platform-specific content
 */
export const validateBundleContent = (platform: string, files: Record<string, string>): boolean => {
    const validationRules = {
        vscode: {
            requiredFiles: ['copilot-instructions.md'],
            requiredKeywords: ['VSCode', 'extension', 'TypeScript'],
            optionalFiles: ['prompts/development-assistant.md', 'prompts/debugging-expert.md']
        },
        windsurf: {
            requiredFiles: ['core-principles.md'],
            requiredKeywords: ['Windsurf', 'collaborative', 'cascade'],
            optionalFiles: ['workflows/full-stack-development.md']
        },
        cursor: {
            requiredFiles: ['ai-development-guide.md'],
            requiredKeywords: ['Cursor', 'AI', 'prediction'],
            optionalFiles: ['prompt-engineering.md']
        },
        kiro: {
            requiredFiles: ['development-methodology.md'],
            requiredKeywords: ['Kiro', 'rapid', 'iteration'],
            optionalFiles: ['testing-strategy.md']
        }
    };
    
    const rules = validationRules[platform as keyof typeof validationRules];
    if (!rules) {
        return false;
    }
    
    // Check required files
    for (const requiredFile of rules.requiredFiles) {
        if (!Object.prototype.hasOwnProperty.call(files, requiredFile)) {
            return false;
        }
    }
    
    // Check for required keywords in content
    const allContent = Object.values(files).join(' ').toLowerCase();
    for (const keyword of rules.requiredKeywords) {
        if (!allContent.includes(keyword.toLowerCase())) {
            return false;
        }
    }
    
    return true;
};

/**
 * Create a temporary workspace directory for testing
 */
export const createTestWorkspace = (): string => {
    const path = require('path');
    const fs = require('fs');
    const os = require('os');
    
    const testDir = path.join(os.tmpdir(), `olaf-test-${Date.now()}`);
    fs.mkdirSync(testDir, { recursive: true });
    
    return testDir;
};

/**
 * Clean up test workspace
 */
export const cleanupTestWorkspace = (workspacePath: string): void => {
    const fs = require('fs');
    
    if (fs.existsSync(workspacePath)) {
        fs.rmSync(workspacePath, { recursive: true, force: true });
    }
};
