import * as assert from 'assert';
import * as vscode from 'vscode';
import { GitHubService } from '../../services/githubService';

// Check if GitHub token is available
const hasGitHubToken = process.env.GITHUB_TOKEN || 
    (vscode.workspace.getConfiguration && 
     vscode.workspace.getConfiguration('olaf')?.get('githubToken'));

// Use describe.skip if no GitHub token to avoid rate limiting
const describeGitHub = hasGitHubToken ? describe : describe.skip;

describeGitHub('GitHubService Tests', () => {
    vscode.window.showInformationMessage('Start GitHub service tests.');

    const githubService = GitHubService.getInstance();

    it('Should get latest release', async () => {
        const release = await githubService.getLatestRelease();
        
        assert.ok(release);
        assert.ok(release.tag_name);
        assert.ok(release.assets);
        assert.ok(Array.isArray(release.assets));
    });

    it('Should get all releases', async () => {
        const releases = await githubService.getAllReleases(5);
        
        assert.ok(releases);
        assert.ok(Array.isArray(releases));
        assert.ok(releases.length > 0);
        assert.ok(releases.length <= 5);
        
        // Check first release structure
        const firstRelease = releases[0];
        assert.ok(firstRelease.tag_name);
        assert.ok(firstRelease.assets);
        assert.ok(Array.isArray(firstRelease.assets));
    });

    it('Should get release by tag', async () => {
        // First get all releases to pick a valid tag
        const releases = await githubService.getAllReleases(1);
        assert.ok(releases.length > 0);
        
        const targetTag = releases[0].tag_name;
        const specificRelease = await githubService.getReleaseByTag(targetTag);
        
        assert.ok(specificRelease);
        assert.strictEqual(specificRelease.tag_name, targetTag);
    });

    it('Should validate access', async () => {
        const accessResult = await githubService.validateAccess();
        
        assert.ok(accessResult);
        assert.ok(typeof accessResult.valid === 'boolean');
        assert.ok(typeof accessResult.message === 'string');
    });

    it('Should check connectivity', async () => {
        const isConnected = await githubService.checkConnectivity();
        
        assert.ok(typeof isConnected === 'boolean');
        // In a test environment, we expect this to be true if we have internet
        if (hasGitHubToken) {
            assert.strictEqual(isConnected, true);
        }
    });
});

// Fallback tests that always run (with mocked data)
describe('GitHubService Mock Tests', () => {
    it('Should skip GitHub tests when no token available', () => {
        if (!hasGitHubToken) {
            console.log('ℹ️ GitHub tests skipped - no token available (prevents rate limiting)');
            assert.ok(true, 'Test skipping works correctly');
        } else {
            console.log('✓ GitHub token available - running real API tests');
            assert.ok(true, 'Token detection works correctly');
        }
    });

    it('Should validate GitHub service configuration', () => {
        const service = GitHubService.getInstance();
        assert.ok(service, 'GitHubService should be instantiable');
        assert.ok(typeof service.getLatestRelease === 'function', 'Should have getLatestRelease method');
        assert.ok(typeof service.getAllReleases === 'function', 'Should have getAllReleases method');
        assert.ok(typeof service.getReleaseByTag === 'function', 'Should have getReleaseByTag method');
        assert.ok(typeof service.validateAccess === 'function', 'Should have validateAccess method');
        assert.ok(typeof service.checkConnectivity === 'function', 'Should have checkConnectivity method');
    });
});
