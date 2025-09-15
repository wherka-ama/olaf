---
name: 4-quality-a   - Script**: `[id:tools_dir]reduce-code-complexity/4-quality-analysis-2-analyze-complexity.ps1`alysis-2-complexity-assessment
description: Perform comprehensive static code analysis to measure cyclomatic complexity and identify structural quality issues
tags: [quality-analysis, complexity-analysis, cyclomatic-complexity, halstead-analysis]
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

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **foundation_report_file**: string - Path to foundation report (3-discovery-baselining-consolidation-report.json)
- **git_analysis_file**: string - Path to git analysis results (4-quality-analysis-1-git-history.json)
- **output_location**: string - Where to save complexity analysis results (defaults to [id:findings_dir]reduce-code-complexity/)

## Previous Steps or Phase
1. Step 1: Git History Analysis completed successfully
2. Expected outcomes: Code hotspots identified with change patterns and refactoring priorities established

## Process

1. **Static Code Automation Integration**

### Existing Complexity Analysis Tool
- **Script**: `[id:tools_dir]reduce-code-complexity/analyze-cyclomatic-complexity.ps1`
- **Parameters**: 
  - `RepoPath`: Path to target repository
  - `OutputFile`: Path for complexity analysis results [id:findings_dir]reduce-code-complexity/
  - `ComplexityThreshold`: Threshold for flagging high-complexity functions
  - `FileExtensions`: Array of file extensions to analyze [id:findings_dir]reduce-code-complexity/(files-to-analyze.txt)
- **Output**: Markdown reports with comprehensive complexity analysis
- **Integration**: Results feed into Halstead metrics analysis and refactoring strategy

2.  **Quality Issue Prioritization**:
   - Combine complexity metrics with git hotspot data for priority ranking
   - Identify highest-impact refactoring opportunities
   - Assess risk vs. benefit for each identified issue
   - Create actionable refactoring recommendations

## Output Format
Follow template structure: `[id:templates_dir]reduce-code-complexity/complexity-analysis-results.md`

The output should be saved as `4-quality-analysis-2-complexity-assessment.md` in the [id:findings_dir]reduce-code-complexity/ directory, following the markdown structure defined in the template. Replace all placeholder values (enclosed in square brackets) with actual analysis results.

## Output to USER
- Confirmation: "Complexity analysis completed successfully"
- Location: "Results saved to [id:findings_dir]reduce-code-complexity/4-quality-analysis-2-complexity-assessment.md"
- Timestamp: Analysis completion time
- Next phase: "Ready for phase 5 : analysis strategy"
   - Identifies specific refactoring targets with priority rankings
   - Establishes measurable complexity reduction goals for refactoring efforts

## Domain-Specific Rules
- Rule 1: Complexity analysis must prioritize files identified as git hotspots for focused assessment
- Rule 2: All complexity metrics must include baseline comparisons and improvement targets
- Rule 3: Refactoring recommendations must include effort estimates and risk assessments for planning purposes
