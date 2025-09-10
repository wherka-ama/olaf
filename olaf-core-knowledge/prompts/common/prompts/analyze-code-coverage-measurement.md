---
name: analyze-code-coverage-measurement
description: Analyze code coverage calculation methods, metrics, thresholds, and identify uncovered critical paths
tags: [coverage, testing, metrics, analysis]
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
- **unit_testing_file**: string - Path to unit testing framework analysis output (REQUIRED)
- **integration_testing_file**: string - Path to integration testing analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **coverage_threshold**: integer - Minimum coverage threshold percentage (OPTIONAL, default: 80)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify unit testing (Task #6) and integration testing (Task #7) were completed
2. You WILL validate expected outcomes from previous steps:
   - `analyze-unit-testing-frameworks.md` exists with unit testing data
   - `analyze-integration-testing-setup.md` exists with integration testing data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm unit_testing_file and integration_testing_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Coverage Tool Detection**:
- Identify coverage measurement tools and configurations
- Analyze coverage report formats and collection methods

**Coverage Metrics Analysis**:
- Calculate line coverage, branch coverage, and function coverage
- Identify coverage gaps and uncovered critical paths
- Analyze coverage trends and historical data where available

**Threshold Analysis**:
- Compare current coverage against established thresholds
- Identify repositories below coverage standards
- Document coverage improvement opportunities

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for coverage analysis execution
- Analyze coverage calculation methods, metrics, thresholds
- Identify uncovered critical paths and improvement opportunities

### 3. Validation Phase
You WILL validate results:
- Confirm coverage metrics are accurately calculated
- Verify critical path identification is complete
- Validate threshold analysis provides actionable insights

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-code-coverage-measurement.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Coverage reports and critical path analysis
- Documentation: Structured markdown with coverage analysis and improvement recommendations

## User Communication

### Progress Updates
- Confirmation when coverage tool detection completes
- Coverage metrics analysis progress
- Critical path identification completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Coverage metrics calculated across all repositories
- Critical paths identified and prioritized
- Coverage improvement recommendations provided
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-code-coverage-measurement.md`

### Next Steps
You WILL clearly define:
- Code coverage analysis completed for Phase 3 Task #8
- Performance testing analysis ready for Phase 3 Task #9
- Files provided: coverage data for quality assessment
- Dependencies: Tasks #6 (unit testing) and #7 (integration testing) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on meaningful coverage metrics that reflect actual test quality
- Rule 2: Identify critical business logic paths that lack adequate coverage
- Rule 3: Provide specific recommendations for coverage improvement
- Rule 4: Assess coverage tool effectiveness and reporting quality

## Success Criteria
You WILL consider the task complete when:
- [ ] Coverage calculation methods analyzed and documented
- [ ] Coverage metrics calculated with threshold comparison
- [ ] Uncovered critical paths identified and prioritized
- [ ] Coverage improvement recommendations provided
- [ ] Output file generated with comprehensive coverage analysis

## Required Actions
1. Validate unit testing and integration testing input files
2. Execute coverage tool detection and metrics analysis
3. Generate critical path identification and threshold analysis
4. Create structured output file with coverage analysis results
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Coverage Tools Found**: Document absence and recommend coverage tool adoption
- **Python Script Missing**: Continue with manual coverage analysis, note missing automation
- **Coverage Data Access Issues**: Document limitations and provide alternative analysis approaches

⚠️ **Critical Requirements**
- MANDATORY: Focus on meaningful coverage that reflects actual test effectiveness
- NEVER rely solely on coverage percentages without analyzing test quality
- ALWAYS identify critical business logic paths requiring improved coverage
- ALWAYS provide specific, actionable recommendations for coverage improvement
