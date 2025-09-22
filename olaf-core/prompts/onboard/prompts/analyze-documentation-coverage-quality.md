---
name: analyze-documentation-coverage-quality
description: Analyze documentation inventory, coverage assessment, and quality evaluation
tags: [documentation, coverage, quality, analysis]
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
- **application_types_file**: string - Path to application classification output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify workspace structure (Task #1) and application types (Task #2) were completed
2. You WILL validate expected outcomes from previous steps:
   - `analyze-workspace-content-structure.md` exists with workspace data
   - `classify-repo-application-types.md` exists with application data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm workspace_structure_file and application_types_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Documentation Inventory**:
- Identify all documentation files (README, API docs, user guides, etc.)
- Catalog documentation types and formats

**Coverage Assessment**:
- Analyze documentation coverage across repositories and features
- Identify documentation gaps and missing areas
- Assess documentation completeness for user onboarding

**Quality Evaluation**:
- Evaluate documentation freshness and accuracy
- Analyze link validity and content accessibility
- Assess documentation structure and organization

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for documentation analysis execution
- Analyze documentation inventory, coverage assessment, quality evaluation
- Document improvement opportunities and maintenance requirements

### 3. Validation Phase
You WILL validate results:
- Confirm documentation inventory is comprehensive
- Verify coverage assessment identifies all gaps
- Validate quality evaluation provides actionable improvements

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-documentation-coverage-quality.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Documentation coverage matrix and quality assessment report
- Documentation: Structured markdown with documentation analysis and improvement recommendations

## User Communication

### Progress Updates
- Confirmation when documentation inventory completes
- Coverage assessment progress
- Quality evaluation completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Documentation inventory completed with type categorization
- Coverage gaps identified and prioritized
- Quality assessment completed with improvement recommendations
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-documentation-coverage-quality.md`

### Next Steps
You WILL clearly define:
- Documentation analysis completed for Phase 8 Task #17
- Specification-driven development analysis ready for Phase 8 Task #25
- Files provided: documentation data for specification analysis
- Dependencies: Tasks #1 (workspace structure) and #2 (application types) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Assess documentation from both developer and end-user perspectives
- Rule 2: Prioritize documentation gaps by impact on user experience
- Rule 3: Evaluate documentation maintenance and update processes
- Rule 4: Provide specific recommendations for documentation improvement

## Success Criteria
You WILL consider the task complete when:
- [ ] Complete documentation inventory with type categorization
- [ ] Coverage assessment identifying gaps and priorities
- [ ] Quality evaluation with freshness and accuracy analysis
- [ ] Documentation improvement roadmap provided
- [ ] Output file generated with comprehensive documentation analysis

## Required Actions
1. Validate workspace structure and application types input files
2. Execute documentation inventory and coverage assessment
3. Generate quality evaluation and improvement recommendations
4. Create structured output file with documentation analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Documentation Found**: Document absence and recommend documentation creation
- **Python Script Missing**: Continue with manual documentation analysis, note missing automation
- **Large Documentation Sets**: Implement sampling approach for quality assessment

⚠️ **Critical Requirements**
- MANDATORY: Assess documentation from both technical and user experience perspectives
- NEVER ignore documentation gaps that impact user onboarding or developer productivity
- ALWAYS evaluate documentation freshness and accuracy against current implementation
- ALWAYS provide prioritized recommendations for documentation improvement and maintenance
