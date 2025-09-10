---
name: identify-repo-technology-stack
description: Document frameworks and technologies used across repositories with application layer categorization
tags: [technology, stack, frameworks, analysis]
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
- **application_types_file**: string - Path to application classification output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify language analysis (Task #3) and application classification (Task #2) were completed
2. You WILL validate expected outcomes from previous steps:
   - `analyze-repo-language-distribution.md` exists with language data
   - `classify-repo-application-types.md` exists with application classifications
   - Repository structure and relationships are documented

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm language_analysis_file and application_types_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Configuration File Analysis**:
- Analyze package.json, requirements.txt, pom.xml, Gemfile, go.mod, Cargo.toml
- Parse configuration files for framework and dependency information

**Framework Detection**:
- Identify frameworks by language and application type:
  - Frontend: React, Angular, Vue, Svelte, etc.
  - Backend: Express, Django, Spring, Rails, etc.
  - Database: PostgreSQL, MongoDB, Redis, etc.
  - Testing: Jest, PyTest, JUnit, etc.
  - Build: Webpack, Gradle, Maven, etc.

**Technology Layer Categorization**:
- Categorize technologies by application layer:
  - Frontend (UI frameworks, styling, state management)
  - Middleware (API gateways, message queues, caching)
  - Backend (web frameworks, ORM, business logic)
  - Database (RDBMS, NoSQL, caching, search)
  - Infrastructure (containers, orchestration, monitoring)

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for technology identification
- Document frameworks and technologies used (framework-agnostic approach)
- Categorize by application layer with version information
- Map technology choices to application types and languages

### 3. Validation Phase
You WILL validate results:
- Confirm all configuration files analyzed
- Verify framework detection accuracy
- Validate technology categorization completeness

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `identify-repo-technology-stack.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Technology stack matrix and layer architecture diagram
- Documentation: Structured markdown with technology inventory and rationale

## User Communication

### Progress Updates
- Confirmation when configuration file analysis completes
- Framework detection progress by repository
- Technology categorization completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Total technologies and frameworks identified
- Technology distribution by application layer
- Framework version analysis and compatibility assessment
- Output file location: `[id:ads_dir]product/context/{repository-name}/identify-repo-technology-stack.md`

### Next Steps
You WILL clearly define:
- Technology stack analysis completed for Phase 2 Task #5
- Testing framework analysis ready for Phase 3 Task #6
- Files provided: technology inventory for testing and build analysis
- Dependencies: Tasks #2 (application types) and #3 (languages) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Use framework-agnostic detection methods that work across all technology stacks
- Rule 2: Document version information where available for compatibility analysis
- Rule 3: Categorize technologies by actual usage, not just presence in configuration
- Rule 4: Identify technology conflicts or compatibility issues between repositories

## Success Criteria
You WILL consider the task complete when:
- [ ] All frameworks and technologies identified across repositories
- [ ] Technology stack categorized by application layer
- [ ] Version information documented for major frameworks
- [ ] Technology compatibility analysis completed
- [ ] Output file generated with comprehensive technology inventory

## Required Actions
1. Validate language analysis and application classification input files
2. Execute configuration file analysis and framework detection
3. Generate technology categorization by application layer
4. Create structured output file with technology stack inventory
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **Configuration File Parse Errors**: Document unparseable files and continue with manual analysis
- **Python Script Missing**: Continue with manual configuration analysis, note missing automation
- **Unknown Framework Detection**: Document as custom/unknown with configuration details
- **Version Conflicts**: Document compatibility issues and potential resolution approaches

⚠️ **Critical Requirements**
- MANDATORY: Use framework-agnostic detection that works across all programming languages
- NEVER assume technology usage based on file presence alone - verify actual usage
- ALWAYS document version information for major frameworks and dependencies
- ALWAYS categorize technologies by their actual role in the application architecture
- ALWAYS identify potential compatibility issues between different technology choices
