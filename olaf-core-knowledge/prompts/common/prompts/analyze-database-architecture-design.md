---
name: analyze-database-architecture-design
description: Analyze database technologies, schema design patterns, and migration strategies
tags: [database, architecture, schema, migrations]
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

**Database Technology Detection**:
- Identify database technologies (PostgreSQL, MySQL, MongoDB, Redis, etc.)
- Analyze database configuration files and connection strings

**Schema Design Analysis**:
- Document database schema patterns and design approaches
- Analyze entity relationships and data modeling patterns
- Identify normalization levels and denormalization strategies

**Migration Strategy Assessment**:
- Document database migration tools and procedures
- Analyze schema versioning and change management
- Assess migration automation and rollback capabilities

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for database architecture analysis
- Analyze database technologies, schema design patterns, migration strategies
- Document data architecture and governance practices

### 3. Validation Phase
You WILL validate results:
- Confirm database technology analysis is comprehensive
- Verify schema design documentation is complete
- Validate migration strategy assessment covers all databases

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-database-architecture-design.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Database schema diagrams and migration strategy matrix
- Documentation: Structured markdown with database architecture analysis

## User Communication

### Progress Updates
- Confirmation when database technology detection completes
- Schema design analysis progress
- Migration strategy assessment completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Database technologies identified and analyzed
- Schema design patterns documented
- Migration strategies assessed with automation analysis
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-database-architecture-design.md`

### Next Steps
You WILL clearly define:
- Database architecture analysis completed for Phase 5 Task #13
- Authentication and authorization analysis ready for Phase 6 Task #14
- Files provided: database architecture data for security analysis
- Dependencies: Tasks #5 (technology stack) and #2 (application types) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual database implementations and configurations
- Rule 2: Document schema design rationale and trade-offs
- Rule 3: Analyze migration strategy effectiveness and risk mitigation
- Rule 4: Assess database performance and scalability patterns

## Success Criteria
You WILL consider the task complete when:
- [ ] Database technologies identified with configuration analysis
- [ ] Schema design patterns documented with rationale
- [ ] Migration strategies analyzed with automation assessment
- [ ] Database performance and scalability patterns evaluated
- [ ] Output file generated with comprehensive database architecture analysis

## Required Actions
1. Validate technology stack and application types input files
2. Execute database technology detection and schema analysis
3. Generate migration strategy and performance assessment
4. Create structured output file with database architecture analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Database Found**: Document data storage approaches or recommend database adoption
- **Python Script Missing**: Continue with manual database analysis, note missing automation
- **Complex Database Architectures**: Document complexity and provide optimization guidance

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual database implementations and their effectiveness
- NEVER assume database capabilities without analyzing actual configurations
- ALWAYS document schema design rationale and performance implications
- ALWAYS assess migration strategy reliability and rollback procedures
