---
name: analyze-workspace-content-structure
description: Analyze workspace content structure, identify repository relationships and dependencies
tags: [workspace, analysis, repository, dependencies]
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
- **workspace_path**: string - Full path to workspace directory to analyze (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **exclude_patterns**: array - Patterns to exclude from analysis (legacy, temp, etc.) (OPTIONAL)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm workspace_path exists and is accessible
- Validate repository_name follows naming conventions
- Check write access to output location
- Verify Python script availability: `[id:tools_dir]/workspace_content_analyzer.py`

### 2. Execution Phase

**Python Script Execution (Primary Method)**:
- Check if `[id:tools_dir]commons/project-onboarding/workspace_content_analyzer.py` exists
- If script exists, execute: `python "[id:tools_dir]commons/project-onboarding/workspace_content_analyzer.py" "{workspace_path}" -o "{output_location}/script-workspace-structure.md"`
- **CRITICAL**: Read and parse the generated script output file `{output_location}/script-workspace-structure.md`
- **Extract structured data from script output**:
  - Repository Overview table: Repository names, types, paths, sizes (MB), last modified dates
  - Workspace Structure Analysis: Total repositories count, total size, repository types breakdown
  - Common Directory Patterns table: Directory names, frequency counts, purposes
  - Dependency Analysis section: Repository dependencies with package lists (top 10 per repo)
  - Recommendations section: Organization, dependency management, documentation suggestions
- **Parse specific data points**:
  - Total number of repositories found and their technology types (Node.js, Python, Java, etc.)
  - Repository size distribution and workspace total size in MB
  - Common directory patterns and their frequencies across repositories
  - Inter-repository dependencies and shared packages
  - Repository classification (monorepo vs multi-repo patterns)
- **Data Integration**: Combine parsed script metrics with additional manual analysis insights
- If script execution fails, fall back to manual analysis

**Manual Analysis (Fallback Method)**:
- Scan workspace directory structure recursively
- Identify Git repositories by looking for `.git` directories
- Analyze repository types based on configuration files (package.json, pom.xml, requirements.txt, etc.)
- Count files and calculate directory sizes
- Map inter-repository dependencies through configuration analysis
- Document workspace organization patterns

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for workspace analysis execution
- Execute Python script as primary method for comprehensive analysis
- If script succeeds, parse and integrate all structured data from output file
- If script fails, perform manual analysis using fallback methods
- Combine all data sources for comprehensive workspace assessment
- Generate final analysis report with repository structure, dependencies, and recommendations

### 3. Validation Phase
You WILL validate results:
- **CRITICAL**: Confirm the script output file `{output_location}/script-workspace-structure.md` was successfully read and parsed
- **Verify data extraction**: Ensure all tables and sections from script output are included in final analysis
- Confirm all repositories identified correctly
- Verify dependency mapping completeness
- Validate output file structure and content
- **Cross-reference**: Ensure script data matches manual analysis where applicable

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-workspace-content-structure.md` in `[id:ads_dir]product/context/{repository-name}/`
- **MANDATORY Data Integration Requirements**: Parse script output file and incorporate ALL structured data:
  - **Repository Overview**: Include complete table with repository names, types, paths, sizes (MB), and last modified dates
  - **Workspace Structure Analysis**: Include total repositories count, total size in MB, and repository types breakdown
  - **Common Directory Patterns**: Copy complete table showing directory names, frequency counts, and purposes
  - **Dependency Analysis**: Include repository dependencies with package lists (showing top 10 dependencies per repository)
  - **Script Recommendations**: Incorporate organization, dependency management, and documentation suggestions from script output
  - **Repository Classification**: Extract monorepo vs multi-repo patterns and technology stack distribution
- Supporting files: Dependency graph visualization (if applicable)
- Documentation: Structured markdown combining script data with manual analysis insights

## User Communication

### Progress Updates
- Confirmation when workspace scanning completes
- Repository discovery progress and count
- Dependency analysis completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Total repositories discovered
- Monorepo vs multi-repo classification results
- Inter-repository dependencies mapped
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-workspace-content-structure.md`

### Next Steps
You WILL clearly define:
- Workspace structure analysis completed for Phase 1 Task #1
- Repository classification ready for Phase 1 Task #2
- Files provided: workspace structure data for subsequent analysis tasks
- Dependencies: None (foundational analysis)

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Exclude legacy, temp, and backup directories from analysis unless explicitly requested
- Rule 2: Focus on active development repositories with recent commits
- Rule 3: Document repository relationships with clear dependency direction
- Rule 4: Classify monorepo status based on shared dependencies and build systems

## Success Criteria
You WILL consider the task complete when:
- [ ] All repositories in workspace identified and catalogued
- [ ] Repository relationships documented with clear dependency mappings
- [ ] Monorepo vs multi-repo classification completed
- [ ] Output file generated in correct location with structured content
- [ ] Inter-repository dependencies mapped and validated

## Required Actions
1. Validate workspace path and access permissions
2. Execute directory scanning and repository discovery
3. Generate dependency analysis and relationship mapping
4. Create structured output file with findings
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Workspace Path Not Found**: Request valid workspace path from user
- **Permission Denied**: Provide clear error message and permission requirements
- **Python Script Missing**: Continue with manual analysis, note missing automation
- **Large Workspace Timeout**: Implement chunked analysis or request scope reduction
- **Dependency Analysis Failure**: Document manual dependency review requirements

⚠️ **Critical Requirements**
- MANDATORY: Focus on active repositories with recent development activity
- NEVER include temporary, backup, or legacy directories in primary analysis
- ALWAYS document assumptions about repository relationships
- ALWAYS provide clear dependency direction (A depends on B, not bidirectional)
- ALWAYS validate repository discovery completeness before proceeding
