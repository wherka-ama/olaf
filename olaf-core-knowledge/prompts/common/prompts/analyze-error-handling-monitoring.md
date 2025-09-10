---
name: analyze-error-handling-monitoring
description: Analyze error handling strategies, logging frameworks, and monitoring setup
tags: [error, handling, logging, monitoring]
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

**Error Handling Strategy Analysis**:
- Identify error handling patterns and exception management
- Analyze error recovery and graceful degradation strategies

**Logging Framework Assessment**:
- Document logging frameworks and configurations
- Analyze log levels, formats, and structured logging practices
- Assess log aggregation and centralized logging setup

**Monitoring Setup Evaluation**:
- Identify monitoring tools and alerting systems
- Analyze health checks and observability practices
- Document metrics collection and dashboard setup

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for error handling analysis execution
- Analyze error handling strategies, logging frameworks, monitoring setup
- Document operational excellence and reliability practices

### 3. Validation Phase
You WILL validate results:
- Confirm error handling analysis is comprehensive
- Verify logging framework assessment covers all applications
- Validate monitoring setup evaluation provides operational insights

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-error-handling-monitoring.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Error handling patterns matrix and monitoring setup guide
- Documentation: Structured markdown with error handling and monitoring analysis

## User Communication

### Progress Updates
- Confirmation when error handling strategy analysis completes
- Logging framework assessment progress
- Monitoring setup evaluation completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Error handling strategies identified and analyzed
- Logging frameworks documented with configuration analysis
- Monitoring setup evaluated with operational recommendations
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-error-handling-monitoring.md`

### Next Steps
You WILL clearly define:
- Error handling and monitoring analysis completed for Phase 8 Task #22
- Hotspot analysis ready for Phase 9 Task #18
- Files provided: operational data for risk analysis
- Dependencies: Tasks #5 (technology stack) and #2 (application types) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual error handling implementations and their effectiveness
- Rule 2: Assess logging practices for debugging and operational visibility
- Rule 3: Evaluate monitoring coverage across critical application paths
- Rule 4: Provide recommendations for operational excellence improvements

## Success Criteria
You WILL consider the task complete when:
- [ ] Error handling strategies analyzed with pattern documentation
- [ ] Logging frameworks assessed with configuration analysis
- [ ] Monitoring setup evaluated with coverage assessment
- [ ] Operational excellence recommendations provided
- [ ] Output file generated with comprehensive error handling and monitoring analysis

## Required Actions
1. Validate technology stack and application types input files
2. Execute error handling strategy and logging framework analysis
3. Generate monitoring setup evaluation and operational recommendations
4. Create structured output file with error handling and monitoring analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Error Handling Found**: Document absence and recommend error handling implementation
- **Python Script Missing**: Continue with manual analysis, note missing automation
- **Complex Monitoring Architectures**: Document complexity and provide optimization guidance

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual error handling implementations and their reliability
- NEVER assume error handling quality based on framework presence alone
- ALWAYS assess logging practices for operational visibility and debugging effectiveness
- ALWAYS evaluate monitoring coverage for critical application workflows and failure scenarios
