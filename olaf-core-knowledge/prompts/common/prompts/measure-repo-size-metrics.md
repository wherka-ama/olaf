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
- Read and parse the generated script output file
- Extract key metrics: total size, file counts, LOC statistics, Git repository metrics
- Parse file category breakdowns, largest files data, and binary file analysis
- Integrate script data into comprehensive size analysis combining both script results and manual insights
- If script execution fails, fall back to manual analysis

**Manual Analysis (Fallback Method)**:
- Calculate total repository size in bytes/MB/GB
- Count total files and directories per repository

**Binary File Analysis**:
- Identify and measure binary file sizes (images, executables, archives)
- Calculate total binary storage requirements
- Document large file impact on repository size

**Git Repository Metrics**:
- Execute command: `git count-objects -vH` in each repository
- Measure .git directory size and object count
- Analyze repository history impact on size

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for metrics calculation
- Execute Python script and parse its output data
- Read script-generated metrics: repository size tables, file category breakdowns, Git statistics
- Extract largest files data, binary file analysis, and LOC statistics from script output
- Combine script data with manual analysis for comprehensive size assessment
- Document size distribution patterns using both data sources
- Generate final metrics report integrating all collected data

### 3. Validation Phase
You WILL validate results:
- Confirm all metrics calculated accurately
- Verify size calculations include all repository components
- Validate baseline metrics are comprehensive

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `measure-repo-size-metrics.md` in `[id:ads_dir]product/context/{repository-name}/`
- **Data Integration Requirements**: Parse script output and incorporate:
  - Repository size overview tables with total sizes and file counts
  - File category breakdowns with percentages and sizes
  - Git repository statistics (commits, branches, tags)
  - Largest files analysis with binary file identification
  - LOC statistics and average file metrics
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
