---
name: [verb-entity-complement prompt name]
description: [Brief description of what this prompt accomplishes]
tags: [tag1, tag2, tag3, tag4]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **param_name**: type|options - Description
- **param_name**: type|options - Description
- **optional_param**: Optional description

## Previous Steps or Phase ! if this prompt if part of a chain or called from a workflow
1. Recall the phase , action or step that was preceding this
2. State the expected outcomes that should have been produce by the previous phase, action or step

## Process

1. **[Action Step]**: one or multiple of teh following
   - Execute terminal command: `command here`
   - Execute script: `[id:tools_dir]script-name.ps1` for automation
   - Use internal tool: `tool_name` for specific operation
   - Use MCP server tool: `mcp_server_name.tool_name` for external service
   - Specific instruction for this step

2. **[File Operation]**: from previous phase or context or because it is needed
   - Read/Write file: `[id:file_reference]`


3. **[Core Logic]**: Steps  to be taken in sequence
   - Main processing steps
   - Decision points and logic
   - when to invoke USER  for review and sign-off

## [Output/Result] Format
Follow template structure: `[id:templates_dir][template-name].md`

## Output to USER
- Confirmation message format
- Location/reference of changes
- Timestamp or identifier used
- Next phase if any
   - Define the next steps or actions to be taken
   - State the objectives clearly and VERY concisely
   - State files or resource this provides to the or phase next step


## [Domain-Specific] Rules
- Rule 1: Specific constraint or requirement
- Rule 2: Order/sequence requirements
- Rule 3: Data validation rules

## Required Actions
1. Execute specific command/operation
2. Read specific file for data
3. Process, execute core logic, and validate input
4. Write/update target file
5. Confirm completion

⚠️ **Critical Notes**
- Key warning or constraint
- Error prevention guidance
- Non-negotiable requirements
