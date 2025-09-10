---
name: analyze-critical-contributor-impact
description: Analyze contributors with highest impact, contribution patterns, and bus factor analysis
tags: [contributors, impact, patterns, busfactor]
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
- **hotspot_analysis_file**: string - Path to hotspot analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **analysis_period_months**: integer - Number of months to analyze for contributor patterns (OPTIONAL, default: 12)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify hotspot analysis (Task #18) was completed
2. You WILL validate expected outcomes from previous step:
   - `identify-code-hotspot-patterns.md` exists with hotspot data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm hotspot_analysis_file exists and is readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Python Script Execution (Primary Method)**:
- Check if `[id:tools_dir]commons/project-onboarding/contributor_analyzer.py` exists
- If script exists, execute: `python "[id:tools_dir]commons/project-onboarding/contributor_analyzer.py" "{workspace_path}" -m {analysis_period_months} -o "{output_location}/script-contributor-analysis.md" -v`
- Read and parse the generated script output file
- Extract key metrics: contributor statistics, bus factor, file ownership patterns
- Parse risk assessment, commit patterns, and mitigation recommendations from script output
- Integrate script data into comprehensive contributor analysis combining both script results and manual insights
- If script execution fails, fall back to manual analysis

**Manual Analysis (Fallback Method)**:
- Analyze Git blame and contribution patterns
- Identify contributors with highest impact on critical code areas

**Contribution Pattern Assessment**:
- Document contribution frequency and code ownership patterns
- Analyze knowledge distribution across team members
- Identify single points of failure in code ownership

**Bus Factor Analysis**:
- Calculate bus factor for critical code areas and repositories
- Assess knowledge transfer risks and mitigation strategies
- Document succession planning recommendations

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for contributor analysis execution
- Execute Python script and parse its output data
- Read script-generated metrics: contributor statistics, bus factor, ownership patterns
- Extract risk assessment, commit patterns, and succession planning data from script output
- Combine script data with manual analysis for comprehensive contributor assessment
- Document contributor analysis and risk mitigation using both data sources
- Generate final contributor report integrating all collected data

### 3. Validation Phase
You WILL validate results:
- Confirm contributor impact analysis covers all critical areas
- Verify bus factor calculations are accurate and actionable
- Validate risk mitigation recommendations are comprehensive

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-critical-contributor-impact.md` in `[id:ads_dir]product/context/{repository-name}/`
- **Data Integration Requirements**: Parse script output and incorporate:
  - Top contributor statistics with commit counts and risk levels
  - Bus factor analysis with critical contributor identification
  - File ownership patterns with concentration risks
  - Risk assessment with specific mitigation recommendations
  - Commit pattern analysis with activity trends
- Supporting files: Contributor impact matrix and knowledge distribution charts
- Documentation: Structured markdown combining script data with manual analysis insights

## User Communication

### Progress Updates
- Confirmation when contributor impact analysis completes
- Contribution pattern assessment progress
- Bus factor analysis completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Critical contributors identified with impact analysis
- Contribution patterns documented with knowledge distribution
- Bus factor analysis completed with risk mitigation recommendations
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-critical-contributor-impact.md`

### Next Steps
You WILL clearly define:
- Critical contributors analysis completed for Phase 9 Task #19
- Data governance analysis ready for Phase 6 Task #26
- Files provided: contributor data for knowledge management
- Dependencies: Task #18 (hotspot analysis) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual contribution patterns from Git history, not assumptions
- Rule 2: Calculate bus factor based on critical code areas and business impact
- Rule 3: Provide specific knowledge transfer and documentation recommendations
- Rule 4: Assess contributor impact on both code quality and business continuity

## Success Criteria
You WILL consider the task complete when:
- [ ] Critical contributors identified with impact quantification
- [ ] Contribution patterns analyzed with knowledge distribution assessment
- [ ] Bus factor calculated for critical code areas
- [ ] Knowledge transfer and succession planning recommendations provided
- [ ] Output file generated with comprehensive contributor impact analysis

## Required Actions
1. Validate hotspot analysis input file
2. Execute contributor impact and contribution pattern analysis
3. Generate bus factor analysis and risk mitigation recommendations
4. Create structured output file with contributor analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **Git History Access Issues**: Document limitations and recommend manual analysis
- **Python Script Missing**: Continue with manual contributor analysis, note missing automation
- **Anonymous Contributors**: Document limitations and focus on identifiable contributors

⚠️ **Critical Requirements**
- MANDATORY: Base contributor analysis on actual Git history and code ownership patterns
- NEVER ignore high-impact contributors in critical code areas for bus factor calculation
- ALWAYS provide specific knowledge transfer recommendations for high-risk areas
- ALWAYS assess both technical impact and business continuity risks in contributor analysis
