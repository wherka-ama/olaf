// Quick test to verify installation paths no longer use system directories
const InstallationScope = {
    USER: 'user',
    WORKSPACE: 'workspace', 
    PROJECT: 'project'
};

const os = require('os');
const path = require('path');

// Mock vscode workspace
const mockWorkspace = {
    workspaceFolders: [{
        uri: { fsPath: '/home/user/myproject' }
    }]
};

function getInstallationPath(scope) {
    switch (scope) {
        case InstallationScope.USER:
            return path.join(os.homedir(), '.olaf');
        case InstallationScope.WORKSPACE:
            return path.join(mockWorkspace.workspaceFolders?.[0]?.uri.fsPath || '', '.olaf');
        case InstallationScope.PROJECT:
            return path.join(mockWorkspace.workspaceFolders?.[0]?.uri.fsPath || os.homedir(), '.olaf');
        default:
            // Fallback to user directory instead of system directory
            return path.join(os.homedir(), '.olaf');
    }
}

console.log('Installation path test results:');
console.log('USER scope:', getInstallationPath(InstallationScope.USER));
console.log('WORKSPACE scope:', getInstallationPath(InstallationScope.WORKSPACE));
console.log('PROJECT scope:', getInstallationPath(InstallationScope.PROJECT));
console.log('Default fallback:', getInstallationPath('unknown'));

// Test with no workspace
mockWorkspace.workspaceFolders = null;
console.log('\nNo workspace scenario:');
console.log('WORKSPACE scope (no workspace):', getInstallationPath(InstallationScope.WORKSPACE));
console.log('PROJECT scope (no workspace):', getInstallationPath(InstallationScope.PROJECT));
