---
name: 1-discovery-2-environment-setup
description: Install and configure required development environments, runtimes, tools, and dependencies based on detected project characteristics
tags: [discovery, environment-setup, dependencies, tools]
---


## Framework Validation
You MUST apply the <olaf-work-instructions> framework.
You MUST pay special attention to**:
- <olaf-general-role-and-behavior> - Expert domain approach
- <olaf-interaction-protocols> - Appropriate execution protocol
You MUST strictly apply <olaf-framework-validation>.

## Time Retrieval
You MUST get current time in YYYYMMDD-HHmm format using terminal commands:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **project_detection_file**: string - Path to project detection results (1-discovery-1-project-detection.json)
- **output_location**: string - Where to save setup results (defaults to [id:findings_dir])

## Previous Steps or Phase
1. Step 1: Project Detection completed successfully
2. Expected outcomes: 1-discovery-1-project-detection.json containing project type, languages, build system, and framework information

## Process

1. **Environment Analysis**:
   - Read file: `[id:findings_dir]1-discovery-1-project-detection.json`
   - Determine required runtimes based on detected languages
   - Identify development tools needed for build system

2. **Language-Specific Setup** (Decision-based execution):
   - Based on the `primary_language` from the detection file, select the appropriate script from the mapping below and execute it.
   - **Language-to-Script Mapping:**
     -   `JavaScript/TypeScript`: `[id:tools_dir]/reduce-code-complexity/1-discovery-2-nodejs-setup.ps1`
     -   `Python`: `[id:tools_dir]/reduce-code-complexity/1-discovery-2-python-setup.ps1`
     -   `Java`: `[id:tools_dir]/reduce-code-complexity/1-discovery-2-java-setup.ps1`
     -   `C#`: `[id:tools_dir]/reduce-code-complexity/1-discovery-2-dotnet-setup.ps1`
     -   `Go`: `[id:tools_dir]/reduce-code-complexity/1-discovery-2-go-setup.ps1`
     -   `Rust`: `[id:tools_dir]/reduce-code-complexity/1-discovery-2-rust-setup.ps1`

3. **Dependency Installation**:
   - Install project dependencies using detected package manager
   - Verify all dependencies resolve successfully
   - Document any dependency conflicts or issues

4. **Tool Verification**:
   - Verify all required development tools are accessible
   - Test basic functionality of build system
   - Document installed versions and configurations

## Output Format
Follow template structure: `[id:templates_dir]reduce-code-complexity/environment-setup-results.json`

Save as `1-discovery-2-environment-setup.json` in the [id:findings_dir]reduce-code-complexity/ directory, following the structure defined in the template.

## Output to USER
- Confirmation: "Environment setup completed successfully"
- Location: "Results saved to [id:findings_dir]reduce-code-complexity/1-discovery-2-environment-setup.json"
- Timestamp: Setup completion time
- Next phase: "Ready for Discovery Step 3: Build Execution"
   - Provides configured development environment for build testing
   - Ensures all required tools and dependencies are available
   - Enables successful project build execution

## Domain-Specific Rules
- Rule 1: Must install primary language runtime before attempting dependency installation
- Rule 2: Dependency installation failures must be logged but should not block environment setup completion
- Rule 3: All installed tools must be verified for basic functionality before completion
