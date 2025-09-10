---
name: analyze-licensing-legal-compliance
description: Analyze software license compliance, third-party obligations, and open source compatibility
tags: [licensing, legal, compliance, opensource]
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
- **dependency_analysis_file**: string - Path to dependency analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify dependency analysis (Task #20) was completed
2. You WILL validate expected outcomes from previous step:
   - `analyze-dependency-management-risks.md` exists with dependency data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm dependency_analysis_file exists and is readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**License Discovery and Analysis**:
- Identify all software licenses in use across dependencies
- Analyze license compatibility and conflicts

**Legal Obligation Assessment**:
- Document specific legal obligations for each license type
- Analyze attribution requirements and distribution obligations
- Identify copyleft obligations and commercial restrictions

**Open Source Compatibility Review**:
- Assess open source license compatibility with project goals
- Analyze GPL compatibility and viral license implications
- Document commercial use restrictions and requirements

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for licensing analysis execution
- Analyze software license compliance, third-party obligations, open source compatibility
- Document legal risks and compliance requirements

### 3. Validation Phase
You WILL validate results:
- Confirm license analysis covers all dependencies
- Verify legal obligation documentation is comprehensive
- Validate compatibility assessment provides actionable guidance

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-licensing-legal-compliance.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: License compatibility matrix and obligation checklist
- Documentation: Structured markdown with licensing analysis and compliance guidance

## User Communication

### Progress Updates
- Confirmation when license discovery completes
- Legal obligation assessment progress
- Compatibility review completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Software licenses identified and analyzed
- Legal obligations documented with compliance requirements
- Open source compatibility assessed with recommendations
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-licensing-legal-compliance.md`

### Next Steps
You WILL clearly define:
- Licensing analysis completed for Phase 7 Task #23
- Documentation analysis ready for Phase 8 Task #17
- Files provided: licensing data for compliance documentation
- Dependencies: Task #20 (dependency analysis) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Document all license obligations with specific compliance requirements
- Rule 2: Identify license conflicts and incompatibilities with clear resolution guidance
- Rule 3: Assess commercial use implications for all identified licenses
- Rule 4: Provide actionable compliance checklist for legal obligations

## Success Criteria
You WILL consider the task complete when:
- [ ] All software licenses identified and categorized
- [ ] Legal obligations documented with specific compliance requirements
- [ ] License compatibility assessed with conflict resolution guidance
- [ ] Commercial use implications analyzed
- [ ] Output file generated with comprehensive licensing compliance analysis

## Required Actions
1. Validate dependency analysis input file
2. Execute license discovery and legal obligation analysis
3. Generate compatibility review and compliance assessment
4. Create structured output file with licensing analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **License Information Unavailable**: Document unknown licenses and recommend legal review
- **Python Script Missing**: Continue with manual licensing analysis, note missing automation
- **Complex License Interactions**: Document complexity and recommend legal consultation

⚠️ **Critical Requirements**
- MANDATORY: Document all license obligations with specific, actionable compliance requirements
- NEVER ignore copyleft or viral license implications for commercial projects
- ALWAYS provide clear guidance for resolving license conflicts and incompatibilities
- ALWAYS recommend legal consultation for complex licensing scenarios
