---
name: analyze-cicd-pipeline-setup
description: Analyze CI/CD platform identification, pipeline configuration, and automation processes
tags: [cicd, pipeline, automation, deployment]
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
- **build_process_file**: string - Path to local build process analysis output (REQUIRED)
- **testing_frameworks_file**: string - Path to testing frameworks analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify build process (Task #10) and testing frameworks (Tasks #6-9) were completed
2. You WILL validate expected outcomes from previous steps:
   - `document-local-build-process.md` exists with build data
   - Testing framework analysis files exist

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm build_process_file and testing_frameworks_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**CI/CD Platform Detection**:
- Identify CI/CD platforms (GitHub Actions, GitLab CI, Jenkins, Azure DevOps, etc.)
- Analyze pipeline configuration files and workflows

**Pipeline Configuration Analysis**:
- Document build stages, test execution, and deployment steps
- Analyze pipeline triggers, conditions, and scheduling
- Identify pipeline optimization opportunities

**Automation Process Assessment**:
- Evaluate automation coverage across development lifecycle
- Analyze integration with testing frameworks and quality gates
- Document deployment automation and rollback procedures

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for CI/CD analysis execution
- Analyze CI/CD platform identification, pipeline configuration, automation processes
- Document pipeline efficiency and improvement opportunities

### 3. Validation Phase
You WILL validate results:
- Confirm CI/CD pipeline analysis is comprehensive
- Verify automation process assessment covers all critical workflows
- Validate optimization recommendations are actionable

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-cicd-pipeline-setup.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Pipeline configuration matrix and automation assessment
- Documentation: Structured markdown with CI/CD analysis and optimization recommendations

## User Communication

### Progress Updates
- Confirmation when CI/CD platform detection completes
- Pipeline configuration analysis progress
- Automation process assessment completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- CI/CD platforms identified and analyzed
- Pipeline configurations documented with optimization opportunities
- Automation processes assessed across development lifecycle
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-cicd-pipeline-setup.md`

### Next Steps
You WILL clearly define:
- CI/CD pipeline analysis completed for Phase 4 Task #11
- Deployment strategy analysis ready for Phase 4 Task #12
- Files provided: pipeline data for deployment analysis
- Dependencies: Task #10 (build process) and Tasks #6-9 (testing frameworks) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual pipeline implementations and configurations in use
- Rule 2: Document complete pipeline workflows from commit to deployment
- Rule 3: Analyze pipeline performance and identify bottlenecks
- Rule 4: Assess automation coverage and manual intervention points

## Success Criteria
You WILL consider the task complete when:
- [ ] CI/CD platforms identified with configuration analysis
- [ ] Pipeline workflows documented from commit to deployment
- [ ] Automation processes assessed with coverage analysis
- [ ] Pipeline optimization opportunities identified and prioritized
- [ ] Output file generated with comprehensive CI/CD analysis

## Required Actions
1. Validate build process and testing frameworks input files
2. Execute CI/CD platform detection and pipeline analysis
3. Generate automation process assessment and optimization recommendations
4. Create structured output file with CI/CD pipeline analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No CI/CD Pipeline Found**: Document absence and recommend CI/CD adoption
- **Python Script Missing**: Continue with manual pipeline analysis, note missing automation
- **Complex Pipeline Configurations**: Document complexity and provide optimization guidance

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual pipeline implementations and their effectiveness
- NEVER assume CI/CD capabilities without analyzing actual pipeline configurations
- ALWAYS document complete workflows including manual intervention points
- ALWAYS provide specific optimization recommendations with measurable improvements
