#!/bin/bash
# Apply comprehensive fixes for integration tests

echo "Applying integration test fixes..."

# 1. Add nock activation to versionTagFallback.test.js
sed -i '29a\// Ensure nock is activated for integration tests\nif (!nock.isActive()) {\n    nock.activate();\n}' test-dist/src/test/suite/versionTagFallback.test.js

# 2. Update repository URLs from test-owner/test-repo to AmadeusITGroup/olaf
sed -i 's/test-owner\/test-repo/AmadeusITGroup\/olaf/g' test-dist/src/test/suite/versionTagFallback.test.js

# 3. Similarly, add nock activation to other test files that make HTTP requests
for testfile in test-dist/src/test/suite/*.test.js; do
    if grep -q "githubService" "$testfile" && ! grep -q "nock.activate" "$testfile"; then
        sed -i '1a\const nock = require("nock");\nif (!nock.isActive()) { nock.activate(); }' "$testfile"
        echo "Added nock activation to $testfile"
    fi
done

# 4. Add comprehensive GitHub API mocks to githubService.test.js
if ! grep -q "nock.*AmadeusITGroup" test-dist/src/test/suite/githubService.test.js; then
    sed -i '/describe.*GitHubService Tests/a\
    beforeEach(() => {\
        // Setup comprehensive GitHub API mocks\
        nock("https://api.github.com")\
            .persist()\
            .get("/repos/AmadeusITGroup/olaf/releases/latest")\
            .reply(200, {\
                tag_name: "v1.0.0",\
                name: "Mock Latest Release",\
                body: "Mock release description",\
                published_at: "2023-01-01T00:00:00Z",\
                assets: []\
            });\
        nock("https://api.github.com")\
            .persist()\
            .get("/repos/AmadeusITGroup/olaf/releases")\
            .reply(200, [{\
                tag_name: "v1.0.0",\
                name: "Mock Release",\
                published_at: "2023-01-01T00:00:00Z"\
            }]);\
        nock("https://api.github.com")\
            .persist()\
            .get(/\/repos\/AmadeusITGroup\/olaf\/releases\/tags\/.*$/)\
            .reply(200, {\
                tag_name: "v1.0.0",\
                name: "Mock Tagged Release",\
                published_at: "2023-01-01T00:00:00Z"\
            });\
    });' test-dist/src/test/suite/githubService.test.js
    echo "Added comprehensive mocks to githubService.test.js"
fi

echo "Integration test fixes applied successfully"
