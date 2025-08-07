---
name: 1-discovery-1-project-detection
description: Detect and analyze project type, programming languages, build systems, and overall structure
tags: [discovery, project-detection, build-system, languages]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **project_path**: string - Path to project source code (defaults to [id:core_dir])
- **output_location**: string - Where to save detection results (defaults to [id:findings_dir])

## Previous Steps or Phase
1. This is the first step in the 1-Discovery workflow
2. No previous steps - this prompt initiates the discovery process

## Process

1. **Project Structure Analysis**:
   - Execute script: `[id:tools_dir]reduce-code-complexity/1-discovery-1-detect-project-type.ps1` for automated detection
   - the script provides a comprehensive analysis of the project structure in the file `project-detection.json` 
   - Use it to inform further analysis and decision-making
   - Specifically, it helps in understanding the overall architecture and dependencies
   - Analyze directory structure and key configuration files
   - Identify programming languages used
   - Detect build systems and package managers

2. **Configuration File Analysis**:
   - Read configuration files based on detected project type
   - Extract project metadata, dependencies, and build configuration
   - Identify testing frameworks and tools

3. **Project Classification**:
   - Classify project type (web app, library, service, etc.)
   - Determine primary and secondary programming languages
   - Document build system and package manager
   - Identify key architectural patterns

## Output Format
Follow template structure: `[id:templates_dir]reduce-code-complexity/project-detection-template.json` to save the results in `[id:findings_dir]reduce-code-complexity/discovery-1-project-detection.json`

The template provides a comprehensive structure for capturing:
- **Basic Detection**: Project type, languages, build systems
- **Architecture Patterns**: Design patterns, API styles, data access patterns  
- **Code Quality Metrics**: LOC, complexity, test coverage, technical debt
- **Dependencies**: Production, development, peer, and vulnerable dependencies
- **Security Analysis**: Security frameworks, vulnerabilities, best practices
- **Performance**: Bundling tools, optimization techniques, caching strategies
- **Development Environment**: IDE configs, linting tools, git hooks

## Output to USER
- Confirmation: "Project detection completed successfully"
- Location: "Results saved to [id:findings_dir]reduce-code-complexity/discovery-1-project-detection.json"
- Timestamp: Detection completion time
- Next phase: "Ready for DDiscovery Step 2: Environment Setup"
   - Provides project metadata for environment setup decisions
   - Enables language-specific tool and dependency installation
   - Foundation for build system configuration

## Domain-Specific Rules
- Rule 1: Must detect at least primary language and project type
- Rule 2: All detected frameworks and tools must be verified to exist in project
- Rule 3: Configuration files must be validated for syntax and completeness
