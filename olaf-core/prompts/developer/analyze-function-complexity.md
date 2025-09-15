---
name: analyze-function-complexity
description: Analyze a specific function's complexity, structure, and provide detailed metrics similar to complexity analyzer output
tags: [function-analysis, complexity, code-quality, metrics]
---

## Framework Validation
You MUST apply the <olaf-work-instructions> framework.
You MUST pay special attention to:
- <olaf-general-role-and-behavior> - Expert domain approach
- <olaf-interaction-protocols> - Appropriate execution protocol
You MUST strictly apply <olaf-framework-validation>.

## Time Retrieval
You MUST get current time in YYYYMMDD-HHmm format using terminal commands:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **function_name**: string - Name of the function to analyze
- **file_path**: string - (Optional) Path to the file containing the function
- **language**: string - (Optional) Programming language (auto-detected if file_path provided)
- **context**: string - (Optional) Additional context about the function's purpose

## Process

1. **Function Location**:
   - If file_path provided, locate the function in the file
   - If only function_name provided, search the current workspace
   - Extract the complete function code including signature and body

2. **Complexity Analysis**:
   - Calculate cyclomatic complexity using standard patterns:
     - Decision points: if, else if, else, switch, case
     - Loops: for, foreach, while, do-while
     - Logical operators: &&, ||, and, or
     - Exception handling: try, catch, except, finally
     - Ternary operators: ? :
   - Count lines of code (excluding comments and blank lines)
   - Calculate complexity density (complexity / line_count)

3. **Structure Analysis**:
   - Function signature analysis (parameters, return type)
   - Nesting depth analysis
   - Variable scope analysis
   - Dependency analysis (functions/methods called)

4. **Quality Assessment**:
   - Code readability score
   - Maintainability indicators
   - Potential refactoring opportunities
   - Best practices adherence

## Output Format

Generate a detailed analysis report with the following structure:

```markdown
# Function Analysis Report

**Function**: `{function_name}`  
**File**: `{file_path}`  
**Language**: `{language}`  
**Analysis Date**: {timestamp}

## Function Signature
```{language}
{function_signature}
```

## Complexity Metrics
- **Cyclomatic Complexity**: {complexity_score}
- **Lines of Code**: {line_count}
- **Complexity Density**: {complexity_density}
- **Nesting Depth**: {max_nesting_depth}
- **Parameter Count**: {parameter_count}

## Complexity Breakdown
| Construct Type | Count | Complexity Points |
|---------------|-------|------------------|
| If/Else | {if_count} | {if_complexity} |
| Loops | {loop_count} | {loop_complexity} |
| Switch/Case | {switch_count} | {switch_complexity} |
| Logical Operators | {logical_count} | {logical_complexity} |
| Exception Handling | {exception_count} | {exception_complexity} |

## Risk Assessment
**Risk Level**: {risk_level} (Low/Moderate/High/Very High/Critical)

| Complexity Range | Risk | Status |
|-----------------|------|--------|
| 1-5 | Low | ✅ Simple, maintainable |
| 6-10 | Moderate | ⚠️ Acceptable, monitor |
| 11-20 | High | 🔶 Consider refactoring |
| 21-50 | Very High | 🔴 Refactor recommended |
| 50+ | Critical | 🚨 Immediate attention required |

## Code Quality Indicators
- **Readability**: {readability_score}/10
- **Maintainability**: {maintainability_score}/10
- **Testability**: {testability_score}/10

## Dependencies
- **Functions Called**: {called_functions}
- **External Dependencies**: {external_deps}
- **Coupling Level**: {coupling_level}

## Recommendations
{recommendations_list}

## Refactoring Opportunities
{refactoring_suggestions}

## Test Coverage Recommendations
Based on complexity score of {complexity_score}, this function requires:
- **Minimum Test Cases**: {min_test_cases}
- **Branch Coverage Tests**: {branch_tests}
- **Edge Case Tests**: {edge_case_tests}
```

## Output to USER
1. **Summary**: Brief overview of complexity and risk level
2. **Key Metrics**: Most important numbers (complexity, lines, density)
3. **Immediate Actions**: Priority recommendations
4. **Detailed Report**: Full analysis as formatted above

## Domain-Specific Rules
- Rule 1: Always provide specific, actionable recommendations
- Rule 2: Include complexity calculation methodology
- Rule 3: Consider language-specific patterns and idioms
- Rule 4: Provide context-appropriate thresholds
- Rule 5: Include both quantitative metrics and qualitative assessment

## Required Actions
1. Locate and extract the target function
2. Calculate all complexity metrics
3. Assess code quality indicators
4. Generate risk assessment
5. Provide specific recommendations
6. Format comprehensive report

⚠️ **Critical Notes**
- Use language-specific complexity patterns
- Consider function context and purpose
- Balance thoroughness with clarity
- Provide actionable, specific guidance
- Include positive aspects when present
