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
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

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
- Read and parse the generated script output file
- Extract key metrics: repository structure, dependency mappings, monorepo classification
- Parse workspace organization, file counts, and relationship data from script output
- Integrate script data into comprehensive workspace analysis combining both script results and manual insights
- If script execution fails, fall back to manual analysis

**Manual Analysis (Fallback Method)**:
- Execute command: `Get-ChildItem -Path "{workspace_path}" -Recurse -Directory | Select-Object Name, FullName, @{Name="ItemCount";Expression={(Get-ChildItem $_.FullName -Recurse).Count}}`
- Validate directory structure discovery success

**Repository Identification**:
- Scan for `.git` directories to identify repositories
- Analyze repository structure and relationships
- Identify monorepo vs multi-repo patterns

**Dependency Mapping**:
- Analyze configuration files (package.json, requirements.txt, pom.xml, etc.)
- Map inter-repository dependencies
- Generate dependency graph

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for analysis execution
- Execute Python script and parse its output data
- Read script-generated metrics: workspace structure tables, repository classifications, dependency mappings
- Extract monorepo indicators, file organization patterns, and relationship data from script output
- Combine script data with manual analysis for comprehensive workspace assessment
- Document workspace content and relationships using both data sources
- Generate final workspace analysis report integrating all collected data

### 3. Validation Phase
You WILL validate results:
- Confirm all repositories identified correctly
- Verify dependency mapping completeness
- Validate output file structure and content

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-workspace-content-structure.md` in `[id:ads_dir]product/context/{repository-name}/`
- **Data Integration Requirements**: Parse script output and incorporate:
  - Workspace structure tables with directory organization and file counts
  - Repository classification data (monorepo vs multi-repo indicators)
  - Dependency mapping analysis with inter-repository relationships
  - Technology stack detection and build system identification
  - File organization patterns and development workflow analysis
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
