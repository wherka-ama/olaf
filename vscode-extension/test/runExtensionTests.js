const path = require('path');
const { runTests } = require('@vscode/test-electron');

async function main() {
  try {
    // The folder containing the Extension Manifest package.json
    const extensionDevelopmentPath = path.resolve(__dirname, '../');
    // The path to the test suite
    const extensionTestsPath = path.resolve(__dirname, '../test-dist/test/index.js');
    await runTests({ extensionDevelopmentPath, extensionTestsPath });
  } catch (err) {
    console.error('Failed to run extension tests');
    process.exit(1);
  }
}

main();
