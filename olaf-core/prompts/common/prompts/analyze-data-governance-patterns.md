---
name: analyze-data-governance-patterns
description: Analyze data validation patterns, schema constraints, PII handling, and data retention logic
tags: [data, governance, validation, privacy]
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
- **database_architecture_file**: string - Path to database architecture analysis output (REQUIRED)
- **security_patterns_file**: string - Path to security pattern analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify database architecture (Task #13) and security patterns (Task #28) were completed
2. You WILL validate expected outcomes from previous steps:
   - `analyze-database-architecture-design.md` exists with database data
   - `analyze-security-pattern-implementation.md` exists with security data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm database_architecture_file and security_patterns_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Data Validation Pattern Analysis**:
- Identify data validation patterns and constraints
- Analyze input sanitization and data type validation

**Schema Constraint Assessment**:
- Document database schema constraints and validation rules
- Analyze referential integrity and business rule enforcement
- Identify data quality and consistency patterns

**PII Handling Analysis**:
- Identify personally identifiable information handling patterns
- Analyze data anonymization and pseudonymization approaches
- Document privacy compliance and data protection measures

**Data Retention Logic Review**:
- Analyze data retention policies and implementation
- Document data lifecycle management and archival processes
- Assess compliance with data retention regulations

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for data governance analysis execution
- Analyze data validation patterns, schema constraints, PII handling, data retention logic
- Document data governance compliance and improvement recommendations

### 3. Validation Phase
You WILL validate results:
- Confirm data validation analysis covers all data flows
- Verify PII handling assessment identifies all privacy risks
- Validate data retention analysis provides compliance guidance

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-data-governance-patterns.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Data governance matrix and compliance checklist
- Documentation: Structured markdown with data governance analysis and compliance recommendations

## User Communication

### Progress Updates
- Confirmation when data validation pattern analysis completes
- PII handling analysis progress
- Data retention logic review completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Data validation patterns identified and analyzed
- PII handling practices documented with privacy assessment
- Data retention logic reviewed with compliance analysis
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-data-governance-patterns.md`

### Next Steps
You WILL clearly define:
- Data governance analysis completed for Phase 6 Task #26
- All 28 analysis tasks completed - project onboarding workflow ready
- Files provided: Complete data governance assessment for business context
- Dependencies: Tasks #13 (database architecture) and #28 (security patterns) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual data governance implementations in code and database
- Rule 2: Identify PII handling patterns with specific privacy compliance requirements
- Rule 3: Assess data retention logic against regulatory requirements
- Rule 4: Provide specific recommendations for data governance improvements

## Success Criteria
You WILL consider the task complete when:
- [ ] Data validation patterns analyzed with constraint documentation
- [ ] PII handling practices assessed with privacy compliance analysis
- [ ] Data retention logic reviewed with regulatory compliance assessment
- [ ] Data governance improvement recommendations provided
- [ ] Output file generated with comprehensive data governance analysis

## Required Actions
1. Validate database architecture and security patterns input files
2. Execute data validation and PII handling analysis
3. Generate data retention and compliance assessment
4. Create structured output file with data governance analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Data Governance Found**: Document absence and recommend governance implementation
- **Python Script Missing**: Continue with manual data governance analysis, note missing automation
- **Complex Data Flows**: Document complexity and provide governance recommendations

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual data governance implementations and their compliance effectiveness
- NEVER ignore PII handling patterns that may violate privacy regulations
- ALWAYS assess data retention logic against applicable regulatory requirements
- ALWAYS provide specific, actionable recommendations for data governance and privacy compliance
