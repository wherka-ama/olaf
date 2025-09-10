---
name: synthesize-business-domain-context
description: Synthesize business domain context from application patterns, APIs, and documentation analysis
tags: [business, domain, synthesis, context]
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
- **api_design_file**: string - Path to API design analysis output (REQUIRED)
- **spec_driven_file**: string - Path to specification-driven development analysis output (REQUIRED)
- **documentation_file**: string - Path to documentation analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this synthesis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify application types (Task #2), API design (Task #16), spec-driven development (Task #25), and documentation (Task #17) were completed
2. You WILL validate expected outcomes from previous steps:
   - `classify-repo-application-types.md` exists with application data
   - `analyze-api-design-documentation.md` exists with API analysis
   - `analyze-spec-driven-development.md` exists with specification data
   - `analyze-documentation-coverage-quality.md` exists with documentation analysis

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm all input files exist and are readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Business Logic Pattern Analysis**:
- Analyze application patterns to infer business processes
- Identify business logic layers and domain boundaries
- Map business rules and validation patterns

**Feature Mapping and Workflow Inference**:
- Map API endpoints to business features and capabilities
- Infer user workflows from application structure and API design
- Identify business process automation and integration patterns
- Document feature relationships and dependencies

**Domain Terminology Extraction**:
- Extract business domain terminology from code, APIs, and documentation
- Build domain vocabulary and concept relationships
- Identify ubiquitous language patterns and consistency
- Document domain-specific business rules and constraints

**Business Context Synthesis**:
- Synthesize overall business domain context from technical patterns
- Identify business value streams and customer journeys
- Document business capabilities and service boundaries
- Assess business logic complexity and maintainability

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for business domain synthesis
- Analyze business logic patterns, feature mapping, workflow inference
- Extract domain terminology and synthesize business context
- Document business domain understanding derived from technical analysis

### 3. Validation Phase
You WILL validate results:
- Confirm business logic patterns accurately reflect application purpose
- Verify domain terminology extraction is comprehensive
- Validate business context synthesis provides actionable insights

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `synthesize-business-domain-context.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Business domain model and terminology glossary
- Documentation: Structured markdown with business context analysis and domain insights

## User Communication

### Progress Updates
- Confirmation when business logic pattern analysis completes
- Feature mapping and workflow inference progress
- Domain terminology extraction completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Business logic patterns identified and analyzed
- Domain terminology extracted and organized
- Business context synthesized from technical analysis
- Output file location: `[id:ads_dir]product/context/{repository-name}/synthesize-business-domain-context.md`

### Next Steps
You WILL clearly define:
- Business domain synthesis completed for Phase 10 Task #27 (Final Phase)
- Comprehensive project onboarding analysis workflow completed
- Files provided: Complete business and technical context for project understanding
- Dependencies: Tasks #2 (application types), #16 (API design), #25 (spec-driven), #17 (documentation) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Base business context synthesis on actual technical implementations, not assumptions
- Rule 2: Focus on business value and customer impact derived from technical patterns
- Rule 3: Document domain terminology with clear definitions and usage contexts
- Rule 4: Provide actionable business insights for stakeholders and development teams

## Success Criteria
You WILL consider the task complete when:
- [ ] Business logic patterns analyzed and mapped to business processes
- [ ] Feature mapping completed with workflow inference
- [ ] Domain terminology extracted and organized into comprehensive glossary
- [ ] Business context synthesized with actionable insights and recommendations
- [ ] Output file generated completing the comprehensive project onboarding analysis

## Required Actions
1. Validate all prerequisite input files from previous analysis phases
2. Execute business logic pattern analysis and feature mapping
3. Generate domain terminology extraction and business context synthesis
4. Create structured output file with comprehensive business domain analysis
5. Provide completion summary for entire project onboarding workflow

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **Insufficient Business Context**: Document limitations and recommend additional business analysis
- **Python Script Missing**: Continue with manual business domain synthesis, note missing automation
- **Complex Business Domain**: Document complexity and provide structured analysis approach
- **Inconsistent Business Patterns**: Document variations and recommend business process standardization

⚠️ **Critical Requirements**
- MANDATORY: Base all business insights on actual technical implementation analysis
- NEVER make business assumptions not supported by technical evidence
- ALWAYS provide actionable business insights that support decision-making
- ALWAYS document domain terminology with clear, consistent definitions
- ALWAYS synthesize business context that bridges technical and business stakeholder understanding
