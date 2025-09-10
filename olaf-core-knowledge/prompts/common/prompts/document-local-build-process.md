---
name: document-local-build-process
description: Document local build procedures, dependencies, and setup requirements across repositories
tags: [build, local, dependencies, setup]
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
- **language_analysis_file**: string - Path to language distribution analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify technology stack (Task #5) and language analysis (Task #3) were completed
2. You WILL validate expected outcomes from previous steps:
   - `identify-repo-technology-stack.md` exists with technology inventory
   - `analyze-repo-language-distribution.md` exists with language data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm technology_stack_file and language_analysis_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Build System Detection**:
- Identify build systems (Maven, Gradle, npm, pip, cargo, etc.)
- Analyze build configuration files and scripts

**Dependency Analysis**:
- Document build dependencies and prerequisites
- Analyze dependency resolution and management
- Identify version conflicts and compatibility issues

**Setup Requirements Documentation**:
- Document environment setup procedures
- Analyze build tool installation requirements
- Document configuration and initialization steps

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for build process analysis
- Document local build procedures, dependencies, setup requirements
- Analyze build system configuration and optimization opportunities

### 3. Validation Phase
You WILL validate results:
- Confirm build process documentation is complete and executable
- Verify dependency analysis covers all build requirements
- Validate setup procedures are comprehensive

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `document-local-build-process.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Build dependency matrix and setup guide
- Documentation: Structured markdown with build process documentation

## User Communication

### Progress Updates
- Confirmation when build system detection completes
- Dependency analysis progress
- Setup requirements documentation completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Build systems identified and analyzed across repositories
- Dependencies documented with setup procedures
- Build process optimization opportunities identified
- Output file location: `[id:ads_dir]product/context/{repository-name}/document-local-build-process.md`

### Next Steps
You WILL clearly define:
- Local build process documentation completed for Phase 4 Task #10
- CI/CD pipeline analysis ready for Phase 4 Task #11
- Files provided: build process data for pipeline analysis
- Dependencies: Tasks #5 (technology stack) and #3 (language analysis) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Document complete build procedures that can be executed by new developers
- Rule 2: Identify all build dependencies including system requirements
- Rule 3: Provide troubleshooting guidance for common build issues
- Rule 4: Analyze build performance and optimization opportunities

## Success Criteria
You WILL consider the task complete when:
- [ ] Build systems identified and analyzed across all repositories
- [ ] Build dependencies documented with version requirements
- [ ] Setup procedures validated and executable
- [ ] Build optimization opportunities identified
- [ ] Output file generated with comprehensive build process documentation

## Required Actions
1. Validate technology stack and language analysis input files
2. Execute build system detection and dependency analysis
3. Generate setup requirements and procedure documentation
4. Create structured output file with build process analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Build System Found**: Document manual build procedures or recommend build system adoption
- **Python Script Missing**: Continue with manual build analysis, note missing automation
- **Complex Build Dependencies**: Document complexity and provide dependency management guidance

⚠️ **Critical Requirements**
- MANDATORY: Document executable build procedures that work for new developers
- NEVER assume build dependencies are available without explicit documentation
- ALWAYS validate build procedures can be executed from clean environment
- ALWAYS document troubleshooting steps for common build failures
