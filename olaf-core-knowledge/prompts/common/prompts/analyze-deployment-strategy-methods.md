---
name: analyze-deployment-strategy-methods
description: Analyze deployment technologies, environments, container orchestration, and deployment patterns
tags: [deployment, strategy, containers, orchestration]
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
- **cicd_pipeline_file**: string - Path to CI/CD pipeline analysis output (REQUIRED)
- **technology_stack_file**: string - Path to technology stack analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify CI/CD pipeline (Task #11) and technology stack (Task #5) were completed
2. You WILL validate expected outcomes from previous steps:
   - `analyze-cicd-pipeline-setup.md` exists with pipeline data
   - `identify-repo-technology-stack.md` exists with technology inventory

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm cicd_pipeline_file and technology_stack_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Deployment Technology Detection**:
- Identify deployment technologies (Docker, Kubernetes, Helm, Terraform, etc.)
- Analyze containerization and orchestration configurations

**Environment Analysis**:
- Document deployment environments (dev, staging, production)
- Analyze environment-specific configurations and secrets management
- Identify environment promotion and rollback strategies

**Deployment Pattern Assessment**:
- Analyze deployment patterns (blue-green, canary, rolling updates)
- Document deployment automation and manual processes
- Assess deployment monitoring and health checks

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for deployment strategy analysis
- Analyze deployment technologies, environments, container orchestration, deployment patterns
- Document deployment efficiency and risk mitigation strategies

### 3. Validation Phase
You WILL validate results:
- Confirm deployment strategy analysis is comprehensive
- Verify environment configuration documentation is complete
- Validate deployment pattern assessment covers risk mitigation

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-deployment-strategy-methods.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Deployment architecture diagram and environment matrix
- Documentation: Structured markdown with deployment strategy analysis

## User Communication

### Progress Updates
- Confirmation when deployment technology detection completes
- Environment analysis progress
- Deployment pattern assessment completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Deployment technologies identified and analyzed
- Environment configurations documented
- Deployment patterns assessed with risk analysis
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-deployment-strategy-methods.md`

### Next Steps
You WILL clearly define:
- Deployment strategy analysis completed for Phase 4 Task #12
- Infrastructure as Code analysis ready for Phase 4 Task #24
- Files provided: deployment data for infrastructure analysis
- Dependencies: Tasks #11 (CI/CD pipeline) and #5 (technology stack) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual deployment implementations and configurations
- Rule 2: Document complete deployment workflows including rollback procedures
- Rule 3: Analyze deployment risk mitigation and monitoring strategies
- Rule 4: Assess deployment automation coverage and manual intervention points

## Success Criteria
You WILL consider the task complete when:
- [ ] Deployment technologies identified with configuration analysis
- [ ] Environment configurations documented with promotion strategies
- [ ] Deployment patterns analyzed with risk assessment
- [ ] Deployment monitoring and health check procedures documented
- [ ] Output file generated with comprehensive deployment strategy analysis

## Required Actions
1. Validate CI/CD pipeline and technology stack input files
2. Execute deployment technology detection and environment analysis
3. Generate deployment pattern assessment and risk analysis
4. Create structured output file with deployment strategy analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Deployment Strategy Found**: Document manual deployment processes or recommend automation
- **Python Script Missing**: Continue with manual deployment analysis, note missing automation
- **Complex Deployment Architectures**: Document complexity and provide optimization guidance

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual deployment implementations and their reliability
- NEVER assume deployment capabilities without analyzing actual configurations
- ALWAYS document rollback procedures and disaster recovery strategies
- ALWAYS assess deployment risk mitigation and monitoring effectiveness
