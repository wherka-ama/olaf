---
name: analyze-security-pattern-implementation
description: Analyze security implementation patterns including input validation, injection prevention, and cryptographic usage
tags: [security, patterns, validation, cryptography]
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
- **auth_analysis_file**: string - Path to authentication analysis output (REQUIRED)
- **technology_stack_file**: string - Path to technology stack analysis output (REQUIRED)
- **api_design_file**: string - Path to API design analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify authentication analysis (Task #14), technology stack (Task #5), and API design (Task #16) were completed
2. You WILL validate expected outcomes from previous steps:
   - `analyze-auth-implementation-patterns.md` exists with authentication data
   - `identify-repo-technology-stack.md` exists with technology inventory
   - `analyze-api-design-documentation.md` exists with API analysis

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm auth_analysis_file, technology_stack_file, and api_design_file exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Input Validation Analysis**:
- Scan for input validation patterns and libraries
- Identify parameter sanitization and validation approaches
- Analyze data type validation and boundary checking

**Injection Prevention Assessment**:
- Identify SQL injection prevention measures (parameterized queries, ORM usage)
- Analyze XSS prevention patterns (output encoding, CSP headers)
- Assess command injection prevention (input sanitization, safe execution)
- Evaluate NoSQL injection prevention measures

**Cryptographic Implementation Review**:
- Identify cryptographic libraries and usage patterns
- Analyze encryption/decryption implementations
- Assess hashing algorithms and salt usage
- Review key management and storage practices

**Secrets Management Analysis**:
- Identify secrets management approaches (environment variables, vaults, config files)
- Analyze credential storage and access patterns
- Assess API key and token management practices

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for security pattern analysis
- Analyze input validation, injection prevention, cryptographic implementations
- Assess secrets management and secure coding practices
- Document security vulnerabilities and improvement recommendations

### 3. Validation Phase
You WILL validate results:
- Confirm all security patterns identified and analyzed
- Verify vulnerability assessment is comprehensive
- Validate improvement recommendations are actionable

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-security-pattern-implementation.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Security vulnerability matrix and remediation roadmap
- Documentation: Structured markdown with security analysis and improvement recommendations

## User Communication

### Progress Updates
- Confirmation when input validation analysis completes
- Injection prevention assessment progress
- Cryptographic implementation review completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Security patterns analyzed across all repositories
- Vulnerabilities identified and categorized by severity
- Cryptographic usage assessment completed
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-security-pattern-implementation.md`

### Next Steps
You WILL clearly define:
- Security pattern analysis completed for Phase 6 Task #28
- Data governance analysis ready for Phase 6 Task #26
- Files provided: security assessment data for compliance analysis
- Dependencies: Tasks #14 (auth), #5 (tech stack), and #16 (API design) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual security implementations in code, not just framework capabilities
- Rule 2: Prioritize vulnerabilities by exploitability and business impact
- Rule 3: Provide specific remediation guidance with code examples where possible
- Rule 4: Assess security patterns against current industry best practices

## Success Criteria
You WILL consider the task complete when:
- [ ] Input validation patterns analyzed across all repositories
- [ ] Injection prevention measures assessed and documented
- [ ] Cryptographic implementations reviewed for security compliance
- [ ] Secrets management practices evaluated and improved
- [ ] Output file generated with comprehensive security analysis and recommendations

## Required Actions
1. Validate authentication, technology stack, and API design input files
2. Execute security pattern analysis across all repositories
3. Generate vulnerability assessment and remediation recommendations
4. Create structured output file with security analysis results
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **Security Tool Access Issues**: Continue with manual code review, note tool limitations
- **Python Script Missing**: Continue with manual security analysis, note missing automation
- **Complex Security Architectures**: Document complexity and provide architectural security recommendations
- **False Positive Security Issues**: Validate findings and document analysis methodology

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual security implementations in source code, not theoretical vulnerabilities
- NEVER ignore high-severity security vulnerabilities or weak cryptographic practices
- ALWAYS provide specific, actionable remediation guidance with implementation examples
- ALWAYS validate security findings against current threat landscape and best practices
- ALWAYS prioritize security improvements by risk level and implementation complexity
