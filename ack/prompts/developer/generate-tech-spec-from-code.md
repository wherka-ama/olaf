---
name: generate-tech-spec-from-code
description: Create comprehensive technical specifications by analyzing existing codebases, ideal for legacy applications lacking proper documentation.
tags: [documentation, technical-spec, code-analysis, reverse-engineering]
---


## Framework Validation
You MUST apply the <olaf-work-instructions> framework.
You MUST pay special attention to**:
- <olaf-general-role-and-behavior> - Expert domain approach
- <olaf-interaction-protocols> - Appropriate execution protocol
You MUST strictly apply <olaf-framework-validation>.

## Time Retrieval
You MUST get current time in YYYYMMDD-HHmm format using terminal commands:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **application_name**: string - Name of the application
- **code_path**: string - Path to the codebase
- **tech_stack**: array[string] - Technologies used in the application
- **key_components**: array[string] - Main components (e.g., ["frontend", "backend", "database"])
- **existing_docs**: array[string] - (Optional) Paths to any existing documentation

## Process

1. **Codebase Analysis**:
   - Scan directory structure
   - Identify architectural patterns
   - Map component interactions
   - Extract API endpoints
   - Analyze database schema

2. **Feature Documentation**:
   - Catalog all user-facing features
   - Document workflows and user journeys
   - Map user roles and permissions
   - Detail form handling and validation
   - Document state management

3. **Technical Documentation**:
   - Create architecture diagrams
   - Document data models and relationships
   - List all integrations and dependencies
   - Detail security implementations
   - Document configuration requirements

4. **Modernization Assessment**:
   - Identify technical debt
   - Suggest improvements
   - Document risks and challenges
   - Provide migration recommendations

## Output/Result Format
Follow template structure: `[id:templates_dir]developer/specification-template.md`

**Save Output**: Create file `[id:findings_dir]specs/tech-spec-YYYYMMDD-NNN.md` where:
- YYYYMMDD is the current date
- NNN is a sequential number (001, 002, etc.)


## Output to USER
1. **Technical Specification**:
   - Comprehensive feature documentation
   - Architecture diagrams
   - Data models and relationships
   - API documentation
   - Security considerations

2. **Analysis Report**:
   - Code quality assessment
   - Technical debt analysis
   - Modernization opportunities
   - Risk assessment

## Domain-Specific Rules
- Rule 1: Document all user roles and permissions
- Rule 2: Include detailed workflow diagrams
- Rule 3: Document all external dependencies
- Rule 4: Provide code examples for key features
- Rule 5: Include security considerations

## Required Actions
1. Analyze codebase structure
2. Document features and workflows
3. Create technical documentation
4. Generate architecture diagrams
5. Compile modernization recommendations


⚠️ **Critical Notes**
- Never expose sensitive information
- Validate all code examples
- Maintain version control of specifications
- Document assumptions and limitations
- Keep documentation in sync with code
