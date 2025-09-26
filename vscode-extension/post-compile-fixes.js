#!/usr/bin/env node

/**
 * Cross-platform post-compilation fixes for VS Code extension CI/CD
 * Handles Windows, Linux, and macOS environments
 */

const fs = require('fs');
const path = require('path');

console.log('🔧 Running post-compilation fixes...');
console.log(`Platform: ${process.platform}`);
console.log(`Working directory: ${process.cwd()}`);

// Ensure test-dist directory exists
const testDistDir = path.join(process.cwd(), 'test-dist');
if (!fs.existsSync(testDistDir)) {
  console.log('📁 Creating test-dist directory...');
  fs.mkdirSync(testDistDir, { recursive: true });
}

// Ensure utils directory exists
const utilsDir = path.join(testDistDir, 'utils');
if (!fs.existsSync(utilsDir)) {
  console.log('📁 Creating test-dist/utils directory...');
  fs.mkdirSync(utilsDir, { recursive: true });
}

// Create logger.js if it doesn't exist
const loggerPath = path.join(utilsDir, 'logger.js');
if (!fs.existsSync(loggerPath)) {
  console.log('📝 Creating logger.js...');
  
  const loggerContent = `/**
 * Mock Logger for VS Code Extension Testing
 * Cross-platform compatible implementation
 */

const vscode = require('vscode');

class Logger {
  constructor() {
    this.outputChannel = null;
    try {
      // Try to get or create output channel
      this.outputChannel = vscode.window.createOutputChannel('OLAF Extension');
    } catch (error) {
      // Fallback for testing environments
      console.warn('Could not create VS Code output channel:', error.message);
    }
  }

  info(message, details = null) {
    const timestamp = new Date().toISOString();
    const logMessage = \`[\${timestamp}] INFO: \${message}\`;
    
    try {
      if (this.outputChannel) {
        this.outputChannel.appendLine(logMessage);
        if (details) {
          this.outputChannel.appendLine(\`Details: \${JSON.stringify(details, null, 2)}\`);
        }
      }
    } catch (error) {
      console.log(logMessage);
      if (details) console.log('Details:', details);
    }
  }

  warn(message, details = null) {
    const timestamp = new Date().toISOString();
    const logMessage = \`[\${timestamp}] WARN: \${message}\`;
    
    try {
      if (this.outputChannel) {
        this.outputChannel.appendLine(logMessage);
        if (details) {
          this.outputChannel.appendLine(\`Details: \${JSON.stringify(details, null, 2)}\`);
        }
      }
    } catch (error) {
      console.warn(logMessage);
      if (details) console.warn('Details:', details);
    }
  }

  error(message, error = null) {
    const timestamp = new Date().toISOString();
    const logMessage = \`[\${timestamp}] ERROR: \${message}\`;
    
    try {
      if (this.outputChannel) {
        this.outputChannel.appendLine(logMessage);
        if (error) {
          this.outputChannel.appendLine(\`Error Details: \${error.stack || error.message || error}\`);
        }
      }
    } catch (err) {
      console.error(logMessage);
      if (error) console.error('Error Details:', error);
    }
  }

  debug(message, details = null) {
    const timestamp = new Date().toISOString();
    const logMessage = \`[\${timestamp}] DEBUG: \${message}\`;
    
    try {
      if (this.outputChannel) {
        this.outputChannel.appendLine(logMessage);
        if (details) {
          this.outputChannel.appendLine(\`Details: \${JSON.stringify(details, null, 2)}\`);
        }
      }
    } catch (error) {
      console.debug(logMessage);
      if (details) console.debug('Details:', details);
    }
  }

  show() {
    try {
      if (this.outputChannel) {
        this.outputChannel.show();
      }
    } catch (error) {
      console.log('Cannot show output channel:', error.message);
    }
  }

  clear() {
    try {
      if (this.outputChannel) {
        this.outputChannel.clear();
      }
    } catch (error) {
      console.log('Cannot clear output channel:', error.message);
    }
  }

  dispose() {
    try {
      if (this.outputChannel) {
        this.outputChannel.dispose();
        this.outputChannel = null;
      }
    } catch (error) {
      console.log('Cannot dispose output channel:', error.message);
    }
  }
}

module.exports = { Logger };
`;
  
  fs.writeFileSync(loggerPath, loggerContent, 'utf8');
  console.log('✅ Created logger.js successfully');
} else {
  console.log('✅ logger.js already exists');
}

console.log('🎉 Post-compilation fixes completed successfully!');
console.log('📊 Summary:');
console.log(`   - Logger implementation: ${fs.existsSync(loggerPath) ? '✅' : '❌'}`);
