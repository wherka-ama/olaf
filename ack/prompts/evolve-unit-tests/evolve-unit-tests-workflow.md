---
name: evolve-unit-tests-workflow
description: Comprehensive 9-phase unit test evolution workflow that systematically improves test coverage and quality in a codebase
tags: [testing, unit-tests, coverage, quality, evolution, workflow]
---

# Unit Test Evolution Workflow

## Overview
This prompt guides you through a comprehensive 9-phase unit test evolution workflow that systematically improves test coverage and quality in a codebase.


## Time Retrieval
Get current time in YYYYMMDD-HHmm format using terminal:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **code_files**: string - Path to the code files to be tested
- **existing_test_files**: string - Path to the existing test files (if any)
- **testing_framework**: string - Project testing framework and conventions
If the user dosnt provide the existing test files, make you best to find teh answer. But get a sign off from user once you found them.

## Workflow Phases

### Phase 1: Test Case Ideation (LLM-driven)
For the target code files, iteratively propose all unit tests to cover:
- **Happy path scenarios**: Normal operation with valid inputs
- **Faulty path scenarios**: Error conditions and exception handling
- **Edge cases**: Boundary conditions, null values, empty collections, and extreme values
- **State-based tests**: Verify object state changes after operations
- **Interaction tests**: Verify correct interaction between components (using mocks/spies)
- **Performance tests**: Verify acceptable execution time for critical paths
- **Security tests**: Input validation, authentication, and authorization checks
- **Concurrency tests**: Verify thread safety and race conditions
- **Idempotency tests**: Verify repeated operations produce same result
- **Backward compatibility tests**: Verify changes don't break existing functionality
- **Localization tests**: Verify proper handling of different locales/formats
- **Recovery tests**: Verify system recovers correctly from failures

**Test Template:**
See the comprehensive test case template at `[id:templates_dir]developer/unit-test-template.md` for the complete structure and required fields.

For quick reference, each test case should include at minimum:
- Test Name and Type
- Purpose/Description
- Input parameters
- Expected output/behavior
- Test steps
- Assertions

### Phase 2: Document Existing Unit Tests

Manual Documentation
1. Locate and parse all existing unit test files in the codebase
2. For each test case found:
   - Extract test name, purpose, and type
   - Document using the template from `[id:templates_dir]developer/unit-test-template.md`
   - Save to a structured inventory file in [id:findings_dir]code-evolution/augment-unit-tests-inventory-YYYYMMDD-NNN.md(e.g., `augment-unit-tests-inventory-2025-08-04-001.md`)
3. Record any observed testing patterns and conventions

### Phase 3: Analyze Test fit & Establish Principles
1. **Fit Analysis**:
   - Map existing tests against the test types from Phase 1
   - Identify which test categories are well-covered or missing
   - Highlight critical paths that need more test coverage

2. **Pattern Recognition**:
   - Analyze test structure and organization
   - Document naming conventions and test grouping
   - Note any test utilities or helper methods in use

3. **Create Testing Principles Document**:
   - Generate `unit-tests-principles-{project}.md` in [id:findings_dir]code-evolution/ that includes:
     - Project-specific testing conventions
     - Coverage goals and priorities
     - Code organization patterns
     - Best practices observed
     - Areas needing improvement
     - References to the test inventory

### Phase 4: Compare Proposed vs. Existing Tests
For each proposed test from Phase 1, categorize as:
- **Exact matches**: Existing tests that cover the same scenario
- **Missing tests**: Proposed tests not yet covered
- **Close matches**: Existing tests that may need updating
- **Orphaned tests**: Existing tests not identified by the LLM

For orphaned tests, review their relevance and purpose.

### Phase 5: Test Execution Status
Run all existing tests and record:
- **Passing tests**: Tests that execute successfully
- **Failing tests**: Tests with assertion failures or errors
- **Skipped tests**: Tests marked as ignored or disabled

### Phase 6: Explain Failing/Skipped Tests
For each failing or skipped test:
- Analyze the failure reason (do NOT fix yet)
- Explain why the test is failing or was skipped
- Assess if the failure indicates a code issue or test issue

### Phase 7: Update Close-Match Tests
Update existing tests that are close to new requirements:
- Align with new test definitions from Phase 1
- Improve test clarity and coverage
- Maintain existing test structure where possible

### Phase 8: Re-run Test Suite & Fix Errors
- Re-run all tests after Phase 7 updates
- Fix any errors that arise from the updates
- Ensure no regressions were introduced

### Phase 9: Add New Tests & Final Fixes
- Implement new tests identified in Phase 4
- Follow the `unit-tests-principles-{project}.md` conventions
- Fix any remaining errors
- Ensure all tests pass

## Output Structure

Follow template structure: `[id:templates_dir]evolve-unit-tests/unit-test-evolution-report-template.md`

**Save Output**: Create file `[id:findings_dir]code-evolution/unit-test-evolution-YYYYMMDD-NNN.md`

## Success Criteria
- All new and updated tests follow project conventions
- No test duplication
- Comprehensive coverage of happy path, faulty path, and edge cases
- All tests pass after implementation
- Clear documentation of testing principles established
