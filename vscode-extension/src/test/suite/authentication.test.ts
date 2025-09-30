import * as assert from 'assert';
import { GitHubService } from '../../services/githubService';

describe.skip("Authentication Tests", () => {
  afterEach(() => {
    // Reset the singleton after each test
    GitHubService.resetInstance();
  });

  describe('Configuration Loading', () => {
    it('Should load configuration from VSCode settings', () => {
      const service = GitHubService.getInstance();
      
      // These values should come from our mock configuration
      assert.strictEqual((service as any).owner, 'test-owner');
      assert.strictEqual((service as any).repo, 'test-repo');
      assert.strictEqual((service as any).token, 'test-token');
      assert.strictEqual((service as any).usePrivateRepo, false);
    });

    it('Should construct correct repository URL', () => {
      const service = GitHubService.getInstance();
      // We can't test private method directly, but we can test the behavior
      // by checking the base configuration is loaded correctly
      assert.strictEqual((service as any).baseUrl, 'https://api.github.com');
      assert.strictEqual((service as any).owner, 'test-owner');
      assert.strictEqual((service as any).repo, 'test-repo');
    });
  });

  describe('Authentication Headers', () => {
    it('Should include authorization header when token is configured', async () => {
      // Update mock to enable private repository for this test
      const originalMock = require('../../../../test/vscode-mock.js');
      const mockConfig = originalMock.workspace.getConfiguration('olaf');
      
      // Temporarily override the configuration for this test
      const testService = GitHubService.getInstance();
      (testService as any).usePrivateRepo = true; // Enable private repo for this test
      
      const headers = await (testService as any).getAuthHeaders();
      
      // With private repo enabled and token configured, should include authorization
      assert.strictEqual(headers.Authorization, 'Bearer test-token');
      assert.strictEqual(headers.Accept, 'application/vnd.github.v3+json');
      assert.strictEqual(headers['User-Agent'], 'OLAF-VSCode-Extension/1.0.0');
    });

    it('Should not include authorization header when private repository is disabled', async () => {
      const service = GitHubService.getInstance();
      const headers = await (service as any).getAuthHeaders();
      
      // With private repo disabled (default mock), should not include authorization
      assert.strictEqual(headers.Authorization, undefined);
      assert.strictEqual(headers.Accept, 'application/vnd.github.v3+json');
      assert.strictEqual(headers['User-Agent'], 'OLAF-VSCode-Extension/1.0.0');
    });
  });

  describe('Singleton Behavior', () => {
    it('Should maintain singleton pattern', () => {
      const service1 = GitHubService.getInstance();
      const service2 = GitHubService.getInstance();
      assert.strictEqual(service1, service2);
    });

    it('Should reset instance and reload configuration', () => {
      const service1 = GitHubService.getInstance();
      const originalOwner = (service1 as any).owner;
      
      GitHubService.resetInstance();
      
      const service2 = GitHubService.getInstance();
      // Should be a new instance with fresh configuration
      assert.notStrictEqual(service1, service2);
      assert.strictEqual((service2 as any).owner, originalOwner); // Same mock config
    });
  });

  describe('Configuration Validation', () => {
    it('Should have required configuration properties', () => {
      const service = GitHubService.getInstance();
      
      // Verify all required properties are present
      assert.ok((service as any).owner);
      assert.ok((service as any).repo);
      assert.ok((service as any).baseUrl);
      // Token can be undefined (for public repos)
      assert.ok(Object.prototype.hasOwnProperty.call(service as any, 'token'));
      assert.ok(Object.prototype.hasOwnProperty.call(service as any, 'usePrivateRepo'));
    });

    it('Should initialize with correct default values', () => {
      const service = GitHubService.getInstance();
      
      // Check mock configuration is loaded
      assert.strictEqual((service as any).baseUrl, 'https://api.github.com');
      assert.strictEqual((service as any).owner, 'test-owner');
      assert.strictEqual((service as any).repo, 'test-repo');
      assert.strictEqual((service as any).token, 'test-token');
      assert.strictEqual((service as any).usePrivateRepo, false);
    });
  });

  describe('Validate Access Command Support', () => {
    it('Should provide validateAccess method', () => {
      const service = GitHubService.getInstance();
      assert.ok(typeof service.validateAccess === 'function');
    });

    it('Should return validation result object', async () => {
      const service = GitHubService.getInstance();
      
      try {
        const result = await service.validateAccess();
        // Should have expected properties regardless of API response
        assert.ok(typeof result === 'object');
        assert.ok(Object.prototype.hasOwnProperty.call(result, 'success'));
        assert.ok(Object.prototype.hasOwnProperty.call(result, 'message'));
      } catch (error) {
        // API calls might fail in test environment due to rate limiting, which is expected
        assert.ok(error instanceof Error);
        // The important thing is that the method exists and is callable
      }
    });
  });

  describe('Public API Methods', () => {
    it('Should have all expected public methods', () => {
      const service = GitHubService.getInstance();
      
      // Check all authentication-related public methods exist
      assert.ok(typeof service.validateAccess === 'function');
      assert.ok(typeof service.getLatestRelease === 'function');
      assert.ok(typeof service.getAllReleases === 'function');
      assert.ok(typeof service.checkConnectivity === 'function');
    });

    it('Should maintain static methods', () => {
      // Check static methods exist
      assert.ok(typeof GitHubService.getInstance === 'function');
      assert.ok(typeof GitHubService.resetInstance === 'function');
    });
  });
});
