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
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

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
- **CRITICAL**: Read and parse the generated script output file `{output_location}/script-contributor-analysis.md`
- **Extract structured data from script output**:
  - Executive Summary: Commit distribution, bus factor, file ownership, risk assessment overview
  - Contributor Statistics: Total commits, human vs automated commits, unique contributors, bus factor
  - Top Human Contributors table: Rank, contributor names, commit counts, percentages, emails, risk levels
  - Bus Factor Analysis: Critical contributors representing 50% of commits with detailed breakdown
  - Automated Contributors table: Bot/service names, commit counts, purposes (CI/CD, Dependencies, Deployment)
  - File Ownership Analysis: High ownership concentration files with primary owners and percentages
  - Risk Assessment: Overall risk level, risk factors, recommendations, files requiring attention
  - Commit Pattern Analysis: Activity patterns for top contributors with timing and frequency data
- **Parse specific data points**:
  - Bus factor number and critical contributor identification
  - Risk level assessment (LOW/MEDIUM/HIGH/CRITICAL) with specific recommendations
  - File ownership concentration patterns and single-owner file identification
  - Contributor risk levels and commit distribution percentages
  - Automated vs human contribution ratios and bot detection results
- **Data Integration**: Combine parsed script metrics with additional manual analysis insights
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
- Execute Python script as primary method for comprehensive analysis
- If script succeeds, parse and integrate all structured data from output file
- If script fails, perform manual analysis using fallback methods
- Combine all data sources for comprehensive contributor assessment
- Generate final analysis report with bus factor, risk assessment, and succession planning recommendations

### 3. Validation Phase
You WILL validate results:
- **CRITICAL**: Confirm the script output file `{output_location}/script-contributor-analysis.md` was successfully read and parsed
- **Verify data extraction**: Ensure all tables and sections from script output are included in final analysis
- Confirm contributor impact analysis covers all critical areas
- Verify bus factor calculations are accurate and actionable
- Validate risk mitigation recommendations are comprehensive
- **Cross-reference**: Ensure script data matches manual analysis where applicable

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-critical-contributor-impact.md` in `[id:ads_dir]product/context/{repository-name}/`
- **MANDATORY Data Integration Requirements**: Parse script output file and incorporate ALL structured data:
  - **Executive Summary**: Include commit distribution, bus factor, file ownership, and risk assessment overview
  - **Contributor Statistics**: Include total commits, human vs automated commits, unique contributors, and bus factor
  - **Top Human Contributors**: Include complete table with rank, names, commit counts, percentages, emails, and risk levels
  - **Bus Factor Analysis**: Include critical contributors representing 50% of commits with detailed breakdown
  - **Automated Contributors**: Include bot/service table with names, commit counts, and purposes
  - **File Ownership Analysis**: Include high ownership concentration files with primary owners and percentages
  - **Risk Assessment**: Include overall risk level, risk factors, recommendations, and files requiring attention
  - **Commit Pattern Analysis**: Include activity patterns for top contributors with timing and frequency data
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
