# Changelog

All notable changes to the OLAF VSCode Extension will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Private Repository Support**: Full authentication support for private GitHub repositories
- **Repository Configuration**: Configurable GitHub organization and repository names
- **Bearer Token Authentication**: Support for GitHub personal access tokens generated with `gh auth token`
- **Repository Access Validation**: New command `OLAF: Validate Repository Access` for testing authentication and connectivity
- **Enhanced Security**: Secure token handling with proper authorization headers
- **Detailed Diagnostics**: Comprehensive validation reporting with troubleshooting recommendations

### Enhanced
- **GitHub Service**: Updated to support configurable repositories and authentication
- **Configuration Options**: Added settings for repository owner, name, token, and private mode
- **Error Handling**: Improved error messages for authentication and access issues
- **Documentation**: Comprehensive authentication setup and troubleshooting guide

### Technical
- **Authentication Tests**: New test suite for private repository functionality
- **Configuration Validation**: Runtime validation of repository access and token permissions
- **Token Security**: Bearer token authentication following GitHub API best practices

## [0.1.0] - 2024-12-19

### Added
- Initial release of OLAF VSCode Extension
- Multi-platform support for VSCode, Windsurf, Cursor, and Kiro
- Comprehensive platform detection with multiple detection methods
- GitHub API integration for release management and downloads
- Installation management with ZIP extraction and multi-scope support
- Automatic update checking and installation
- Status bar integration with real-time status display
- Command palette integration with three main commands:
  - `OLAF: Install` - Install OLAF components
  - `OLAF: Update` - Update OLAF components  
  - `OLAF: Status` - Show installation status
- Progress tracking for downloads and installations
- Comprehensive logging with multiple levels
- User notifications and error handling
- Configuration options for auto-updates and GitHub tokens
- Network utilities for connectivity checking and file downloads
- File utilities for cross-platform file operations
- Unit tests for core components
- GitHub Actions workflow for automated publishing
- Complete TypeScript implementation with strict type checking
- ESLint configuration for code quality
- Webpack bundling for optimized distribution

### Features
- **Platform Detection**: Automatically detects your IDE platform using:
  - Executable path analysis
  - Environment variable detection
  - Process information analysis
  - Configuration file inspection
  - VSCode API information
- **Installation Scopes**: Support for multiple installation scopes:
  - User-level installation
  - Workspace-level installation
  - Project-level installation
- **Update Management**: Intelligent update system with:
  - Automatic update checking
  - Manual update triggers
  - Version comparison and validation
  - Progress tracking and user feedback
- **GitHub Integration**: Direct integration with GitHub for:
  - Release fetching and parsing
  - Asset filtering by platform
  - Download progress tracking
  - Rate limiting support
- **Status Monitoring**: Real-time status display showing:
  - Current installation status
  - Available updates
  - Platform information
  - Version details

### Technical Details
- Built with TypeScript 4.9.4
- Targets VSCode API 1.74.0+
- Uses Webpack 5 for bundling
- Includes comprehensive error handling
- Supports Node.js 16.x+
- Implements singleton patterns for services
- Uses async/await for all asynchronous operations
- Includes proper cleanup and disposal methods

### Documentation
- Complete README with installation and usage instructions
- API documentation for all public methods
- Troubleshooting guide for common issues
- Development setup instructions
- Contributing guidelines

## [Unreleased]

### Planned
- Support for additional IDE platforms
- Enhanced configuration options
- Plugin marketplace integration
- Improved error reporting
- Performance optimizations
- Additional test coverage
- Documentation improvements
