const fs = require('fs');
const crypto = require('crypto');

// Simulate the calculateFileIntegrity method
async function calculateFileIntegrity(filePath) {
  console.log('Starting integrity calculation for:', filePath);
  
  try {
    const stats = await fs.promises.stat(filePath);
    console.log('File stats obtained:', stats.size, 'bytes');
    
    // Calculate hashes
    const hashes = await new Promise((resolve, reject) => {
      const sha256Hash = crypto.createHash('sha256');
      const blake2bHash = crypto.createHash('blake2b512');
      const stream = fs.createReadStream(filePath, { highWaterMark: 64 * 1024 });
      
      stream.on('data', (chunk) => {
        sha256Hash.update(chunk);
        blake2bHash.update(chunk);
      });
      
      stream.on('end', () => {
        const sha256 = sha256Hash.digest('hex');
        const blake2b256 = blake2bHash.digest('hex').substring(0, 64);
        resolve({ sha256, blake2b256 });
      });
      
      stream.on('error', reject);
    });
    
    console.log('Hashes calculated successfully');
    
    return {
      path: filePath,
      sha256: hashes.sha256,
      xxhash64: hashes.blake2b256,
      size: stats.size,
      mtime: stats.mtime.toISOString(),
      permissions: stats.mode.toString(8),
      isExecutable: !!(stats.mode & fs.constants.S_IXUSR),
      isSymlink: stats.isSymbolicLink(),
      symlinkTarget: stats.isSymbolicLink() ? await fs.promises.readlink(filePath) : undefined
    };
  } catch (error) {
    console.error('Error in calculateFileIntegrity:', error);
    throw error;
  }
}

// Test it
calculateFileIntegrity('/home/wherka/workspace/olaf-test/docs/release-notes/RELEASE-NOTES-v1.5.0.md')
  .then(result => {
    console.log('Success! Result:', {
      path: result.path,
      size: result.size,
      sha256: result.sha256.substring(0, 16) + '...',
      xxhash64: result.xxhash64.substring(0, 16) + '...'
    });
  })
  .catch(error => {
    console.error('Final error:', error);
  });
