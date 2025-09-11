---
name: analyze-performance-testing-strategy
description: Analyze performance testing frameworks, load testing configurations, and benchmark analysis
tags: [performance, testing, load, benchmarks]
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
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

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

**Performance Testing Framework Detection**:
- Identify performance testing tools (JMeter, k6, Artillery, Gatling, etc.)
- Analyze load testing configurations and scenarios

**Benchmark Analysis**:
- Document existing performance benchmarks and SLAs
- Analyze performance metrics collection and monitoring
- Identify performance bottlenecks and optimization opportunities

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for performance testing analysis
- Analyze performance testing frameworks, load testing configurations, benchmarks
- Document performance requirements and testing strategies

### 3. Validation Phase
You WILL validate results:
- Confirm performance testing framework analysis is complete
- Verify benchmark analysis provides actionable insights

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-performance-testing-strategy.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Performance testing framework matrix and benchmark analysis
- Documentation: Structured markdown with performance testing strategy analysis

## User Communication

### Progress Updates
- Confirmation when performance testing framework detection completes
- Benchmark analysis progress
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Performance testing frameworks identified and analyzed
- Benchmarks and SLAs documented
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-performance-testing-strategy.md`

### Next Steps
You WILL clearly define:
- Performance testing analysis completed for Phase 3 Task #9
- Local build process analysis ready for Phase 4 Task #10
- Files provided: performance testing data for build pipeline analysis
- Dependencies: Tasks #5 (technology stack) and #2 (application types) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual performance testing implementations and configurations
- Rule 2: Document performance requirements and SLA targets where available
- Rule 3: Analyze performance testing coverage across critical user journeys
- Rule 4: Assess performance testing automation and CI/CD integration

## Success Criteria
You WILL consider the task complete when:
- [ ] Performance testing frameworks identified and analyzed
- [ ] Load testing configurations documented
- [ ] Performance benchmarks and SLAs analyzed
- [ ] Output file generated with comprehensive performance testing strategy

## Required Actions
1. Validate technology stack and application types input files
2. Execute performance testing framework detection and analysis
3. Generate benchmark analysis and performance requirements documentation
4. Create structured output file with performance testing strategy
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Performance Tests Found**: Document absence and recommend performance testing adoption
- **Python Script Missing**: Continue with manual analysis, note missing automation
- **Complex Performance Requirements**: Document complexity and provide testing guidance

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual performance testing implementations and measurable results
- NEVER assume performance capabilities without documented benchmarks or testing
- ALWAYS document performance requirements and SLA targets where available
- ALWAYS assess performance testing coverage for critical application workflows
