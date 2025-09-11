---
name: analyze-cyclomatic-complexity-metrics
description: Calculate cyclomatic complexity metrics and identify high-complexity areas for maintainability assessment
tags: [complexity, cyclomatic, metrics, maintainability]
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

You WILL use terminal commands, not training data for timestamps.

## Input Parameters
You MUST request these parameters if not provided by the user:
- **language_analysis_file**: string - Path to language distribution analysis output (REQUIRED)
- **repo_size_file**: string - Path to repository size metrics output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **complexity_threshold**: integer - Complexity threshold for flagging high-complexity areas (OPTIONAL, default: 10)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify language analysis (Task #3) and repository size metrics (Task #4) were completed
2. You WILL validate expected outcomes from previous steps:
   - `analyze-repo-language-distribution.md` exists with language data
   - `measure-repo-size-metrics.md` exists with size metrics
   - Repository structure and file inventory are available

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm language_analysis_file and repo_size_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location
- Verify Python script availability: `[id:tools_dir]/complexity_analyzer.py`

### 2. Execution Phase

**Python Script Execution (Primary Method)**:
- Check if `[id:tools_dir]commons/project-onboarding/complexity_analyzer.py` exists
- If script exists, execute: `python "[id:tools_dir]commons/project-onboarding/complexity_analyzer.py" "{workspace_path}" -o "{output_location}/script-complexity-analysis.md" -t {complexity_threshold}`
- Read and parse the generated script output file
- Extract key metrics: complexity statistics, function-level analysis, complexity distribution
- Parse most complex functions data, maintainability assessments, and risk categorizations
- Integrate script data into comprehensive complexity analysis combining both script results and manual insights
- If script execution fails, fall back to manual analysis

**Manual Analysis (Fallback Method)**:
- Calculate cyclomatic complexity for each function/method
- Aggregate complexity metrics by file and repository
- Use language-specific complexity analysis tools where available

**High-Complexity Identification**:
- Identify functions/methods exceeding complexity threshold
- Rank high-complexity areas by severity and impact
- Analyze complexity distribution patterns across repositories

**Maintainability Index Calculation**:
- Calculate maintainability index combining complexity, LOC, and Halstead metrics
- Assess code maintainability at file and repository levels
- Identify areas requiring refactoring attention

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for complexity analysis execution
- Execute Python script and parse its output data
- Read script-generated metrics: complexity statistics, function analysis, distribution tables
- Extract most complex functions data, maintainability assessments, and risk categorizations from script output
- Combine script data with manual analysis for comprehensive complexity assessment
- Identify high-complexity areas using both data sources
- Generate final complexity report integrating all collected data

### 3. Validation Phase
You WILL validate results:
- Confirm complexity calculations are accurate
- Verify high-complexity area identification is complete
- Validate maintainability index calculations are consistent

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-cyclomatic-complexity-metrics.md` in `[id:ads_dir]product/context/{repository-name}/`
- **Data Integration Requirements**: Parse script output and incorporate:
  - Complexity statistics tables (average, maximum, distribution)
  - Most complex functions analysis with file locations and line numbers
  - Complexity distribution tables by range categories
  - Function-level analysis with complexity scores and density metrics
  - Maintainability assessments and refactoring recommendations
- Supporting files: Complexity distribution charts and high-complexity hotspot reports
- Documentation: Structured markdown combining script data with manual analysis insights

## User Communication

### Progress Updates
- Confirmation when complexity calculation completes
- High-complexity area identification progress
- Maintainability index calculation completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Total complexity metrics calculated across repositories
- High-complexity areas identified and ranked
- Maintainability index assessment completed
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-cyclomatic-complexity-metrics.md`

### Next Steps
You WILL clearly define:
- Complexity analysis completed for Phase 7 Task #19
- Dependency analysis ready for Phase 7 Task #20
- Files provided: complexity metrics for quality assessment
- Dependencies: Tasks #3 (languages) and #4 (repository size) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Use language-appropriate complexity calculation methods
- Rule 2: Focus on functions/methods that exceed established complexity thresholds
- Rule 3: Provide actionable refactoring recommendations for high-complexity areas
- Rule 4: Calculate maintainability index using industry-standard formulas

## Success Criteria
You WILL consider the task complete when:
- [ ] Cyclomatic complexity calculated for all source code files
- [ ] High-complexity areas identified and ranked by severity
- [ ] Maintainability index calculated at file and repository levels
- [ ] Refactoring recommendations provided for complex areas
- [ ] Output file generated with comprehensive complexity analysis

## Required Actions
1. Validate language analysis and repository size input files
2. Execute complexity calculation across all repositories
3. Generate high-complexity area identification and ranking
4. Create structured output file with complexity metrics and recommendations
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **Language-Specific Tool Missing**: Use generic complexity analysis or manual assessment
- **Python Script Missing**: Continue with manual complexity analysis, note missing automation
- **Large File Analysis Timeout**: Implement sampling approach for very large files
- **Complexity Tool Failures**: Document tool limitations and provide manual analysis alternatives

⚠️ **Critical Requirements**
- MANDATORY: Use appropriate complexity calculation methods for each programming language
- NEVER ignore high-complexity areas that exceed established thresholds
- ALWAYS provide actionable refactoring recommendations with specific improvement suggestions
- ALWAYS validate complexity calculations against established industry standards
- ALWAYS document methodology used for complexity calculation and maintainability assessment
