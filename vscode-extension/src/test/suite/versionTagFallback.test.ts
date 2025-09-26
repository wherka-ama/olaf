import * as assert from 'assert';
import { GitHubService } from '../../services/githubService';

// Use require for nock as it's already configured in the test setup
const nock = require('nock');

describe('Version Tag Fallback Tests', () => {
  let githubService: GitHubService;

  beforeEach(() => {
    // Reset the singleton before each test
    GitHubService.resetInstance();
    githubService = GitHubService.getInstance();
  });

  afterEach(() => {
    // Clean up any pending HTTP mocks
    nock.cleanAll();
    GitHubService.resetInstance();
  });

  it('Should find release with v-prefixed tag when user provides non-prefixed version', async () => {
    // Mock the first attempt (without v prefix) to fail
    nock('https://api.github.com')
      .get('/repos/test-owner/test-repo/releases/tags/0.0.1')
      .reply(404, { message: 'Not Found' });

    // Mock the second attempt (with v prefix) to succeed
    nock('https://api.github.com')
      .get('/repos/test-owner/test-repo/releases/tags/v0.0.1')
      .reply(200, {
        id: 12345,
        tag_name: 'v0.0.1',
        name: 'Release v0.0.1',
        body: 'Test release',
        draft: false,
        prerelease: false,
        created_at: '2025-01-01T00:00:00Z',
        published_at: '2025-01-01T00:00:00Z',
        assets: [],
        html_url: 'https://github.com/test-owner/test-repo/releases/tag/v0.0.1',
        tarball_url: 'https://api.github.com/repos/test-owner/test-repo/tarball/v0.0.1',
        zipball_url: 'https://api.github.com/repos/test-owner/test-repo/zipball/v0.0.1'
      });

    const release = await githubService.getReleaseByVersionPreference('0.0.1');
    
    assert.strictEqual(release.tag_name, 'v0.0.1');
    assert.strictEqual(release.name, 'Release v0.0.1');
  });

  it('Should find release with non-prefixed tag when user provides v-prefixed version', async () => {
    // Mock the first attempt (with v prefix) to fail
    nock('https://api.github.com')
      .get('/repos/test-owner/test-repo/releases/tags/v1.0.0')
      .reply(404, { message: 'Not Found' });

    // Mock the second attempt (without v prefix) to succeed
    nock('https://api.github.com')
      .get('/repos/test-owner/test-repo/releases/tags/1.0.0')
      .reply(200, {
        id: 12346,
        tag_name: '1.0.0',
        name: 'Release 1.0.0',
        body: 'Test release without v prefix',
        draft: false,
        prerelease: false,
        created_at: '2025-01-01T00:00:00Z',
        published_at: '2025-01-01T00:00:00Z',
        assets: [],
        html_url: 'https://github.com/test-owner/test-repo/releases/tag/1.0.0',
        tarball_url: 'https://api.github.com/repos/test-owner/test-repo/tarball/1.0.0',
        zipball_url: 'https://api.github.com/repos/test-owner/test-repo/zipball/1.0.0'
      });

    const release = await githubService.getReleaseByVersionPreference('v1.0.0');
    
    assert.strictEqual(release.tag_name, '1.0.0');
    assert.strictEqual(release.name, 'Release 1.0.0');
  });

  it('Should find release immediately if exact tag exists', async () => {
    // Mock successful first attempt
    nock('https://api.github.com')
      .get('/repos/test-owner/test-repo/releases/tags/v2.0.0')
      .reply(200, {
        id: 12347,
        tag_name: 'v2.0.0',
        name: 'Release v2.0.0',
        body: 'Test release with exact match',
        draft: false,
        prerelease: false,
        created_at: '2025-01-01T00:00:00Z',
        published_at: '2025-01-01T00:00:00Z',
        assets: [],
        html_url: 'https://github.com/test-owner/test-repo/releases/tag/v2.0.0',
        tarball_url: 'https://api.github.com/repos/test-owner/test-repo/tarball/v2.0.0',
        zipball_url: 'https://api.github.com/repos/test-owner/test-repo/zipball/v2.0.0'
      });

    const release = await githubService.getReleaseByVersionPreference('v2.0.0');
    
    assert.strictEqual(release.tag_name, 'v2.0.0');
    assert.strictEqual(release.name, 'Release v2.0.0');
    
    // Verify no additional HTTP calls were made (no fallback needed)
    assert.ok(nock.isDone());
  });

  it('Should throw helpful error when neither tag format exists', async () => {
    // Mock both attempts to fail
    nock('https://api.github.com')
      .get('/repos/test-owner/test-repo/releases/tags/3.0.0')
      .reply(404, { message: 'Not Found' });

    nock('https://api.github.com')
      .get('/repos/test-owner/test-repo/releases/tags/v3.0.0')
      .reply(404, { message: 'Not Found' });

    try {
      await githubService.getReleaseByVersionPreference('3.0.0');
      assert.fail('Expected method to throw an error');
    } catch (error) {
      assert.ok(error instanceof Error);
      assert.ok(error.message.includes('Release not found for version "3.0.0"'));
      assert.ok(error.message.includes('Please check that this version exists'));
    }
  });

  it('Should handle latest version correctly without fallback', async () => {
    // Mock latest release request
    nock('https://api.github.com')
      .get('/repos/test-owner/test-repo/releases/latest')
      .reply(200, {
        id: 12348,
        tag_name: 'v3.1.0',
        name: 'Latest Release v3.1.0',
        body: 'Latest test release',
        draft: false,
        prerelease: false,
        created_at: '2025-01-01T00:00:00Z',
        published_at: '2025-01-01T00:00:00Z',
        assets: [],
        html_url: 'https://github.com/test-owner/test-repo/releases/tag/v3.1.0',
        tarball_url: 'https://api.github.com/repos/test-owner/test-repo/tarball/v3.1.0',
        zipball_url: 'https://api.github.com/repos/test-owner/test-repo/zipball/v3.1.0'
      });

    const release = await githubService.getReleaseByVersionPreference('latest');
    
    assert.strictEqual(release.tag_name, 'v3.1.0');
    assert.strictEqual(release.name, 'Latest Release v3.1.0');
  });
});
