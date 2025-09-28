---
name: measure-repo-size-metrics
description: Calculate comprehensive repository size metrics including file count, LOC, and Git repository size
tags: [repository, metrics, size, analysis]
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
   - Repository paths and structure are documented

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm workspace_structure_file exists and is readable
- Validate repository_name follows naming conventions
- Check write access to output location
- Verify Python script availability: `[id:tools_dir]/repo_size_metrics_calculator.py`

### 2. Execution Phase

**Python Script Execution (Primary Method)**:
- Check if `[id:tools_dir]commons/project-onboarding/repo_size_metrics_calculator.py` exists
- If script exists, execute: `python "[id:tools_dir]commons/project-onboarding/repo_size_metrics_calculator.py" "{workspace_path}" -o "{output_location}/script-size-metrics.md"`
- **CRITICAL**: Read and parse the generated script output file `{output_location}/script-size-metrics.md`
- **Extract structured data from script output**:
  - Overview Summary table: Repository size, Git directory size, file count, LOC, averages
  - File Category Breakdown table: Categories, file counts, percentages, sizes, lines, avg size per file
  - Git Repository Statistics table: Git directory size, commits, branches, tags, remotes
  - Largest Files table: Top 20 files with paths, sizes, types, line counts
  - Code Density Analysis table: File types with total lines, file counts, avg/max lines per file
  - Repository Size Assessment: Size category, assessment, recommendations, next steps
- **Parse specific data points**:
  - Total repository size (including and excluding .git directory)
  - File category distribution with size and line count breakdowns
  - Git repository metrics (commits, branches, tags, remotes)
  - Largest files identification with exact paths and sizes
  - Size optimization recommendations and large file detection
- **Data Integration**: Combine parsed script metrics with additional manual analysis insights
- If script execution fails, fall back to manual analysis

**Manual Analysis (Fallback Method)**:
- Calculate total repository size in bytes/MB/GB
- Count total files and directories per repository

**Binary File Analysis**:
- Identify and measure binary file sizes (images, executables, archives)
- Calculate total binary storage requirements
- Document large file impact on repository size

**Git Repository Metrics**:
- Analyze .git directory size and repository statistics
- Count commits, branches, tags, and remotes
- Assess repository history impact on total size

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for metrics calculation
- Execute Python script as primary method for comprehensive analysis
- If script succeeds, parse and integrate all structured data from output file
- If script fails, perform manual analysis using fallback methods
- Combine all data sources for comprehensive size assessment
- Generate final metrics report with size analysis, file breakdowns, and optimization recommendations

### 3. Validation Phase
You WILL validate results:
- **CRITICAL**: Confirm the script output file `{output_location}/script-size-metrics.md` was successfully read and parsed
- **Verify data extraction**: Ensure all tables and sections from script output are included in final analysis
- Confirm all metrics calculated accurately
- Verify size calculations include all repository components
- Validate baseline metrics are comprehensive
- **Cross-reference**: Ensure script data matches manual analysis where applicable

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `measure-repo-size-metrics.md` in `[id:ads_dir]product/context/{repository-name}/`
- **MANDATORY Data Integration Requirements**: Parse script output file and incorporate ALL structured data:
  - **Overview Summary**: Include complete table with repository size, Git directory size, file count, LOC, and averages
  - **File Category Breakdown**: Include complete table with categories, file counts, percentages, sizes, lines, and avg size per file
  - **Git Repository Statistics**: Include Git directory size, commit count, branches, tags, and remotes
  - **Largest Files**: Include top 20 files table with paths, sizes, types, and line counts
  - **Code Density Analysis**: Include file types with total lines, file counts, avg/max lines per file
  - **Repository Size Assessment**: Include size category, assessment, recommendations, and next steps from script output
- Supporting files: Size metrics charts and distribution analysis
- Documentation: Structured markdown combining script data with manual analysis insights

## User Communication

### Progress Updates
- Confirmation when file counting completes
- LOC analysis progress by repository
- Binary file analysis completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Total files and LOC across all repositories
- Repository size rankings and distributions
- Binary file impact analysis results
- Output file location: `[id:ads_dir]product/context/{repository-name}/measure-repo-size-metrics.md`

### Next Steps
You WILL clearly define:
- Repository size metrics completed for Phase 1 Task #4
- Technology stack analysis ready for Phase 2 Task #5
- Files provided: baseline metrics for complexity and quality analysis
- Dependencies: Task #1 (workspace structure) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Exclude temporary files, build artifacts, and cache directories from metrics
- Rule 2: Separate source code metrics from configuration and documentation
- Rule 3: Document large files that significantly impact repository size
- Rule 4: Provide both absolute and relative size comparisons

## Success Criteria
You WILL consider the task complete when:
- [ ] File count metrics calculated for all repositories
- [ ] Lines of code analysis completed with language breakdown
- [ ] Binary file sizes measured and documented
- [ ] Git repository metrics collected and analyzed
- [ ] Output file generated with comprehensive size statistics

## Required Actions
1. Validate workspace structure input file and prerequisites
2. Execute file counting and LOC analysis across repositories
3. Generate binary file and Git repository size analysis
4. Create structured output file with comprehensive metrics
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Workspace Structure File**: Request completion of Task #1 first
- **Repository Access Denied**: Document inaccessible repositories and continue with available ones
- **Python Script Missing**: Continue with manual metrics calculation, note missing automation
- **Large Repository Timeout**: Implement sampling or chunked analysis approach
- **Git Command Failures**: Use file system analysis as fallback for repository size

⚠️ **Critical Requirements**
- MANDATORY: Exclude build artifacts, temporary files, and cache directories from metrics
- NEVER include generated files in source code line counts
- ALWAYS document methodology for size calculations
- ALWAYS provide both raw numbers and normalized metrics for comparison
- ALWAYS validate metrics accuracy before finalizing results
