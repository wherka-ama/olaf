---
name: evolve-code-iteratively
description: Incrementally improve code based on specific goals (performance, maintainability, testability) using a structured, iterative approach.
tags: [refactoring, code-quality, optimization, iterative]
---

## Time Retrieval
Get current time in YYYYMMDD-HHmm format using terminal:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **code**: string - The code to be analyzed and evolved
- **goals**: array[enum] - Primary goals (performance, maintainability, testability)
- **iterations**: number - (Optional) Maximum number of iterations (default: 3)
- **test_cases**: string - (Optional) Test cases to validate changes

## Process

1. **Initial Assessment**:
   - Analyze code structure and patterns
   - Establish baseline metrics
   - Identify optimization opportunities
   - Document current state

2. **Iterative Improvement**:
   - For each iteration (up to max iterations):
     1. Critique current code against goals
     2. Propose two distinct solutions
     3. Compare options with pros/cons
     4. Make a recommendation to teh USSR and ask for its feedback - option 1 , option 2 or stop here
     5. Based on USER feedback** 
   - Implement selected changes
   - Validate with unit tests if they exist or propose to create some
   - Document changes and metrics

3. **Finalization**:
   - Generate improvement report
   - Document all changes made

## Output/Result Format
- Final code with improvements
- Iteration reports in `[id:ads_dir]/code-evolution/YYYYMMDD-NNN/`
- Summary of changes and metrics
- Before/after comparison

## Output to USER
1. **Initial Analysis**:
   - Code quality assessment
   - Identified improvement areas
   - Proposed iteration plan

2. **Iteration Updates**:
   - Changes made in each iteration
   - Impact on goals
   - Validation results

3. **Final Report**:
   - Summary of improvements
   - Performance metrics
   - Recommendations for future work

## Domain-Specific Rules
- Rule 1: Preserve functionality
- Rule 2: One change per iteration
- Rule 3: Validate with tests
- Rule 4: Document decisions
- Rule 5: Maintain readability

## Required Actions
1. Analyze input code
2. Define success metrics
3. Execute iterations
4. Validate changes
5. Document process

⚠️ **Critical Notes**
- Never break existing functionality
- Keep iterations small and focused
- Include rollback capability
- Document all assumptions
- Consider team's skill level
