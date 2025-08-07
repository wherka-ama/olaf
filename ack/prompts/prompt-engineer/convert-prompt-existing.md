---
name: convert-prompt-existing
description: Convert an existing prompt to follow proper template structure and principles
tags: [prompt, conversion, refactor, template]
---

## Time Retrieval
Get current time in YYYYMMDD-HHmm format using terminal:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **existing_prompt_path**: string - Path to the existing prompt file to convert
- **preserve_name**: boolean - Whether to keep the original name or allow modification

## Process

1. **Read Existing Prompt**: 
   - Read file: `[existing_prompt_path]`
   - Parse current structure and content
   - Identify core functionality and purpose

2. **Consult Guidelines**:
   - Read file: `[id:templates_dir]prompt-engineer/prompt-template.md`
   - Read file: `[id:templates_dir]prompt-engineer/prompting-principles.md`
   - Apply established prompting template and principles

3. **Analyze and Extract**:
   - Extract prompt name, description, and intent
   - Identify input parameters and process steps
   - Determine output format and domain rules
   - Preserve core logic while improving structure

4. **Generate Converted Prompt**:
   - Create new prompt following proper template format
   - Include proper YAML frontmatter with name, description, tags
   - Structure input parameters clearly
   - Organize process steps logically
   - Define clear output format and user-facing results
   - Add domain-specific rules and critical notes
   - Ensure clarity and conciseness for multi-LLM compatibility

5. **Save Converted Version**:
   - Extract original filename without extension
   - Write file: `[id:prompts_dir][original_name]-new.md`
   - Preserve original file intact
   - Automatically save without requiring user approval

## Output Format
Follow template structure: `[id:templates_dir]prompt-engineer/prompt-template.md`

## Output to USER
- Display converted prompt in markdown format
- Show comparison of key improvements made
- Confirm successful save location: `[id:prompts_dir][original_name]-new.md`
- Provide conversion summary and timestamp
- Next phase: Review and test converted prompt

## Domain-Specific Rules
- Rule 1: Never overwrite the original prompt file
- Rule 2: Always suffix new filename with "-new"
- Rule 3: Preserve core functionality while improving structure
- Rule 4: Follow template format strictly for consistency
- Rule 5: Maintain original intent and purpose
- Rule 6: Automatically save converted prompt without user confirmation

## Required Actions
1. Read and analyze existing prompt content
2. Apply template structure and prompting principles
3. Generate improved version with proper formatting
4. Automatically save to new file with "-new" suffix
5. Confirm completion and provide conversion summary

⚠️ **Critical Notes**
- Original prompt file remains unchanged
- Focus on structural improvements, not functional changes
- Ensure converted prompt maintains original capabilities
- Apply prompting best practices for clarity and effectiveness
