# GitHub Workflows

## Overview

The OLAF project uses a deployment manifest system to define which files and directories should be included in installation bundles. This ensures consistent and configurable bundle generation.

## Deployment Manifest System

### Deployment Manifest (`deployment-manifest.yml`)

The `deployment-manifest.yml` file in the repository root defines:

- **Common Components**: Files and directories included in all bundles (olaf-core, olaf-data, docs, README files)
- **Environment-Specific Components**: Files specific to each environment (.github for Copilot, .windsurf for Windsurf)
- **Bundle Settings**: Configuration for bundle creation, naming conventions, and inclusion rules

### Bundle Types

The system creates three types of bundles:

1. **Common Bundle** (`olaf-common-{version}.zip`): Contains only the common OLAF components
2. **Environment Bundles** (`olaf-{environment}-{version}.zip`): Contains only environment-specific files
3. **Complete Bundles** (`olaf-{environment}-complete-{version}.zip`): Contains both common and environment-specific components

## Workflows

### 1. Release Bundles Workflow (`release-bundles.yml`)

**Triggers**: Automatically runs when a GitHub release is created

**Features**:
- ✅ **Manifest-Driven Bundle Creation**: Uses `deployment-manifest.yml` to determine bundle contents
- ✅ **Changelog Generation**: Compares current release with previous release tag
- ✅ **Contributors List**: Automatically generates list of contributors
- ✅ **Multiple Bundle Types**: Creates common, environment-specific, and complete bundles
- ✅ **Enhanced Release Notes**: Updates release notes with bundle information, changelog, and contributors
- ✅ **Automatic Asset Upload**: Uploads all generated bundles as release assets

### 2. Manual Test Workflow (`manual-test-bundles.yml`)

**Purpose**: Allows testing bundle creation without creating actual releases

**Features**:
- Can be triggered manually from GitHub Actions UI
- Uses the same manifest-driven logic as the release workflow
- Shows detailed bundle contents and manifest validation
- Uploads test bundles as workflow artifacts

### 3. Local Testing Script (`test-release-locally.sh`)

**Purpose**: Test the workflow logic locally before pushing

**Features**:
- Uses the deployment manifest
- Installs yq (YAML processor) if needed
- Shows bundle contents and sizes
- Generates changelog preview

**Usage**:
```bash
# Test with default values
./.github/workflows/test-release-locally.sh

# Test with specific tags
./.github/workflows/test-release-locally.sh v1.5.0-test v1.4.2

# Clean up after testing
rm -f test-changelog.md *.zip
rm -rf temp-*-bundle
```

## Bundle Contents (Based on Current Manifest)

### Common Components (included in all complete bundles)
- `olaf-core/` - Core prompts, templates, and tools
- `olaf-data/` - Data storage and project files
- `docs/` - Complete documentation
- `README.md`, `README-INSTALLATION.md`, `LICENSE`, `BRANCHING-STRATEGY.md`

### GitHub Copilot Environment
- `.github/copilot-instructions.md`
- `.github/prompts/` directory (5 prompt files)

### Windsurf Environment
- `.windsurf/rules/` directory (4 rule files)
- `.windsurf/workflows/` directory (6 workflow files)

## Manifest Configuration

### Adding New Environments

To add support for a new IDE/environment:

1. Edit `deployment-manifest.yml`
2. Add a new environment section under `environments:`
3. Specify the directories, files, and patterns for the new environment
4. The workflows will automatically create bundles for the new environment

### Modifying Common Components

To change what's included in all bundles:

1. Edit the `common:` section in `deployment-manifest.yml`
2. Add/remove directories, files, or patterns
3. Test locally using the test script

### Bundle Settings

You can configure:
- Whether to include common components in environment bundles
- Whether to create separate common bundles
- Bundle naming conventions
- Compression format

## File Structure

```
.github/
├── workflows/
│   ├── release-bundles.yml          # Main release workflow (manifest-driven)
│   ├── manual-test-bundles.yml      # Manual testing workflow (manifest-driven)
│   ├── test-release-locally.sh      # Local testing script (manifest-driven)
│   ├── parse-manifest.sh            # Manifest parser script
│   └── README.md                    # This documentation
├── prompts/                         # Included in GitHub Copilot bundles
└── copilot-instructions.md          # Included in GitHub Copilot bundles

deployment-manifest.yml              # Bundle configuration (repository root)
```

## Usage Examples

### Production Release
1. Create a new release on GitHub
2. The workflow automatically:
   - Reads `deployment-manifest.yml`
   - Generates changelog and contributors list
   - Creates all configured bundle types
   - Updates release notes with bundle information
   - Uploads bundles as release assets

### Testing Changes
1. **Local Testing**:
   ```bash
   ./.github/workflows/test-release-locally.sh v1.5.0-test
   ```

2. **GitHub Testing**:
   - Go to Actions → "Manual Test Bundle Creation"
   - Specify test tag name
   - Review generated bundles in artifacts

### Validating Manifest
```bash
# Check manifest syntax (requires yq)
yq eval '.bundle_settings' deployment-manifest.yml

# Test bundle creation
./.github/workflows/parse-manifest.sh v1.5.0-test
```

## Troubleshooting

### Common Issues

1. **Missing yq**: The workflows automatically install yq, but for local testing you may need to install it manually
2. **Manifest Validation Errors**: Check YAML syntax in `deployment-manifest.yml`
3. **Missing Files**: Ensure all directories and files specified in the manifest exist
4. **Bundle Size Issues**: Review include/exclude patterns in the manifest

### Debugging

- Use the manual test workflow to see detailed bundle contents
- Check workflow logs for manifest validation output
- Test locally before creating releases
