---
name: identify-code-hotspot-patterns
description: Identify files modified frequently, modification patterns, and architectural debt areas
tags: [hotspots, patterns, modifications, debt]
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
- **workspace_structure_file**: string - Path to workspace content analysis output (REQUIRED)
- **complexity_analysis_file**: string - Path to complexity analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **analysis_period_months**: integer - Number of months to analyze for hotspot patterns (OPTIONAL, default: 12)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify workspace structure (Task #1) and complexity analysis (Task #19) were completed
2. You WILL validate expected outcomes from previous steps:
   - `analyze-workspace-content-structure.md` exists with repository data
   - `analyze-cyclomatic-complexity-metrics.md` exists with complexity data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm workspace_structure_file and complexity_analysis_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location
- Verify Python script availability: `[id:tools_dir]/hotspot_analyzer.py`

### 2. Execution Phase

**Python Script Execution (Primary Method)**:
- Check if `[id:tools_dir]commons/project-onboarding/hotspot_analyzer.py` exists
- If script exists, execute: `python "[id:tools_dir]commons/project-onboarding/hotspot_analyzer.py" "{workspace_path}" -o "{output_location}/script-hotspot-analysis.md" -m {analysis_period_months}`
- Read and parse the generated script output file
- Extract key metrics: hotspot rankings, change frequency data, complexity correlations
- Parse risk scores, modification patterns, and prioritization recommendations from script output
- Integrate script data into comprehensive hotspot analysis combining both script results and manual insights
- If script execution fails, fall back to manual analysis

**Manual Analysis (Fallback Method)**:
- Analyze git commit history for frequently changed files
- Identify files with high change frequency and complexity correlation
- Analyze Git commit history and file modification patterns
- Identify frequently modified files and change hotspots

**Modification Pattern Assessment**:
- Document modification frequency and change patterns
- Analyze correlation between complexity and modification frequency
- Identify architectural debt areas requiring attention

**Hotspot Prioritization**:
- Rank hotspots by modification frequency and complexity
- Assess business impact and refactoring priority
- Document hotspot remediation recommendations

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for hotspot analysis execution
- Execute Python script and parse its output data
- Read script-generated metrics: hotspot rankings, change frequency tables, complexity correlations
- Extract risk scores, modification patterns, and prioritization data from script output
- Combine script data with manual analysis for comprehensive hotspot assessment
- Document hotspot analysis and refactoring priorities using both data sources
- Generate final hotspot report integrating all collected data

### 3. Validation Phase
You WILL validate results:
- Confirm hotspot identification covers all repositories
- Verify modification pattern analysis provides actionable insights
- Validate prioritization recommendations are based on data

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `identify-code-hotspot-patterns.md` in `[id:ads_dir]product/context/{repository-name}/`
- **Data Integration Requirements**: Parse script output and incorporate:
  - Top complexity hotspots tables with change frequency and risk scores
  - Analysis statistics (total files analyzed, average complexity scores)
  - Risk categorization data with high-risk file identification
  - Modification pattern analysis with complexity correlations
  - Prioritization recommendations based on combined metrics
- Supporting files: Hotspot heatmaps and modification pattern charts
- Documentation: Structured markdown combining script data with manual analysis insights

## User Communication

### Progress Updates
- Confirmation when Git history analysis completes
- Modification pattern assessment progress
- Hotspot prioritization completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Code hotspots identified with modification frequency analysis
- Modification patterns documented with complexity correlation
- Hotspot prioritization completed with refactoring recommendations
- Output file location: `[id:ads_dir]product/context/{repository-name}/identify-code-hotspot-patterns.md`

### Next Steps
You WILL clearly define:
- Hotspot analysis completed for Phase 9 Task #18
- Critical contributors analysis ready for Phase 9 Task #19
- Files provided: hotspot data for contributor impact analysis
- Dependencies: Tasks #1 (workspace structure) and #19 (complexity analysis) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual modification patterns from Git history, not assumptions
- Rule 2: Correlate hotspots with complexity metrics for prioritization
- Rule 3: Consider business impact when prioritizing refactoring efforts
- Rule 4: Provide specific refactoring recommendations for high-priority hotspots

## Success Criteria
You WILL consider the task complete when:
- [ ] Code hotspots identified with modification frequency analysis
- [ ] Modification patterns documented with statistical analysis
- [ ] Hotspots prioritized by complexity and business impact
- [ ] Refactoring recommendations provided for high-priority areas
- [ ] Output file generated with comprehensive hotspot analysis

## Required Actions
1. Validate workspace structure and complexity analysis input files
2. Execute Git history analysis and modification pattern assessment
3. Generate hotspot prioritization and refactoring recommendations
4. Create structured output file with hotspot analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **Git History Access Issues**: Document limitations and recommend manual analysis
- **Python Script Missing**: Continue with manual hotspot analysis, note missing automation
- **Large Repository Analysis**: Implement sampling approach for performance

⚠️ **Critical Requirements**
- MANDATORY: Base hotspot analysis on actual Git history and modification patterns
- NEVER ignore high-complexity, frequently-modified files in prioritization
- ALWAYS correlate modification frequency with complexity metrics for accurate prioritization
- ALWAYS provide specific, actionable refactoring recommendations for identified hotspots
