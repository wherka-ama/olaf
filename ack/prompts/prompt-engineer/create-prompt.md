---
name: create-prompt
description: Generate new structured prompts from user requirements
tags: [prompt, generation, creation, workflow]
---

## Time Retrieval
Get current time in YYYYMMDD-HHmm format using terminal:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **user_request**: string - The user's requirement or task description
- **prompt_name**: string - Desired name for the prompt (max 4 words, kebab-case)
- **reuse_flag**: boolean - Whether prompt should be saved for reuse

## Process

1. **Analyze Request**: 
   - Parse user requirements and clarify ambiguities
   - Determine prompt scope and complexity

2. **Check Existing Prompts**:
   - Search `[id:prompts_dir]` for duplicates
   - Verify uniqueness before creation

3. **Consult Guidelines**:
   - Read file: `[id:templates_dir]prompt-engineer/prompt-template.md`
   - Read file: `[id:templates_dir]prompt-engineer/prompting-principles.md`
   - Apply established prompting template and principles

4. **Generate Prompt**:
   - Create structured prompt following template format
   - Include name, description, tags, parameters, input, output and process steps
   - Ensure clarity and conciseness for multi-LLM compatibility

5. **Save if Reusable**:
   - Write file: `[id:prompts_dir][prompt_name].md`
   - Use kabhabcase naming convention

## Output Format
Follow template structure: `[id:templates_dir]prompt-engineer/prompt-template.md`

## Output to USER
- Display generated prompt in markdown format
- Request approval before execution
- Confirm save location if reusable: `[id:prompts_dir][prompt_name].md`
- Next phase: Execute approved prompt

## Domain-Specific Rules
- Rule 1: Never execute prompt without user approval
- Rule 2: Filename must be camelCase, max 4 words
- Rule 3: All prompts must follow template structure

## Required Actions
1. Parse and validate user requirements
2. Read prompting principles guide
3. Generate structured prompt content
4. Present to user for approval
5. Save to prompts directory if approved

⚠️ **Critical Notes**
- Always request user sign-off before prompt execution
- Ensure prompt compatibility across different LLMs
- Maintain consistency with established template format




