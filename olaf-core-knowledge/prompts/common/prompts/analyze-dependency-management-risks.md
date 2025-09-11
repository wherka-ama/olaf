---
name: analyze-dependency-management-risks
description: Analyze external dependency inventory, security vulnerabilities, and license compliance
tags: [dependencies, security, vulnerabilities, licenses]
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
- **technology_stack_file**: string - Path to technology stack analysis output (REQUIRED)
- **build_process_file**: string - Path to local build process analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify technology stack (Task #5) and build process (Task #10) were completed
2. You WILL validate expected outcomes from previous steps:
   - `identify-repo-technology-stack.md` exists with technology inventory
   - `document-local-build-process.md` exists with build data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm technology_stack_file and build_process_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Dependency Inventory Analysis**:
- Identify all external dependencies and their versions
- Analyze dependency trees and transitive dependencies

**Security Vulnerability Assessment**:
- Scan dependencies for known security vulnerabilities
- Analyze vulnerability severity and exploitability
- Document security update requirements and remediation paths

**License Compliance Review**:
- Identify dependency licenses and compatibility
- Analyze license obligations and restrictions
- Document license compliance risks and requirements

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for dependency analysis execution
- Analyze external dependency inventory, security vulnerabilities, license compliance
- Document dependency risks and management recommendations

### 3. Validation Phase
You WILL validate results:
- Confirm dependency inventory is comprehensive
- Verify security vulnerability assessment covers all dependencies
- Validate license compliance review identifies all obligations

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-dependency-management-risks.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Dependency tree diagrams and vulnerability reports
- Documentation: Structured markdown with dependency analysis and risk assessment

## User Communication

### Progress Updates
- Confirmation when dependency inventory analysis completes
- Security vulnerability assessment progress
- License compliance review completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Dependencies inventoried with version analysis
- Security vulnerabilities identified and prioritized
- License compliance assessed with obligation documentation
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-dependency-management-risks.md`

### Next Steps
You WILL clearly define:
- Dependency analysis completed for Phase 7 Task #20
- Licensing analysis ready for Phase 7 Task #23
- Files provided: dependency data for compliance analysis
- Dependencies: Tasks #5 (technology stack) and #10 (build process) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Include both direct and transitive dependencies in analysis
- Rule 2: Prioritize security vulnerabilities by severity and exploitability
- Rule 3: Document specific license obligations and compliance requirements
- Rule 4: Provide actionable remediation steps for identified risks

## Success Criteria
You WILL consider the task complete when:
- [ ] Complete dependency inventory with version analysis
- [ ] Security vulnerabilities identified and prioritized by risk
- [ ] License compliance assessed with obligation documentation
- [ ] Dependency update recommendations provided
- [ ] Output file generated with comprehensive dependency risk analysis

## Required Actions
1. Validate technology stack and build process input files
2. Execute dependency inventory and security vulnerability analysis
3. Generate license compliance review and risk assessment
4. Create structured output file with dependency analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **Dependency Analysis Tool Missing**: Continue with manual dependency review, note missing automation
- **Python Script Missing**: Continue with manual dependency analysis, note missing automation
- **Complex Dependency Trees**: Document complexity and provide management recommendations

⚠️ **Critical Requirements**
- MANDATORY: Include both direct and transitive dependencies in comprehensive analysis
- NEVER ignore high-severity security vulnerabilities in dependency chain
- ALWAYS document specific license obligations and compliance requirements
- ALWAYS provide prioritized remediation steps for identified security and compliance risks
