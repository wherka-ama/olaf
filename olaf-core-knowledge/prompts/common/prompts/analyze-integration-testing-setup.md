---
name: analyze-integration-testing-setup
description: Analyze integration testing frameworks, execution procedures, and environment configuration
tags: [integration, testing, frameworks, environment]
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
- **application_types_file**: string - Path to application classification output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify technology stack (Task #5) and application types (Task #2) were completed
2. You WILL validate expected outcomes from previous steps:
   - `identify-repo-technology-stack.md` exists with technology inventory
   - `classify-repo-application-types.md` exists with application data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm technology_stack_file and application_types_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Integration Testing Framework Detection**:
- Identify integration testing frameworks and tools
- Analyze test configuration files and setup procedures

**Environment Configuration Analysis**:
- Document test environment setup requirements
- Analyze containerization and orchestration for testing
- Identify external service dependencies and mocking approaches

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for integration testing analysis
- Analyze integration testing frameworks, execution procedures, mocking approaches
- Document environment configuration and dependency management

### 3. Validation Phase
You WILL validate results:
- Confirm integration testing setup analysis is complete
- Verify environment configuration documentation is comprehensive

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-integration-testing-setup.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Integration testing framework matrix and environment setup guide
- Documentation: Structured markdown with integration testing analysis

## User Communication

### Progress Updates
- Confirmation when integration testing framework detection completes
- Environment configuration analysis progress
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Integration testing frameworks identified and analyzed
- Environment configuration documented
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-integration-testing-setup.md`

### Next Steps
You WILL clearly define:
- Integration testing analysis completed for Phase 3 Task #7
- Code coverage analysis ready for Phase 3 Task #8
- Files provided: integration testing data for coverage analysis
- Dependencies: Tasks #5 (technology stack) and #2 (application types) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual integration testing implementations, not just available tools
- Rule 2: Document complete environment setup procedures including dependencies
- Rule 3: Analyze integration testing complexity and maintenance requirements
- Rule 4: Assess integration testing coverage across service boundaries

## Success Criteria
You WILL consider the task complete when:
- [ ] Integration testing frameworks identified and analyzed
- [ ] Environment configuration documented with setup procedures
- [ ] Integration testing execution procedures validated
- [ ] Output file generated with comprehensive integration testing analysis

## Required Actions
1. Validate technology stack and application types input files
2. Execute integration testing framework detection and analysis
3. Generate environment configuration and setup documentation
4. Create structured output file with integration testing analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Integration Tests Found**: Document absence and recommend integration testing adoption
- **Python Script Missing**: Continue with manual analysis, note missing automation
- **Complex Integration Setup**: Document complexity and provide setup guidance

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual integration testing implementations in use
- NEVER assume integration testing practices based on framework presence alone
- ALWAYS document complete environment setup and dependency requirements
- ALWAYS validate integration testing procedures are executable and maintainable
