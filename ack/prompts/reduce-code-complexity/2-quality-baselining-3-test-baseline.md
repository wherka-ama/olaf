---
description: Generate a consolidated test coverage baseline report
---

# Test Baseline Prompt

**Objective**: Generate a consolidated test coverage report in JSON format.

**Instructions**:

1. Run all tests with coverage enabled across the monorepo
2. Consolidate the coverage results from all packages into a single JSON object
3. **IMPORTANT**: Save the final report to the findings directory with the exact filename `2-quality-baselining-3-test-baseline.json`
4. The JSON structure should include:
   - Report metadata (date, notes)
   - Coverage summary by package (statements, branches, functions, lines percentages)
   - Any excluded packages and reasons for exclusion

**Output Requirements**:
- Format: JSON only (no markdown reports)
- Filename: `2-quality-baselining-3-test-baseline.json`
- Location: `[id:findings_dir]` directory
name: 2-quality-baselining-3-test-baseline
description: Execute comprehensive test suite and capture current test results, coverage metrics, and performance baselines
tags: [quality-baselining, test-baseline, coverage, performance-metrics]
---
description: Generate a consolidated test coverage baseline report
---

# Test Baseline Prompt

**Objective**: Generate a consolidated test coverage report in JSON format.

**Instructions**:

1. Run all tests with coverage enabled across the monorepo
2. Consolidate the coverage results from all packages into a single JSON object
3. **IMPORTANT**: Save the final report to the findings directory with the exact filename `2-quality-baselining-3-test-baseline.json`
4. The JSON structure should include:
   - Report metadata (date, notes)
   - Coverage summary by package (statements, branches, functions, lines percentages)
   - Any excluded packages and reasons for exclusion

**Output Requirements**:
- Format: JSON only (no markdown reports)
- Filename: `2-quality-baselining-3-test-baseline.json`
- Location: `[id:findings_dir]` directory

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **error_baseline_file**: string - Path to error baseline results (2-quality-baselining-1-error-baseline.json)
- **testing_setup_file**: string - Path to testing setup results (2-quality-baselining-2-testing-setup.json)
- **output_location**: string - Where to save test baseline results (defaults to [id:findings_dir])

## Previous Steps or Phase
1. Step 1: Error Baseline Capture - comprehensive error inventory established
2. Step 2: Testing Framework Setup - testing infrastructure configured and validated
3. Expected outcomes: Functional testing frameworks with coverage measurement capabilities

## Process

1.  **Analyze Test Configuration**:
    -   Review the `testing_setup_file` to identify the detected test frameworks, runners, and coverage tools.
    -   Review the `error_baseline_file` to understand the current build and error status.

2.  **Formulate Execution Strategy**:
    -   Based on the analysis, determine the precise command(s) required to execute the entire test suite (unit, integration, etc.).
    -   Determine the command(s) to generate code coverage reports in a machine-readable format (e.g., `json`, `lcov`).
    -   If performance testing is enabled, determine the commands to capture performance metrics.

3.  **Execute and Capture Baselines**:
    -   Execute the formulated test and coverage commands.
    -   Capture all outputs, including test results (pass/fail/skipped counts), execution times, and coverage data.
    -   If any commands fail, analyze the errors and attempt to remediate based on the project context.

4.  **Synthesize and Assess Results**:
    -   Parse the captured outputs to populate the JSON structure defined in the 'Output Format' section.
    -   Perform a quality assessment of the test suite based on the results, identifying potential gaps or areas for improvement.
    -   Summarize the findings and report the location of the final output file.

## Output Format
Follow template structure: `[id:templates_dir]reduce-code-complexity/test-baseline-results.json`

The output should be saved as `2-quality-baselining-3-test-baseline.json` in the [id:findings_dir]reduce-code-complexity/ directory, following the structure defined in the template.

## Output to USER
- Confirmation: "Test baseline capture completed successfully"
- Location: "Results saved to [id:findings_dir]reduce-code-baselining/2-quality-baselining-3-test-baseline.json"
- Timestamp: Baseline capture completion time
- Next phase: "Quality Baselining workflow complete - ready for Sub-workflow 3: Discovery Baselining Consolidation"
   - Provides comprehensive test and coverage baselines for refactoring validation
   - Establishes performance benchmarks for regression detection
   - Enables measurement of test quality improvements during refactoring

## Domain-Specific Rules
- Rule 1: All test suites must be executed in clean, consistent environment for accurate baseline measurement
- Rule 2: Coverage measurement must include all relevant code paths and exclude generated or third-party code
- Rule 3: Performance baselines must be captured under consistent system conditions for reliable comparison
