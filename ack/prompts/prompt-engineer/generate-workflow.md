---
name: generate-workflow
description: Create structured workflows from templates or specifications
tags: [workflow, automation, code-generation, templates]
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
- **workflow_type**: string - Type of workflow to generate (sequential|iterative|decision|orchestrator)
- **workflow_name**: string - Name for the new workflow
- **description**: string - Brief description of workflow purpose
- **input_spec**: object - Input specifications (optional if using interactive mode)
- **output_spec**: object - Output specifications (optional if using interactive mode)
- **mode**: string - Generation mode (interactive|specification)
- **spec_file**: string - Path to specification file (required if mode=specification)

## Process

### 1. Determine Workflow Type
- If mode=interactive:
  1. Ask user workflow purpose and requirements
  2. Determine appropriate workflow type using classification logic
- Else if mode=specification:
  1. Load and validate specification file
  2. Extract workflow type and parameters

### 2. Select and Load Template
- Load appropriate template based on workflow type:
  - Sequential: `[id:templates_dir]prompt-engineer/workflow-template-sequential.md`
  - Iterative: `[id:templates_dir]prompt-engineer/workflow-template-iterative.md`
  - Decision: `[id:templates_dir]prompt-engineer/workflow-template-decision.md`
  - Orchestrator: `[id:templates_dir]prompt-engineer/workflow-template-orchestrator.md`

### 3. Gather Workflow Details
- If interactive:
  - Ask template-specific questions
  - Validate inputs match required format
  - Confirm with user before proceeding
- Else:
  - Validate specification against JSON schema
  - Map specification to template fields

### 4. Generate Workflow File
- Create new file: `[id:prompts_dir][workflow_name].md`
- Populate template with gathered information
- Ensure all placeholders are replaced
- Follow file naming conventions (kebab-case)

### 5. Validate and Save
- Verify all required sections completed
- Check file references use memory map format
- Validate JSON structures if present
- Save workflow file

## Output Specifications
- **Output File**: `[id:prompts_dir][workflow_name].md`
- **Format**: Markdown with YAML front matter
- **Validation Report**: Summary of generated workflow and any warnings

## Example Usage

### Interactive Mode
```
USER: generate-workflow --mode=interactive --workflow_name=analyze-code-complexity
ASSISTANT: Let's create a new workflow. What should this workflow accomplish?
[Interactive session continues...]
```

### Specification Mode
```
generate-workflow --mode=specification --spec_file=workflow-spec.json
```

## Error Handling
- If invalid input detected, provide specific error message and guidance
- If template not found, list available templates
- If specification invalid, provide validation errors
- If file already exists, prompt for confirmation before overwriting

## Dependencies
- Workflow templates in `[id:templates_dir]`
- JSON schema for specification validation
- Access to memory map for file references

## Related Files
- `[id:prompts_dir]workflow-template-*.md` - Template files
- `[id:templates_dir]workflow-schema.json` - JSON schema for specifications
