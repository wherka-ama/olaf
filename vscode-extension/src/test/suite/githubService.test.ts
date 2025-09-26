import * as assert from 'assert';
import * as vscode from 'vscode';
import { GitHubService } from '../../services/githubService';
import { Platform } from '../../types/platform';

describe('GitHubService Tests', () => {
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
    });

    it('Should get release by tag', async () => {
        // First get the latest release to use its tag
        const latestRelease = await githubService.getLatestRelease();
        const release = await githubService.getReleaseByTag(latestRelease.tag_name);
        
        assert.ok(release);
        assert.strictEqual(release.tag_name, latestRelease.tag_name);
    });

    it('Should find platform bundle', async () => {
        const release = await githubService.getLatestRelease();
        
        // Try to find bundles for different platforms
        const platforms = [Platform.VSCODE, Platform.WINDSURF, Platform.CURSOR, Platform.KIRO];
        
        for (const platform of platforms) {
            const bundle = githubService.findPlatformBundle(release, platform);
            // Bundle may or may not exist for each platform, but method should not throw
            assert.ok(bundle === null || bundle.filename);
        }
    });

    it('Should get all bundles', async () => {
        const release = await githubService.getLatestRelease();
        const bundles = githubService.getAllBundles(release);
        
        assert.ok(Array.isArray(bundles));
        // There should be at least some bundles
        if (bundles.length > 0) {
            assert.ok(bundles[0].filename);
            assert.ok(bundles[0].downloadUrl);
        }
    });

    it('Should parse version', () => {
        const version1 = githubService.parseVersion('v1.2.3');
        const version2 = githubService.parseVersion('1.2.3-beta');
        const version3 = githubService.parseVersion('invalid');
        
        assert.ok(version1);
        assert.strictEqual(version1.major, 1);
        assert.strictEqual(version1.minor, 2);
        assert.strictEqual(version1.patch, 3);
        
        assert.ok(version2);
        assert.strictEqual(version2.prerelease, 'beta');
        
        assert.strictEqual(version3, null);
    });

    it('Should compare versions', () => {
        assert.strictEqual(githubService.compareVersions('1.2.3', '1.2.3'), 0);
        assert.strictEqual(githubService.compareVersions('1.2.4', '1.2.3'), 1);
        assert.strictEqual(githubService.compareVersions('1.2.2', '1.2.3'), -1);
        
        assert.ok(githubService.isNewerVersion('1.2.4', '1.2.3'));
        assert.ok(!githubService.isNewerVersion('1.2.2', '1.2.3'));
    });

    it('Should check connectivity', async () => {
        const isConnected = await githubService.checkConnectivity();
        assert.ok(typeof isConnected === 'boolean');
    });

    it('Should return singleton instance', () => {
        const service1 = GitHubService.getInstance();
        const service2 = GitHubService.getInstance();
        
        assert.strictEqual(service1, service2);
    });
});
