# Sequential/Chained Workflow Template

> **Note:** All files referenced below are either prompts located in `[id:prompts_dir]` or tools located in `[id:tools_dir]`, as specified in the memory map file.
> The solution to analyze is in [id:core_dir] and all new non-temporary created files are to be created in [id:findings_dir]der.

# 2-Quality-Baselining Workflow: Comprehensive Quality Baseline Establishment

## Workflow Type
Sequential/Chained - Each step depends on the output of the previous step

## Workflow Overview
Establishes comprehensive quality baselines including error state, testing framework setup, and test result capture to provide a foundation for measuring improvement during refactoring.

## Prerequisites
- 1-Discovery workflow completed successfully with validated build process
- Access to project source code in `[id:core_dir]`
- Write permissions to `[id:findings_dir]reduce-code-complexity/` output files
- Working development environment established

## Input Requirements
- **Primary Input:** `1-discovery-1-project-detection.json`, `1-discovery-2-environment-setup.json`, `1-discovery-3-build-execution.json` from 1-Discovery workflow
- **Secondary Inputs:** Project source code and existing test files
- **Input Format:** JSON configuration data and source code files

## Output Specifications
- **Primary Output:** `2-quality-baselining-results.json`
- **Secondary Outputs:** Individual step outputs (error-baseline.json, testing-setup.json, test-baseline.json)
- **Output Location:** [id:findings_dir]reduce-code-complexity/

## Workflow Steps

### Step 1: Error Baseline Capture
- **Prompt/Tool:** `[id:prompts_dir]reduce-code-complexity/2-quality-baselining-1-error-baseline.md`
- **Input:** `1-discovery-3-build-execution.json`
- **Output:** `2-quality-baselining-1-error-baseline.json`
- **Description:** Capture the current error state of the project by attempting builds, running static analysis, and documenting all compilation errors, warnings, and issues
- **Validation:** Verify error baseline contains comprehensive error inventory with categorization and severity levels

### Step 2: Testing Framework Setup
- **Prompt/Tool:** `[id:prompts_dir]reduce-code-complexity/2-quality-baselining-2-testing-setup.md`
- **Input:** `1-discovery-1-project-detection.json`, `1-discovery-2-environment-setup.json`, `1-discovery-3-build-execution.json` + `2-quality-baselining-1-error-baseline.json`
- **Output:** `2-quality-baselining-2-testing-setup.json`
- **Description:** Discover, configure, and validate testing frameworks and tools for the project, ensuring comprehensive test infrastructure is operational
- **Validation:** Verify testing frameworks are properly configured and capable of executing project tests

### Step 3: Test Baseline Capture
- **Prompt/Tool:** `[id:prompts_dir]reduce-code-complexity/2-quality-baselining-3-test-baseline.md`
- **Input:** `2-quality-baselining-1-error-baseline.json` + `2-quality-baselining-2-testing-setup.json`
- **Output:** `2-quality-baselining-3-test-baseline.json`
- **Description:** Execute comprehensive test suite and capture current test results, coverage metrics, and performance baselines for comparison during refactoring
- **Validation:** Verify test baseline captures complete test state including pass/fail counts, coverage percentages, and performance metrics

## Data Flow Diagram
```
[Discovery Results] → [Step 1: Error Baseline] → [error-baseline.json] → [Step 2: Testing Setup] → [testing-setup.json] → [Step 3: Test Baseline] → [test-baseline.json] → [Consolidated Quality Baseline]
```

## Error Handling
- **Step Failure:** Log detailed error information, assess impact on quality measurement capability
- **Recovery:** Each step can be restarted independently using preserved input files and project state
- **Rollback:** Test framework configurations can be reverted if they interfere with project functionality

## Completion Criteria
- [ ] All steps completed successfully with comprehensive baseline data captured
- [ ] All outputs validated and contain expected quality metrics and measurements
- [ ] No critical errors encountered that would prevent quality measurement
- [ ] Consolidated quality baseline file created with complete project quality profile

## Next Steps
- Proceed to Sub-workflow 3: Discovery Baselining Consolidation
- Quality baselines serve as measurement foundation for all subsequent analysis and refactoring workflows
