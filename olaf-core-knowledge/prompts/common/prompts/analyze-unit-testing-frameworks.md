---
name: analyze-unit-testing-frameworks
description: Analyze unit testing frameworks, execution commands, and mocking strategies across repositories
tags: [testing, unit, frameworks, mocking]
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
- **language_analysis_file**: string - Path to language distribution analysis output (REQUIRED)
- **technology_stack_file**: string - Path to technology stack analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify language analysis (Task #3) and technology stack (Task #5) were completed
2. You WILL validate expected outcomes from previous steps:
   - `analyze-repo-language-distribution.md` exists with language data
   - `identify-repo-technology-stack.md` exists with technology inventory
   - Framework and dependency information is available

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm language_analysis_file and technology_stack_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Test Framework Detection**:
- Identify testing frameworks by language:
  - JavaScript: Jest, Mocha, Jasmine, Vitest
  - Python: pytest, unittest, nose2
  - Java: JUnit, TestNG, Mockito
  - C#: NUnit, xUnit, MSTest
  - Go: testing package, Testify
  - Rust: built-in test framework

**Execution Command Analysis**:
- Analyze package.json scripts, Makefile, build configurations
- Document test execution commands and parameters
- Identify test runner configurations and options

**Mocking Strategy Assessment**:
- Identify mocking libraries and frameworks
- Analyze mocking patterns and strategies used
- Document test isolation and dependency injection approaches

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for testing framework analysis
- For each repository identify unit testing framework and version
- Document execution commands and configuration
- Analyze mocking strategies and test isolation patterns

### 3. Validation Phase
You WILL validate results:
- Confirm all testing frameworks identified correctly
- Verify execution commands are accurate and complete
- Validate mocking strategy analysis is comprehensive

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-unit-testing-frameworks.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Testing framework matrix and execution command reference
- Documentation: Structured markdown with framework analysis and best practices

## User Communication

### Progress Updates
- Confirmation when test framework detection completes
- Execution command analysis progress by repository
- Mocking strategy assessment completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Total testing frameworks identified across repositories
- Execution command documentation completed
- Mocking strategies and patterns analyzed
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-unit-testing-frameworks.md`

### Next Steps
You WILL clearly define:
- Unit testing framework analysis completed for Phase 3 Task #6
- Integration testing analysis ready for Phase 3 Task #7
- Files provided: testing framework data for coverage analysis
- Dependencies: Tasks #3 (languages) and #5 (technology stack) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Identify actual testing frameworks in use, not just available dependencies
- Rule 2: Document complete execution commands including environment setup
- Rule 3: Analyze mocking strategies for external dependencies and services
- Rule 4: Assess test isolation and parallel execution capabilities

## Success Criteria
You WILL consider the task complete when:
- [ ] All unit testing frameworks identified with versions
- [ ] Test execution commands documented and validated
- [ ] Mocking strategies analyzed across all repositories
- [ ] Test isolation and dependency patterns documented
- [ ] Output file generated with comprehensive testing framework analysis

## Required Actions
1. Validate language analysis and technology stack input files
2. Execute test framework detection and analysis
3. Generate execution command and mocking strategy documentation
4. Create structured output file with testing framework inventory
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Testing Framework Found**: Document absence and recommend framework adoption
- **Python Script Missing**: Continue with manual framework analysis, note missing automation
- **Complex Test Configurations**: Document configuration complexity and maintenance requirements
- **Inconsistent Testing Approaches**: Document variations and recommend standardization

⚠️ **Critical Requirements**
- MANDATORY: Focus on frameworks actually used for testing, not just installed dependencies
- NEVER assume testing practices based on framework presence alone
- ALWAYS document complete test execution procedures including setup requirements
- ALWAYS analyze mocking strategies for maintainability and test reliability
- ALWAYS validate that documented execution commands actually work
