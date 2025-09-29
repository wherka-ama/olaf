// Test hash algorithm fallback mechanism
const crypto = require('crypto');

console.log('=== Hash Algorithm Fallback Test ===');
console.log('Available hash algorithms:', crypto.getHashes().filter(h => 
    h.includes('blake') || h.includes('sha')).sort());

// Test BLAKE2b availability
console.log('\n=== Testing BLAKE2b512 ===');
try {
    const blake2bHash = crypto.createHash('blake2b512');
    blake2bHash.update('test');
    const result = blake2bHash.digest('hex');
    console.log('✅ BLAKE2b512 works:', result.substring(0, 64));
} catch (error) {
    console.log('❌ BLAKE2b512 failed:', error.message);
    
    // Test SHA-512 fallback
    console.log('\n=== Testing SHA-512 fallback ===');
    try {
        const sha512Hash = crypto.createHash('sha512');
        sha512Hash.update('test');
        const result = sha512Hash.digest('hex');
        console.log('✅ SHA-512 fallback works:', result.substring(0, 64));
    } catch (fallbackError) {
        console.log('❌ SHA-512 fallback also failed:', fallbackError.message);
    }
}

// Test the exact pattern used in our code
console.log('\n=== Testing Pattern from FileIntegrityService ===');
function testCalculateFileHashes() {
    let secondaryHash;
    let useBlake2b = true;
    
    try {
        secondaryHash = crypto.createHash('blake2b512');
        console.log('✅ BLAKE2b512 creation succeeded');
    } catch (error) {
        secondaryHash = crypto.createHash('sha512');
        useBlake2b = false;
        console.log('⚠️ Using SHA-512 fallback due to:', error.message);
    }
    
    secondaryHash.update('test data');
    const digest = secondaryHash.digest('hex');
    const truncated = digest.substring(0, 64);
    
    console.log(`Algorithm used: ${useBlake2b ? 'BLAKE2b512' : 'SHA-512'}`);
    console.log(`Truncated digest (64 chars): ${truncated}`);
    console.log(`Full digest length: ${digest.length} chars`);
}

testCalculateFileHashes();
