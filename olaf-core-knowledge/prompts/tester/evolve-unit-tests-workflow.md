# Unit Test Evolution Workflow

## Overview
This prompt guides you through a comprehensive 9-phase unit test evolution workflow that systematically improves test coverage and quality in a codebase.

## Required Inputs
- Target code files to be tested
- Existing test files (if any)
- Project testing framework and conventions

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

#### Option A: Manual Documentation
1. Locate and parse all existing unit test files in the codebase
2. For each test case found:
   - Extract test name, purpose, and type
   - Document using the template from `[id:templates_dir]developer/unit-test-template.md`
   - Save to a structured inventory file (e.g., `test-inventory-{date}.md`)
3. Record any observed testing patterns and conventions

#### Option B: Automated Script (Recommended for Large Codebases)
1. **Run Test Discovery Script**:
   ```bash
   # Example command to generate initial test inventory
   python scripts/test_discovery.py --source=src/ --output=test-inventory-$(date +%Y%m%d).md
   ```
   The script will:
   - Scan the codebase for test files (e.g., `*_test.py`, `*.test.js`, etc.)
   - Parse test cases and extract metadata
   - Generate a structured markdown file using our template

2. **Review and Augment**:
   - Manually review the generated inventory
   - Add any missing test purposes or types
   - Update patterns and conventions based on findings

3. **Script Features (if implemented)**:
   - Language/framework detection
   - Test categorization
   - Code coverage mapping
   - Duplicate detection

> **Note**: Test discovery scripts can be customized based on your project's testing framework and requirements.

### Phase 3: Analyze Test Coverage & Establish Principles
1. **Coverage Analysis**:
   - Map existing tests against the test types from Phase 1
   - Identify which test categories are well-covered or missing
   - Highlight critical paths that need more test coverage

2. **Pattern Recognition**:
   - Analyze test structure and organization
   - Document naming conventions and test grouping
   - Note any test utilities or helper methods in use

3. **Create Testing Principles Document**:
   - Generate `unit-tests-principles-{project}.md` that includes:
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

#### Option A: Manual Comparison
1. Review each proposed test against existing inventory
2. Categorize each test based on the above criteria
3. Document any discrepancies or missing tests

#### Option B: Automated Comparison (Recommended for Large Codebases)
1. **Run Comparison Script**:
   ```bash
   # Example command to compare proposed vs existing tests
   python scripts/test_comparison.py --proposed=proposed-tests.md --existing=existing-tests.md
   ```
   The script will:
   - Compare proposed tests against existing inventory
   - Identify exact matches, missing tests, close matches, and orphaned tests
   - Generate a comparison report

2. **Review Results**:
   - Manually review the comparison report
   - Verify accuracy of categorization
   - Address any discrepancies

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
- Follow the `unit-tests-principle-template.md` conventions
- Fix any remaining errors
- Ensure all tests pass

## Output Structure

```markdown
# Unit Test Evolution Report

## Phase 1: Proposed Test Cases
[Table of all proposed tests with template format]

## Phase 2: Existing Test Inventory
[List of current tests with their purposes]

## Phase 3: Coverage Analysis & Principles
[Gap analysis and testing conventions document]

## Phase 4: Test Comparison Matrix
- Exact matches: [count]
- Missing tests: [list]
- Close matches: [list with update recommendations]
- Orphaned tests: [list with relevance assessment]

## Phase 5: Test Execution Results
- Passing: [count/list]
- Failing: [count/list]
- Skipped: [count/list]

## Phase 6: Failure Analysis
[Explanation of each failing/skipped test]

## Phase 7: Updated Tests
[Code for updated close-match tests]

## Phase 8: Post-Update Results
[Test results after updates]

## Phase 9: New Test Implementation
[Code for all new tests]

## Final Summary
- Total tests before: [count]
- Total tests after: [count]
- Coverage improvement: [metrics]
- Key achievements: [bullet points]
```

## Success Criteria
- All new and updated tests follow project conventions
- No test duplication
- Comprehensive coverage of happy path, faulty path, and edge cases
- All tests pass after implementation
- Clear documentation of testing principles established
