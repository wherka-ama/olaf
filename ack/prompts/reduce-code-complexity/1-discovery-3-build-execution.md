---
name: 1-discovery-3-build-execution
description: Execute and validate the project build process, documenting working build commands and procedures
tags: [discovery, build-execution, validation, documentation]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **project_detection_file**: string - Path to project detection results (1-discovery-1-project-detection.json)
- **environment_setup_file**: string - Path to environment setup results (1-discovery-2-environment-setup.json)
- **output_location**: string - Where to save build results (defaults to [id:findings_dir])

## Previous Steps or Phase
1. Step 1: Project Detection - identified project type, languages, and build system
2. Step 2: Environment Setup - configured development environment and installed dependencies
3. Expected outcomes: Working development environment with all required tools and dependencies installed

## Process

1.  **Analyze Inputs**:
    *   Read `[id:findings_dir]/1-discovery-1-project-detection.json`.
    *   Extract `build_system` and `package_manager`.

2.  **Formulate and Execute Build Command**:
    *   Based on the `build_system`, formulate the appropriate build command.
        *   If `build_system` is "Turbo", the command is `pnpm turbo build`.
        *   If `build_system` is "npm", the command is `npm run build`.
        *   If `build_system` is "Maven", the command is `mvn clean install`.
        *   If `build_system` is "Gradle", the command is `gradle build`.
        *   If `build_system` is ".NET/MSBuild", the command is `dotnet build`.
        *   If `build_system` is "Go Modules", the command is `go build ./...`.
        *   If `build_system` is "Cargo", the command is `cargo build`.
    *   Execute the formulated command in the project's root directory (`[id:core_dir]`)
    *   Capture the output, status, and any errors.

3.  **Validate and Document**:
    *   Analyze the build output to determine success or failure.
    *   Document the exact command used, the results, and any generated artifacts in the `1-discovery-3-build-execution.json` output file, following the template in this prompt.

## Output Format
Follow template structure: `[id:templates_dir]reduce-code-complexity/build-execution-results.json`

The output should be saved as `1-discovery-3-build-execution.json` in the `[id:findings_dir]reduce-code-complexity/`  directory, following the structure defined in the template.

## Output to USER
- Confirmation: "Build execution completed successfully"
- Location: "Results saved to [id:findings_dir]reduce-code-complexity/1-discovery-3-build-execution.json"
- Timestamp: Build completion time
- Next phase: "Discovery workflow complete - ready for Sub-workflow 2: Quality Baselining"
   - Provides validated build process for quality baseline establishment
   - Ensures project can be built consistently before refactoring begins
   - Documents working build commands for ongoing development

## Domain-Specific Rules
- Rule 1: Must successfully execute at least one complete build before completion
- Rule 2: Build failures should be thoroughly documented but may not prevent workflow completion
- Rule 3: All build artifacts must be validated for expected structure and content
