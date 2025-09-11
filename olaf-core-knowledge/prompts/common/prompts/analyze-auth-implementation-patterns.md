---
name: analyze-auth-implementation-patterns
description: Analyze authentication mechanisms, authorization frameworks, and security configuration
tags: [authentication, authorization, security, configuration]
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

**Authentication Mechanism Analysis**:
- Identify authentication methods (JWT, OAuth, SAML, session-based, etc.)
- Analyze authentication configuration and implementation patterns

**Authorization Framework Assessment**:
- Document authorization approaches (RBAC, ABAC, ACL, etc.)
- Analyze permission systems and access control patterns
- Identify role management and privilege escalation controls

**Security Configuration Review**:
- Analyze security headers, CORS configuration, and CSP policies
- Document password policies and account security measures
- Assess session management and token handling practices

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for authentication analysis execution
- Analyze authentication mechanisms, authorization frameworks, security configuration
- Document security implementation patterns and vulnerabilities

### 3. Validation Phase
You WILL validate results:
- Confirm authentication mechanism analysis is comprehensive
- Verify authorization framework assessment covers all access patterns
- Validate security configuration review identifies vulnerabilities

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-auth-implementation-patterns.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Authentication flow diagrams and security configuration matrix
- Documentation: Structured markdown with authentication analysis and security recommendations

## User Communication

### Progress Updates
- Confirmation when authentication mechanism analysis completes
- Authorization framework assessment progress
- Security configuration review completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Authentication mechanisms identified and analyzed
- Authorization frameworks documented with access control patterns
- Security configurations assessed with vulnerability analysis
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-auth-implementation-patterns.md`

### Next Steps
You WILL clearly define:
- Authentication analysis completed for Phase 6 Task #14
- API design analysis ready for Phase 5 Task #16 (if not completed)
- Files provided: authentication data for security pattern analysis
- Dependencies: Tasks #5 (technology stack) and #2 (application types) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual authentication implementations, not just framework capabilities
- Rule 2: Document authorization patterns with clear access control matrices
- Rule 3: Identify security vulnerabilities with specific remediation guidance
- Rule 4: Assess authentication user experience and security balance

## Success Criteria
You WILL consider the task complete when:
- [ ] Authentication mechanisms analyzed with implementation details
- [ ] Authorization frameworks documented with access control patterns
- [ ] Security configurations reviewed with vulnerability assessment
- [ ] Authentication flow diagrams created for complex implementations
- [ ] Output file generated with comprehensive authentication analysis

## Required Actions
1. Validate technology stack and application types input files
2. Execute authentication mechanism and authorization framework analysis
3. Generate security configuration review and vulnerability assessment
4. Create structured output file with authentication analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Authentication Found**: Document public access patterns or recommend authentication implementation
- **Python Script Missing**: Continue with manual authentication analysis, note missing automation
- **Complex Authentication Flows**: Document complexity and provide security recommendations

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual authentication implementations and their security effectiveness
- NEVER assume security based on framework choice without analyzing actual configurations
- ALWAYS document authorization patterns with clear access control definitions
- ALWAYS identify security vulnerabilities with specific, actionable remediation steps
