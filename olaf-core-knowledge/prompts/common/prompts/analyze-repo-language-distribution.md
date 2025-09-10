---
name: analyze-repo-language-distribution
description: Analyze programming language distribution across repositories with polyglot architecture identification
tags: [language, analysis, distribution, polyglot]
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
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify workspace content analysis (Task #1) was completed
2. You WILL validate expected outcomes from previous step:
   - `analyze-workspace-content-structure.md` exists and contains repository data
   - Repository structure is documented and accessible

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm workspace_structure_file exists and is readable
- Validate repository_name follows naming conventions
- Check write access to output location
- Verify Python script availability: `[id:tools_dir]/language_distribution_analyzer.py`

### 2. Execution Phase

**Python Script Execution (Primary Method)**:
- Check if `[id:tools_dir]commons/project-onboarding/language_distribution_analyzer.py` exists
- If script exists, execute: `python "[id:tools_dir]commons/project-onboarding/language_distribution_analyzer.py" "{workspace_path}" -o "{output_location}/script-language-distribution.md"`
- Read and parse the generated script output file
- Extract key metrics: language percentages, file counts, LOC statistics, project type detection
- Integrate script data into comprehensive analysis combining both script results and manual insights
- If script execution fails, fall back to manual analysis

**Manual Analysis (Fallback Method)**:
- Analyze file extensions across all repositories
- Count lines of code by language using language-agnostic approach

**Distribution Analysis**:
- Rank languages by prevalence (most to least used)
- Calculate percentage distribution across repositories
- Identify primary and secondary languages per repository

**Polyglot Architecture Assessment**:
- Identify repositories using multiple languages
- Analyze mixed-language patterns and integration approaches
- Document polyglot architecture benefits and complexity

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for language analysis execution
- Execute Python script and parse its output data
- Read script-generated metrics: language distribution tables, file counts, LOC statistics
- Extract project type detection and technology stack details from script output
- Combine script data with manual analysis for comprehensive language assessment
- Identify mixed-language patterns and polyglot architectures using both data sources
- Generate final analysis report integrating all collected data

### 3. Validation Phase
You WILL validate results:
- Confirm language detection accuracy across all repositories
- Verify prevalence rankings are correctly calculated
- Validate polyglot architecture patterns are properly identified

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-repo-language-distribution.md` in `[id:ads_dir]product/context/{repository-name}/`
- **Data Integration Requirements**: Parse script output and incorporate:
  - Language distribution tables with percentages and file counts
  - Technology stack details and project type detection
  - LOC statistics and file category breakdowns
  - Monorepo structure analysis from script
- Supporting files: Language distribution charts and polyglot architecture diagrams
- Documentation: Structured markdown combining script data with manual analysis insights

## User Communication

### Progress Updates
- Confirmation when language detection completes
- Repository analysis progress by language count
- Polyglot pattern identification status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Total languages identified across workspace
- Language prevalence rankings and percentages
- Polyglot repositories and architecture patterns identified
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-repo-language-distribution.md`

### Next Steps
You WILL clearly define:
- Programming language analysis completed for Phase 1 Task #3
- Repository size metrics ready for Phase 1 Task #4
- Files provided: language distribution data for technology stack analysis
- Dependencies: Task #1 (workspace structure) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Use file extension analysis as primary language detection method
- Rule 2: Count actual lines of code, excluding comments and blank lines where possible
- Rule 3: Identify configuration languages (YAML, JSON, XML) separately from programming languages
- Rule 4: Document polyglot patterns with clear integration rationale

## Success Criteria
You WILL consider the task complete when:
- [ ] All languages identified across all repositories
- [ ] Language prevalence ranked from most to least used
- [ ] Multiple languages per repository documented
- [ ] Polyglot architecture patterns identified and analyzed
- [ ] Output file generated with comprehensive language distribution data

## Required Actions
1. Validate workspace structure input file and prerequisites
2. Execute language detection and distribution analysis
3. Generate polyglot architecture pattern identification
4. Create structured output file with language statistics
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Workspace Structure File**: Request completion of Task #1 first
- **Language Detection Failures**: Use manual file extension analysis as fallback
- **Python Script Missing**: Continue with manual analysis, note missing automation
- **Large Repository Timeout**: Implement sampling approach for very large codebases
- **Ambiguous File Types**: Document as unknown/other category with file extensions listed

⚠️ **Critical Requirements**
- MANDATORY: Use language-agnostic detection methods that work across all programming languages
- NEVER assume language based on repository name or description alone
- ALWAYS validate language detection against actual file contents when possible
- ALWAYS document polyglot architecture complexity and integration patterns
- ALWAYS provide percentage distributions for quantitative analysis
