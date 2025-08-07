---
name: 6-refactoring-2-implementation
description: Execute refactoring implementation using defined patterns and techniques with comprehensive testing
tags: [refactoring, implementation, complexity-reduction, code-transformation]
---

## Time Retrieval
Get current time in YYYYMMDD-HHmm format using terminal:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **target_preparation_file**: string - Path to target preparation results (6-refactoring-1-target-preparation.json)
- **implementation_strategy_file**: string - Path to implementation strategy (5-analysis-strategy-3-implementation-strategy.json)
- **output_location**: string - Where to save implementation results (defaults to [id:findings

## Previous Steps or Phase
1. Step 1: Refactoring Target Selection and Preparation - targets selected with baseline metrics and team coordination established
2. Expected outcomes: Prepared refactoring targets with comprehensive test suites, baseline metrics, and team assignments

## Process

1. **Target Selection and Prioritization**:
   - Based on current iteration stage
   - Select next refactoring targets based on implementation strategy and current progress
   - Prioritize targets considering current phase objectives and team capacity

2. **Refactoring Pattern Implementation**:
   - Apply designated refactoring patterns (Extract Method, Strategy Pattern, etc.)
   - Implement changes incrementally
   - Maintain comprehensive documentation of changes made save this in `6-refactoring-2-changelog.md`
   - Follow established coding standards and best practices

3. **Comprehensive Testing and Validation**:
   - Execute unit tests based on `2-quality-baselining-2-testing-setup.json` done in `2-quality-baselining-2-testing-setup`
   - ensure that this is as good as `2-quality-baselining-3-test-baseline.json` done in `2-quality-baselining-3-test-baseline`
   - Validate functional integrity and business logic preservation as much as you can

4. **Code Review and Quality Assurance**:
   - Conduct ad'hoc code review on new code changes only
   - Validate adherence to refactoring objectives and success criteria
   - Document lessons learned and implementation insights in `6-refactoring-2-changelog.md`

## Output Format
Follow template structure: `[id:templates_dir]reduce-code-complexity/implementation-results.md`

The output should be saved as `6-refactoring-2-implementation.md` in the `[id:findings_dir]reduce-code-complexity/` directory, following the markdown structure defined in the template. Replace all placeholder values (enclosed in square brackets) with actual implementation results, complexity metrics, and quality assurance data.

### Key Template Sections to Complete:
- **Implementation Results**: Complete details for each refactoring target
- **Complexity Metrics**: Before/after measurements with improvement percentages
- **Quality Assurance**: Code review outcomes, testing results, static analysis
- **Business Impact**: Development velocity, bug reduction, maintainability improvements
- **Iteration Summary**: Overall metrics and team effort breakdown
- **Lessons Learned**: Key insights and recommendations for future iterations
- **Next Iteration Recommendations**: Prioritized suggestions for continuation

## Output to USER
- Confirmation: "Refactoring implementation completed successfully"
- Location: "Results saved to [id:findings_dir]reduce-code-complexity/6-refactoring-2-implementation.md"
- Timestamp: Implementation completion time
- Next phase: "Ready for Step : Validation and Quality Assessment"
   - Provides comprehensive implementation results with complexity metrics
   - Documents successful refactoring patterns and techniques applied
   - Establishes foundation for validation and quality assessment

## Domain-Specific Rules
- Rule 1: Implementation must follow designated refactoring patterns with comprehensive documentation of changes
- Rule 2: All refactoring changes must maintain or improve system performance and functional integrity
- Rule 3: Comprehensive testing (unit, integration, performance) required before declaring implementation complete
