---
name: analyze-architecture-pattern-consistency
description: Analyze architectural patterns, pattern consistency, and microservices vs monolith assessment
tags: [architecture, patterns, consistency, microservices]
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
- **api_design_file**: string - Path to API design analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify application types (Task #2), technology stack (Task #5), and API design (Task #16) were completed
2. You WILL validate expected outcomes from previous steps:
   - `classify-repo-application-types.md` exists with application data
   - `identify-repo-technology-stack.md` exists with technology inventory
   - `analyze-api-design-documentation.md` exists with API analysis

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm all input files exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Architecture Pattern Detection**:
- Identify architectural patterns (MVC, MVP, MVVM, Layered, Hexagonal, etc.)
- Analyze service boundaries and component relationships

**Pattern Consistency Analysis**:
- Document pattern consistency across repositories and services
- Identify architectural deviations and inconsistencies
- Analyze pattern evolution and migration strategies

**Microservices vs Monolith Assessment**:
- Evaluate current architecture approach (monolith, microservices, hybrid)
- Analyze service decomposition and bounded contexts
- Assess architectural trade-offs and scalability implications

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for architecture pattern analysis
- Analyze architectural patterns, pattern consistency, microservices vs monolith assessment
- Document architectural metrics and improvement recommendations

### 3. Validation Phase
You WILL validate results:
- Confirm architecture pattern analysis is comprehensive
- Verify pattern consistency assessment covers all repositories
- Validate microservices assessment provides actionable insights

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-architecture-pattern-consistency.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Architecture pattern diagrams and consistency matrix
- Documentation: Structured markdown with architecture analysis and recommendations

## User Communication

### Progress Updates
- Confirmation when architecture pattern detection completes
- Pattern consistency analysis progress
- Microservices assessment completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Architecture patterns identified and analyzed
- Pattern consistency documented with deviation analysis
- Microservices vs monolith assessment completed
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-architecture-pattern-consistency.md`

### Next Steps
You WILL clearly define:
- Architecture pattern analysis completed for Phase 5 Task #21
- Code style analysis ready for Phase 7 Task #15
- Files provided: architecture data for quality analysis
- Dependencies: Tasks #2 (application types), #5 (technology stack), #16 (API design) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Focus on actual architectural implementations, not theoretical patterns
- Rule 2: Document pattern consistency with specific examples of deviations
- Rule 3: Assess microservices readiness based on actual service boundaries
- Rule 4: Provide actionable recommendations for architectural improvements

## Success Criteria
You WILL consider the task complete when:
- [ ] Architecture patterns identified with implementation analysis
- [ ] Pattern consistency analyzed across all repositories
- [ ] Microservices vs monolith assessment completed with trade-off analysis
- [ ] Architectural improvement recommendations provided
- [ ] Output file generated with comprehensive architecture analysis

## Required Actions
1. Validate application types, technology stack, and API design input files
2. Execute architecture pattern detection and consistency analysis
3. Generate microservices assessment and architectural recommendations
4. Create structured output file with architecture pattern analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Clear Architecture Pattern**: Document ad-hoc patterns and recommend standardization
- **Python Script Missing**: Continue with manual architecture analysis, note missing automation
- **Complex Architecture Patterns**: Document complexity and provide simplification guidance

⚠️ **Critical Requirements**
- MANDATORY: Focus on actual architectural implementations and their effectiveness
- NEVER assume architectural quality based on pattern choice alone
- ALWAYS document pattern consistency with specific examples and metrics
- ALWAYS provide actionable recommendations for architectural improvement and standardization
