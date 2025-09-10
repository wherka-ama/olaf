---
name: classify-repo-application-types
description: Classify repository application types and identify direct relationships between repositories
tags: [repository, classification, application, relationships]
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
- **workspace_structure_file**: string - Path to workspace content analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data-store/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify workspace content analysis (Task #1) was completed
2. You WILL validate expected outcomes from previous step:
   - `analyze-workspace-content-structure.md` exists and contains repository data
   - Repository list and relationships are documented
   - Workspace structure is mapped

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm workspace_structure_file exists and is readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Repository Analysis**:
- Read workspace structure data from previous analysis
- Analyze configuration files, README files, and project structure

**Application Type Classification**:
- Classify each repository by type:
  - Front-end (React, Angular, Vue, etc.)
  - Backend (API servers, microservices)
  - Database (schema, migrations, data)
  - API (REST, GraphQL, gRPC)
  - Full-stack (combined front/back)
  - Microservice (containerized service)
  - Library/SDK (reusable components)
  - Configuration/Infrastructure (IaC, deployment)

**Relationship Mapping**:
- Identify direct relationships between repositories
- Document API consumption patterns
- Map service dependencies and communication flows

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for classification execution
- For each repository, identify application purpose and functionality
- Document direct relationships with other repositories
- Classify by application type with supporting evidence

### 3. Validation Phase
You WILL validate results:
- Confirm all repositories classified correctly
- Verify relationship mappings are accurate
- Validate classification evidence is documented

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `classify-repo-application-types.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Application type matrix and relationship diagram
- Documentation: Structured markdown with classification rationale and evidence

## User Communication

### Progress Updates
- Confirmation when repository analysis completes
- Classification progress by repository count
- Relationship mapping completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Total repositories classified by type
- Application type distribution summary
- Direct relationships identified and mapped
- Output file location: `[id:ads_dir]product/context/{repository-name}/classify-repo-application-types.md`

### Next Steps
You WILL clearly define:
- Repository classification completed for Phase 1 Task #2
- Programming language analysis ready for Phase 1 Task #3
- Files provided: application type data for technology stack analysis
- Dependencies: Task #1 (workspace structure) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Base classification on actual code structure and configuration files, not just naming
- Rule 2: Document supporting evidence for each classification decision
- Rule 3: Identify hybrid applications (e.g., full-stack with API components)
- Rule 4: Map relationships based on actual dependencies, not assumed connections

## Success Criteria
You WILL consider the task complete when:
- [ ] All repositories classified with appropriate application type
- [ ] Classification evidence documented for each repository
- [ ] Direct relationships mapped between repositories
- [ ] Output file generated with structured classification data
- [ ] Application type distribution analyzed and summarized

## Required Actions
1. Validate workspace structure input file and prerequisites
2. Execute repository analysis and application type classification
3. Generate relationship mapping between repositories
4. Create structured output file with classification results
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Workspace Structure File**: Request completion of Task #1 first
- **Ambiguous Application Type**: Document as hybrid with multiple classifications
- **Python Script Missing**: Continue with manual classification, note missing automation
- **Insufficient Repository Data**: Request additional repository information or access
- **Classification Conflicts**: Document multiple possible types with rationale

⚠️ **Critical Requirements**
- MANDATORY: Base all classifications on actual code analysis, not assumptions
- NEVER classify repositories without examining their actual structure and purpose
- ALWAYS document the evidence supporting each classification decision
- ALWAYS map actual dependencies, not inferred relationships
- ALWAYS validate classifications against repository contents before finalizing
