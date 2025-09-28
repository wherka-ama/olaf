# Changelog

All notable changes to the OLAF VS Code extension will be documented in this file.

## [0.0.4] - 2024-09-28

### Fixed
- **CRITICAL**: Fixed file inventory not being recorded during enhanced installation
- Enhanced installation now properly tracks all installed files for uninstallation
- File integrity verification now uses actual installed files instead of empty array
- Improved `getInstalledFilesList()` method with proper file discovery and metadata reading
- Added fallback directory scanning for file discovery when metadata is unavailable

### Enhanced
- Enhanced installation now uses `legacyResult.installedFiles` for accurate file tracking
- Added recursive directory scanning capability for comprehensive file inventory
- Better error handling and logging for file inventory operations
- Metadata files (.olaf*.json) are properly excluded from inventory scans

### Technical Details
- Fixed empty `"files": []` array in `.olaf-enhanced-metadata.json`
- Installation now calculates integrity for actual installed files
- Uninstallation process can now properly identify which files to remove
- Added `scanDirectoryFiles()` method for comprehensive file discovery

## [0.0.3] - 2024-09-28

### Fixed
- **CRITICAL**: Fixed hardcoded system paths causing permission errors during installation
- Installation no longer requires root privileges or access to `/usr/local/share/`
- Added missing `InstallationScope.PROJECT` case in path resolution
- All installation scopes now use user-accessible directories:
  - USER: `~/.olaf`
  - WORKSPACE: `<workspace>/.olaf`
  - PROJECT: `<project>/.olaf` (fallback to `~/.olaf` if no workspace)
  - Default fallback: `~/.olaf` instead of system directory

### Changed
- Installation path logic now properly handles all defined scopes
- Improved error handling for workspace-less environments

## [0.0.2] - 2024-09-28

### Fixed
- **CRITICAL**: Replaced native dependency @node-rs/xxhash with Node.js built-in crypto module
- Fixed runtime errors: "Error: Could not load the bindings file"
- Eliminated all native binary dependencies for better cross-platform compatibility
- VSIX size optimized from 600KB to 153KB (79% reduction)

### Changed
- File integrity verification now uses BLAKE2b-256 + SHA-256 dual hashing
- Removed @node-rs/xxhash and related native dependencies
- Updated webpack configuration to exclude native modules

### Added
- Comprehensive native dependency audit and removal
- Portable hashing solution using Node.js crypto APIs
- Enhanced cross-platform compatibility

## [0.0.1] - 2024-09-27

### Added
- Phase 3 Smart Uninstallation with intelligent file categorization
- Enhanced integrity verification with dual hash (BLAKE2b + SHA256)
- User choice dialogs for modified files during uninstallation
- Automatic backup functionality for user-modified files
- Comprehensive file modification detection
- Smart categorization: intact, modified, user-created, deleted
- Advanced uninstall policies with customizable preservation rules

### Enhanced
- Installation Manager with enhanced metadata tracking
- File Integrity Service with comprehensive verification
- Comprehensive test coverage for all new functionality
- Error handling and logging improvements

### Fixed
- All ESLint warnings and code quality issues
- Webpack configuration for optimized bundling
- Test execution and coverage reporting
- Package structure and dependency management
