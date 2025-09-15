---
name: analyze-spec-driven-development
description: Analyze BDD/Gherkin specification analysis and specification as code practices
tags: [specification, bdd, gherkin, testing]
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
- **testing_frameworks_file**: string - Path to testing frameworks analysis output (REQUIRED)
- **documentation_file**: string - Path to documentation analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify testing frameworks (Tasks #6-7) and documentation (Task #17) were completed
2. You WILL validate expected outcomes from previous steps:
   - Testing framework analysis files exist
   - `analyze-documentation-coverage-quality.md` exists with documentation data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm testing_frameworks_file and documentation_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**BDD Framework Detection**:
- Identify BDD frameworks (Cucumber, SpecFlow, Behave, etc.)
- Analyze Gherkin specification files and scenarios

**Specification as Code Analysis**:
- Document specification-driven development practices
- Analyze living documentation and executable specifications
- Assess specification maintenance and synchronization

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for specification analysis execution
- Analyze BDD/Gherkin specification analysis, specification as code practices
- Document specification-driven development maturity and recommendations

### 3. Validation Phase
You WILL validate results:
- Confirm BDD framework analysis is comprehensive
- Verify specification as code assessment covers all practices
- Validate recommendations provide actionable guidance

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-spec-driven-development.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: BDD framework matrix and specification coverage report
- Documentation: Structured markdown with specification analysis and recommendations

## User Communication

### Progress Updates
- Confirmation when BDD framework detection completes
- Specification as code analysis progress
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- BDD frameworks identified and analyzed
- Specification as code practices documented
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-spec-driven-development.md`

### Next Steps
You WILL clearly define:
- Specification-driven development analysis completed for Phase 8 Task #25
- Error handling analysis ready for Phase 8 Task #22
- Files provided: specification data for business domain synthesis
- Dependencies: Tasks #6-7 (testing frameworks) and #17 (documentation) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual BDD implementations and specification usage
- Rule 2: Assess specification maintenance and living documentation practices
- Rule 3: Analyze specification coverage across business scenarios
- Rule 4: Evaluate specification-driven development team adoption

## Success Criteria
You WILL consider the task complete when:
- [ ] BDD frameworks identified with implementation analysis
- [ ] Specification as code practices documented
- [ ] Living documentation assessment completed
- [ ] Specification-driven development maturity evaluated
- [ ] Output file generated with comprehensive specification analysis

## Required Actions
1. Validate testing frameworks and documentation input files
2. Execute BDD framework detection and specification analysis
3. Generate specification as code assessment and recommendations
4. Create structured output file with specification analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No BDD Framework Found**: Document absence and recommend specification-driven development adoption
- **Python Script Missing**: Continue with manual specification analysis, note missing automation
- **Complex Specification Patterns**: Document complexity and provide standardization guidance

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual BDD implementations and their effectiveness
- NEVER assume specification quality based on framework presence alone
- ALWAYS assess specification maintenance and synchronization with implementation
- ALWAYS evaluate specification coverage across critical business scenarios
