---
name: analyze-api-design-documentation
description: Analyze API design patterns, documentation quality, and versioning strategies across repositories
tags: [api, design, documentation, versioning]
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
- **application_types_file**: string - Path to application classification output (REQUIRED)
- **technology_stack_file**: string - Path to technology stack analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify application classification (Task #2) and technology stack (Task #5) were completed
2. You WILL validate expected outcomes from previous steps:
   - `classify-repo-application-types.md` exists with application data
   - `identify-repo-technology-stack.md` exists with technology inventory
   - API and backend services are identified

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm application_types_file and technology_stack_file exist and are readable
- Validate repository_name follows naming conventions

### 2. Execution Phase

**API Endpoint Discovery**:
- Scan for API definition files (OpenAPI, Swagger, RAML, GraphQL schemas)
- Identify REST endpoints, GraphQL queries/mutations, gRPC services

**Design Pattern Analysis**:
- Analyze API design patterns and conventions:
  - RESTful design principles adherence
  - Resource naming conventions
  - HTTP method usage patterns
  - Response format consistency
  - Error handling approaches

**Documentation Quality Assessment**:
- Evaluate API documentation completeness:
  - Endpoint documentation coverage
  - Parameter and response documentation
  - Example requests and responses
  - Authentication and authorization documentation
  - Rate limiting and usage guidelines

**Versioning Strategy Analysis**:
- Identify API versioning approaches:
  - URL path versioning (/v1/, /v2/)
  - Header-based versioning
  - Query parameter versioning
  - Content negotiation versioning

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for API analysis execution
- Analyze API design patterns and documentation quality
- Assess versioning strategies and backward compatibility
- Document API architecture and integration patterns

### 3. Validation Phase
You WILL validate results:
- Confirm all API endpoints identified and analyzed
- Verify design pattern assessment is comprehensive
- Validate documentation quality evaluation is complete

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-api-design-documentation.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: API inventory matrix and design pattern analysis
- Documentation: Structured markdown with API analysis and improvement recommendations

## User Communication

### Progress Updates
- Confirmation when API endpoint discovery completes
- Design pattern analysis progress by repository
- Documentation quality assessment completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Total APIs identified and analyzed across repositories
- Design pattern adherence assessment results
- Documentation quality scores and improvement areas
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-api-design-documentation.md`

### Next Steps
You WILL clearly define:
- API design analysis completed for Phase 5 Task #16
- Architecture pattern analysis ready for Phase 5 Task #21
- Files provided: API design data for security and governance analysis
- Dependencies: Tasks #2 (application types) and #5 (technology stack) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual API implementations, not just documentation or specifications
- Rule 2: Assess design consistency across all API endpoints within each service
- Rule 3: Evaluate documentation from both developer and consumer perspectives
- Rule 4: Analyze versioning strategy impact on backward compatibility

## Success Criteria
You WILL consider the task complete when:
- [ ] All API endpoints discovered and catalogued
- [ ] Design patterns analyzed for consistency and best practices
- [ ] Documentation quality assessed with specific improvement recommendations
- [ ] Versioning strategies evaluated for all APIs
- [ ] Output file generated with comprehensive API analysis

## Required Actions
1. Validate application types and technology stack input files
2. Execute API endpoint discovery and design pattern analysis
3. Generate documentation quality assessment and versioning analysis
4. Create structured output file with API design evaluation
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No APIs Found**: Document absence and assess if APIs are expected for application types
- **Python Script Missing**: Continue with manual API analysis, note missing automation
- **Complex API Architectures**: Document complexity and provide architectural recommendations
- **Inconsistent API Patterns**: Document variations and recommend standardization approaches

⚠️ **Critical Requirements**
- MANDATORY: Analyze actual API implementations, not just documentation or specifications
- NEVER assume API design quality based on framework choice alone
- ALWAYS evaluate documentation from both API provider and consumer perspectives
- ALWAYS assess versioning strategy impact on long-term maintainability
- ALWAYS provide specific, actionable recommendations for API design improvements
