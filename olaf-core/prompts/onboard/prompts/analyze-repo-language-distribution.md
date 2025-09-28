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
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

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
- **CRITICAL**: Read and parse the generated script output file `{output_location}/script-language-distribution.md`
- **Extract structured data from script output**:
  - Language Distribution Overview table: Languages, file counts, percentages, LOC, avg lines per file
  - Project Type Detection section: Detected project types with configuration files
  - Technology Stack Details: Detailed info for Node.js, Python, Java (versions, dependencies, scripts)
  - Project Structure Analysis: Monorepo detection, top-level directories with file counts
  - Language-Specific File Examples: Sample files for each detected language
  - Summary and Recommendations: Primary/secondary languages, polyglot assessment, next steps
- **Parse specific data points**:
  - Total files analyzed and total lines of code across all languages
  - Language ranking by file count and LOC percentage
  - Project type classifications (Node.js, Python, Java/Maven, etc.) with config files
  - Monorepo indicators and directory structure analysis
  - Technology stack details including dependency counts and version information
- **Data Integration**: Combine parsed script metrics with additional manual analysis insights
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
- Execute Python script as primary method for comprehensive analysis
- If script succeeds, parse and integrate all structured data from output file
- If script fails, perform manual analysis using fallback methods
- Combine all data sources for comprehensive language assessment
- Generate final analysis report with language distribution, project types, and polyglot assessment

### 3. Validation Phase
You WILL validate results:
- **CRITICAL**: Confirm the script output file `{output_location}/script-language-distribution.md` was successfully read and parsed
- **Verify data extraction**: Ensure all tables and sections from script output are included in final analysis
- Confirm language detection accuracy across all repositories
- Verify prevalence rankings are correctly calculated
- Validate polyglot architecture patterns are properly identified
- **Cross-reference**: Ensure script data matches manual analysis where applicable

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-repo-language-distribution.md` in `[id:ads_dir]product/context/{repository-name}/`
- **MANDATORY Data Integration Requirements**: Parse script output file and incorporate ALL structured data:
  - **Language Distribution Overview**: Include complete table with languages, file counts, percentages, LOC, and avg lines per file
  - **Project Type Detection**: Include detected project types with their configuration files (package.json, pom.xml, etc.)
  - **Technology Stack Details**: Include detailed information for Node.js, Python, Java including versions, dependency counts, and scripts
  - **Project Structure Analysis**: Include monorepo detection results and top-level directories with file counts
  - **Language-Specific File Examples**: Include sample file paths for each detected language
  - **Summary and Recommendations**: Include primary/secondary language identification, polyglot assessment, and next steps from script output
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
