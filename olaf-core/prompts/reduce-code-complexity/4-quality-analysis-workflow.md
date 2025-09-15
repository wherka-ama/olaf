# Sequential/Chained Workflow Template

> **Note:** All files referenced below are either prompts located in `[id:prompts_dir]` or tools located in `[id:tools_dir]`, as specified in the memory map file.
> The solution to analyze is in [id:core_dir] and all new non-temporary created files are to be created in [id:findings_dir] folder.

# 4-Quality-Analysis Workflow: Comprehensive Code Quality Assessment

## Workflow Type
Sequential/Chained - Each analysis step depends on the output of the previous step and builds comprehensive quality profile

## Workflow Overview
Performs comprehensive code quality analysis through git history analysis, cyclomatic complexity measurement, and Halstead metrics calculation to identify refactoring opportunities and establish quality improvement priorities.

## Prerequisites
- 3-Discovery-Baselining-Consolidation workflow completed successfully with comprehensive foundation report
- Access to project source code and git repository in `[id:core_dir]`
- Write permissions to `[id:findings_dir]` for output files
- Static analysis tools available for detected programming language

## Input Requirements
- **Primary Input:** `3-discovery-baselining-consolidation-report.json` from 3-Discovery-Baselining-Consolidation workflow
- **Secondary Inputs:** Git repository history and source code files
- **Input Format:** JSON foundation data and git/source code repositories

## Output Specifications
- **Primary Output:** `4-quality-analysis-2-complexity-assessment.md`
- **Secondary Outputs:** Individual analysis outputs (git-analysis., complexity-analysis.json, halstead-analysis.json)
- **Output Location:** [id:findings_dir]

## Workflow Steps

### Step 1: Git History Analysis
- **Tool:** `[id:tools_dir]reduce-code-complexity/4-quality-analysis-1-analyze-git-history.ps1`
- **Input:** Project path 
- **Output:** `files-to-be-analyzed.txt`
- **Description:** Analyze git repository history to identify code most changed files in the past 12 months
- **Validation:** Verify git analysis contains code hotspots, change frequency data, and contributor patterns for refactoring prioritization
- **Execution:** Run PowerShell script with project path parameter
- **Command:** `[id:findings_dir]reduce-code-complexity/4-quality-analysis-1-analyze-git-history.ps1 -ProjectPath [id:core_dir] -OutputPath [id:findings_dir]reduce-code-complexity/files-to-be-analyzed.txt`

### Step 2: Complexity Analysis
- **Prompt/Tool:** `[id:prompts_dir]reduce-code-complexity/4-quality-analysis-2-complexity-assessment.md`
- **Input:** `files-to-be-analyzed.txt`
- **Output:** `4-quality-analysis-2-complexity-assessment.md`, `cyclomatic-complexity.md`, `halstead-metrics.md`
- **Description:** Perform comprehensive static code analysis to measure cyclomatic complexity, halstead metrics, identify code smells, and assess structural quality issues with prioritization based on git hotspots found in files-to-be-analyzed.txt
- **Validation:** Verify complexity analysis contains detailed metrics for all major code components with severity classifications and improvement recommendations

## Data Flow Diagram
```
[Foundation Report] → [Step 1: Git Analysis] → [files-to-be-analyzed.txt] → [Step 2: Complexity Analysis] → [`cyclomatic-complexity.md`, `halstead-metrics.md`, `4-quality-analysis-2-complexity-assessment.md`]
```

## Error Handling
- **Step Failure:** Log detailed error information, assess impact on quality assessment completeness
- **Recovery:** Each analysis step can be restarted independently using preserved input data
- **Rollback:** No rollback needed as this is a read-only analysis process

## Completion Criteria
- [ ] All analysis steps completed successfully with comprehensive quality data
- [ ] All outputs validated and contain expected metrics and assessments
- [ ] No critical analysis failures that would prevent strategic planning
- [ ] Consolidated quality assessment created with prioritized improvement opportunities

## Next Steps
- Proceed to Sub-workflow 5: Analysis Strategy
- Quality analysis results provide foundation for strategic refactoring planning
- Combined analysis data enables data-driven prioritization of complexity reduction efforts
