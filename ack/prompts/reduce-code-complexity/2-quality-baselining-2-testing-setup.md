---
name: 2-quality-baselining-2-testing-setup
description: Discover, configure, and validate testing frameworks and tools for comprehensive test infrastructure
tags: [quality-baselining, testing-setup, test-frameworks, configuration]
---

## Time Retrieval
Get current time in YYYYMMDD-HHmm format using terminal:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **discovery_results_file**: string - Path to discovery results 
- **Primary Input:** `1-discovery-1-project-detection.json`, `1-discovery-2-environment-setup.json`, `1-discovery-3-build-execution.json`
- **error_baseline_file**: string - Path to error baseline results `2-quality-baselining-1-error-baseline.json` 
- **output_location**: string - Where to save testing setup results (defaults to [id:findings_dir]reduce-code-complexity/)

## Previous Steps or Phase
1. Step 1: Error Baseline Capture completed successfully
2. Expected outcomes: Comprehensive error inventory with categorized issues and quality metrics established

## Process

1. **Testing Framework Discovery**:
   - Execute script: `[id:tools_dir]reduce-code-complexity/2-quality-baselining-2-setup-testing-framework.ps1` for automated framework detection
   - Analyze project structure for existing test frameworks and configurations
   - Identify language-specific testing tools (Jest, pytest, JUnit, NUnit, etc.)
   - Document current test infrastructure and capabilities

2. **Framework Configuration** (Decision-based execution):
   - based on detected or recommended framework:
   - Configure testing frameworks for optimal project compatibility
   - Install missing testing dependencies and tools
   - Validate framework configuration and basic functionality

3. **Test Infrastructure Validation**:
   - Verify all testing tools are properly installed and accessible
   - Test framework integration with build system
   - Validate test execution capabilities and reporting
   - Document testing commands and procedures

4. **Coverage Tool Setup**:
   - Configure code coverage measurement tools
   - Integrate coverage reporting with testing framework
   - Validate coverage data collection and reporting accuracy

## Output Format
Follow template structure: `[id:templates_dir]reduce-code-complexity/testing-setup-results.json`

The output should be saved as `2-quality-baselining-2-testing-setup.json` in the [id:findings_dir]reduce-code-complexity/ directory, following the structure defined in the template.

## Output to USER
- Confirmation: "Testing framework setup completed successfully"
- Location: "Results saved to [id:findings_dir]reduce-code-complexity/2-quality-baselining-2-testing-setup.json"
- Timestamp: Setup completion time
- Next phase: "Ready for quality baselining Step 3: Test Baseline Capture"
   - Provides configured testing infrastructure for comprehensive test execution
   - Enables accurate test result and coverage measurement
   - Establishes foundation for test-driven refactoring validation

## Domain-Specific Rules
- Rule 1: Framework selection must be compatible with detected project type and build system
- Rule 2: All testing tools must be validated for basic functionality before completion
- Rule 3: Coverage tool configuration must provide accurate and comprehensive measurement capabilities
