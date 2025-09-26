# OLAF Installation Guide

Simple installation guide for the OLAF framework.

## Recommended Installation Method: VSCode/Windsurf Extension

The easiest way to install OLAF is through our VSCode extension, which works with VSCode and    Windsurf IDEs.

### 1. Install the Extension

#### From VSCode Marketplace
1. Open VSCode or Windsurf
2. Press `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (macOS) to open Extensions view
3. Search for "OLAF"
4. Click "Install"

#### From VSIX Package
1. Download the latest `.vsix` file from [GitHub Releases](https://github.com/AmadeusITGroup/olaf/releases)
2. Open VSCode or Windsurf
3. Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS)
4. Type "Extensions: Install from VSIX"
5. Select the downloaded `.vsix` file

### 2. Install OLAF Components

1. Open Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`)
2. Type "OLAF: Install" and press Enter
3. Select installation scope:
   - **Project**: Install for the current project (recommended)
note  these 2 options are not available for now
    - **Workspace**: Install for the current workspace
    - **User**: Install for the current user 

4. The extension will automatically download the latest release and install all components

### 3. Verify Installation

- Check the presence of olaf-core and olaf-data folders in your workspace
Note : we do not recommed to get olaf as part of your project until you knoz zhat it does and how to use it. 

## Alternative: Manual Installation

If you prefer manual installation or the extension is not available:

### 1. Download the ZIP file from Github Head
```
https://github.com/AmadeusITGroup/olaf/archive/refs/heads/main.zip
```

### 2. Extract the ZIP file
- Extract to any location on your computer
- This creates a folder named `olaf-main`

### 3. Copy the framework folders
From the extracted `olaf-main` folder, copy these folders to your project directory:
- `olaf-core/` - Core prompts, templates, and reference materials
- `olaf-data/` - Data storage and project files
- `.github/` - GitHub integration and workflow configurations
- `.windsurf/` - Windsurf IDE configuration and workflows
- `docs/` - Complete documentation and guides

## That's it!

You now have the OLAF framework installed in your project.

## What You Get

- **olaf-core/** - Core prompts, templates, and reference materials
- **olaf-data/** - Data storage and project files
- **.github/** - GitHub integration and workflow configurations
- **.windsurf/** - Windsurf rules and workflows
- **docs/** - Complete documentation and guides

## Extension Features



## Updating OLAF

### With Extension (Recommended)
This is not yet supported

### Manual Update
To update manually:
1. Download the ZIP file again (same URL)
2. Extract and copy the folders
3. This will replace existing files with the same names

## Older Versions

For older versions, you have two options:

### GitHub Releases (if available)
Check for releases at: `https://github.com/AmadeusITGroup/olaf/releases`



## Support
This is an experimental project and is not supported by Amadeus IT Group.
We do not provide any support for this project , but you can help us by reporting issues


For issues or questions:
- **GitHub Issues**: [Report bugs or request features](https://github.com/AmadeusITGroup/olaf/issues)
- **Documentation**: [Read the full documentation](https://github.com/AmadeusITGroup/olaf/wiki)
- Contact the OLAF team or repository maintainers
