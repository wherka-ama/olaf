---
name: analyze-infrastructure-code-patterns
description: Analyze IaC tool usage, infrastructure versioning, GitOps patterns, and environment provisioning
tags: [infrastructure, iac, gitops, provisioning]
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
- **deployment_strategy_file**: string - Path to deployment strategy analysis output (REQUIRED)
- **cicd_pipeline_file**: string - Path to CI/CD pipeline analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify deployment strategy (Task #12) and CI/CD pipeline (Task #11) were completed
2. You WILL validate expected outcomes from previous steps:
   - `analyze-deployment-strategy-methods.md` exists with deployment data
   - `analyze-cicd-pipeline-setup.md` exists with pipeline data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm deployment_strategy_file and cicd_pipeline_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**IaC Tool Detection**:
- Identify Infrastructure as Code tools (Terraform, CloudFormation, Pulumi, Ansible, etc.)
- Analyze IaC configuration files and modules

**GitOps Pattern Analysis**:
- Document GitOps implementation patterns and workflows
- Analyze infrastructure versioning and change management
- Identify automated infrastructure provisioning and updates

**Environment Provisioning Assessment**:
- Document environment provisioning procedures and automation
- Analyze infrastructure consistency across environments
- Assess infrastructure monitoring and compliance

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for infrastructure code analysis
- Analyze IaC tool usage, infrastructure versioning, GitOps patterns, environment provisioning
- Document infrastructure automation and governance practices

### 3. Validation Phase
You WILL validate results:
- Confirm IaC tool analysis is comprehensive
- Verify GitOps pattern documentation is complete
- Validate environment provisioning assessment covers all environments

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-infrastructure-code-patterns.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Infrastructure architecture diagram and IaC tool matrix
- Documentation: Structured markdown with infrastructure code analysis

## User Communication

### Progress Updates
- Confirmation when IaC tool detection completes
- GitOps pattern analysis progress
- Environment provisioning assessment completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- IaC tools identified and analyzed
- GitOps patterns documented with workflow analysis
- Environment provisioning procedures assessed
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-infrastructure-code-patterns.md`

### Next Steps
You WILL clearly define:
- Infrastructure as Code analysis completed for Phase 4 Task #24
- Database architecture analysis ready for Phase 5 Task #13
- Files provided: infrastructure data for architecture analysis
- Dependencies: Tasks #12 (deployment strategy) and #11 (CI/CD pipeline) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual IaC implementations and their effectiveness
- Rule 2: Document infrastructure versioning and change management practices
- Rule 3: Analyze GitOps workflow automation and manual intervention points
- Rule 4: Assess infrastructure consistency and compliance across environments

## Success Criteria
You WILL consider the task complete when:
- [ ] IaC tools identified with configuration analysis
- [ ] GitOps patterns documented with workflow assessment
- [ ] Environment provisioning procedures analyzed
- [ ] Infrastructure governance and compliance assessed
- [ ] Output file generated with comprehensive infrastructure code analysis

## Required Actions
1. Validate deployment strategy and CI/CD pipeline input files
2. Execute IaC tool detection and GitOps pattern analysis
3. Generate environment provisioning and governance assessment
4. Create structured output file with infrastructure code analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No IaC Tools Found**: Document manual infrastructure processes or recommend IaC adoption
- **Python Script Missing**: Continue with manual infrastructure analysis, note missing automation
- **Complex Infrastructure Patterns**: Document complexity and provide governance recommendations

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual infrastructure code implementations and their maintainability
- NEVER assume infrastructure capabilities without analyzing actual IaC configurations
- ALWAYS document infrastructure versioning and change management procedures
- ALWAYS assess infrastructure consistency and compliance across all environments
