---
name: evolve-code-iteratively
description: Incrementally improve code based on specific goals (performance, maintainability, testability) using a structured, iterative approach.
tags: [refactoring, code-quality, optimization, iterative]
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

## Input Parameters
**IMPORTANT**: When you don't have these required parameters, ask the USER to provide them.
- **code**: string - The code to be analyzed and evolved (REQUIRED)
- **goals**: array[enum] - Primary goals from: performance, maintainability, testability (REQUIRED - select one or more)
- **iterations**: number - (Optional) Maximum number of iterations (default: 3, max: 5)
- **test_cases**: string - (Optional) Test cases to validate changes

## Process

1. **Initial Assessment**:
   - Analyze code structure and patterns
   - Establish baseline metrics (count lines, functions, complexity indicators where measurable)
   - Identify optimization opportunities with estimated impact
   - Document current state and technical debt

2. **Iterative Improvement**:
   - For each iteration (up to max iterations):
     1. Critique current code against goals
     2. Propose two distinct solutions with specific implementation details
     3. Compare options with pros/cons table
     4. Make a recommendation to the USER and ask for feedback: "Option 1", "Option 2", or "Stop here"
     5. Based on USER feedback, implement selected changes
     6. Validate with unit tests if they exist or propose to create basic validation
     7. Document changes and measure impact where possible
   - Continue until max iterations reached or user chooses to stop

3. **Finalization**:
   - Generate comprehensive improvement report with available metrics
   - Document all changes made with rationale for each decision
   - Provide before/after code comparison with annotations
   - Include recommendations for future improvements
   - Create rollback instructions if needed

## Output/Result Format
- Final code with improvements and clear change annotations
- Iteration reports in `[id:ads_dir]/code-evolution/YYYYMMDD-HHmm/`
- Comprehensive summary of changes with quantified improvements where measurable
- Before/after comparison with qualitative and quantitative analysis
- Decision log documenting rationale for each change made

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
   - Summary of improvements with measurable impact where possible
   - Qualitative assessment of code quality improvements
   - Performance analysis (theoretical gains, algorithm improvements)
   - Recommendations for future work
   - Rollback instructions for each change made

## Domain-Specific Rules
- Rule 1: Preserve functionality
- Rule 2: One change per iteration
- Rule 3: Validate with tests
- Rule 4: Document decisions
- Rule 5: Maintain readability

## Required Actions
1. Validate all required input parameters are provided
2. Analyze input code and establish baseline measurements
3. Define success criteria for each selected goal
4. Execute iterative improvement process with user feedback
5. Validate changes preserve functionality
6. Document process and generate comprehensive deliverables

⚠️ **Critical Notes**
- Never break existing functionality without explicit user approval
- Keep iterations small and focused on one primary improvement area
- Provide rollback capability and instructions for each change
- Document all assumptions and limitations clearly
- Consider team's skill level when proposing solutions
- Stop iterations if no meaningful improvements can be identified
- Measure impact where possible, document qualitative improvements where quantitative metrics aren't available
