---
name: 2-quality-baselining-1-error-baseline
description: Capture the current error state of the project by documenting compilation errors, warnings, and static analysis issues
tags: [quality-baselining, error-baseline, static-analysis, warnings]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **discovery_results_file**: string - Path to discovery results (1-discovery-consolidated-results.json)
- **output_location**: string - Where to save error baseline results (defaults to [id:findings_dir]reduce-code-complexity/)

## Previous Steps or Phase
1. 1-Discovery workflow completed successfully
2. Expected outcomes: Validated build process and working development environment established

## Process

1. **Build Error Analysis**:
   - Execute script: `[id:tools_dir]reduce-code-complexity/2-quality-baselining-1-establish-error-baseline.ps1` for automated error capture
   - Attempt clean build and capture all compilation errors
   - Categorize errors by type (syntax, type, dependency, configuration)
   - Document error severity levels and impact assessment

2. **Static Analysis Execution**:
   - Run available static analysis tools based on detected language
   - Execute linting tools and code quality analyzers
   - Capture code smells, complexity warnings, and style violations
   - Document analysis tool outputs and recommendations

3. **Warning and Issue Inventory**:
   - Compile comprehensive inventory of all warnings and issues
   - Classify issues by category (critical, major, minor, informational)
   - Assess impact on code quality and maintainability
   - Create baseline for measuring improvement during refactoring

## Output Format
Follow template structure: `[id:templates_dir]reduce-code-complexity/error-baseline-results.json`

The output should be saved as `2-quality-baselining-1-error-baseline.json` in the `[id:findings_dir]reduce-code-complexity/2-quality-baselining-1-error-baseline.json` directory, following the structure defined in the template.

## Output to USER
- Confirmation: "Error baseline capture completed successfully"
- Location: "Results saved to [id:findings_dir]reduce-code-complexity/2-quality-baselining-1-error-baseline.json"
- Timestamp: Baseline capture completion time
- Next phase: "Ready for quality baselining Step 2: Testing Framework Setup"
   - Provides error inventory for testing framework configuration decisions
   - Establishes baseline for measuring error reduction during refactoring
   - Identifies critical issues that may impact testing setup

## Domain-Specific Rules
- Rule 1: All build attempts must be executed in clean environment to ensure consistent error capture
- Rule 2: Static analysis tools must be language-appropriate and validated for project type
- Rule 3: Error categorization must be consistent and measurable for baseline comparison
