// Test the integrity calculation with the new hash fallback
const path = require('path');

// Create a test file
const fs = require('fs');
const testFilePath = '/tmp/olaf_test_file.txt';
const testContent = 'This is a test file for OLAF integrity calculation.\nVersion 0.0.6 with hash fallback mechanism.\n';

fs.writeFileSync(testFilePath, testContent);

console.log('=== OLAF v0.0.6 Integrity Test ===');
console.log('Test file:', testFilePath);
console.log('Test file size:', fs.statSync(testFilePath).size, 'bytes');

// Test the FileIntegrityService
const { FileIntegrityService } = require('./out/services/fileIntegrityService');

async function testIntegrity() {
    const service = new FileIntegrityService();
    
    console.log('\n=== Testing calculateFileIntegrity ===');
    try {
        const result = await service.calculateFileIntegrity(testFilePath);
        console.log('✅ Integrity calculation succeeded:');
        console.log('  Path:', result.path);
        console.log('  SHA256:', result.sha256);
        console.log('  Secondary hash (blake2b256):', result.xxhash64);
        console.log('  Size:', result.size);
        console.log('  Permissions:', result.permissions);
        console.log('  Executable:', result.isExecutable);
        console.log('  Symlink:', result.isSymlink);
    } catch (error) {
        console.log('❌ Integrity calculation failed:', error.message);
        console.log('Error stack:', error.stack);
    }
    
    // Cleanup
    fs.unlinkSync(testFilePath);
    console.log('\n✅ Test completed, cleanup done');
}

testIntegrity().catch(console.error);
