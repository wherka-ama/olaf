---
name: create-prompt
description: Generate structured prompts following established template and principles
tags: [prompt, generation, engineering, template]
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

You WILL use terminal commands, not training data for timestamps.

## Input Parameters
You MUST request these parameters if not provided by the user:
- **user_request**: string - The user's requirement or task description (REQUIRED)
- **prompt_name**: string - Desired name for the prompt (max 4 words, kebab-case) (REQUIRED)
- **sub_category**: string - Sub-category folder for organization (REQUIRED - present list to user)
- **reuse_flag**: boolean - Whether prompt should be saved for reuse (OPTIONAL, default: true)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- You WILL use Propose-Confirm-Act for prompt creation due to high impact

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm user request is clear and actionable
- Validate prompt name follows kebab-case convention (max 4 words)
- You MUST list available sub-categories by reading directory structure: `[id:prompts_dir]`
- You WILL present sub-category options to user and request selection
- Check access to required template and principles files
- Search `[id:prompts_dir]/[selected_sub_category]` for existing prompts with similar functionality

### 2. Execution Phase

**Template and Principles Loading:**
<!-- <template_analysis> -->
You MUST read and analyze: `[id:templates_dir]/prompt-engineer/prompt-template.md`
<!-- </template_analysis> -->

<!-- <principles_analysis> -->
You MUST read and apply: `[id:templates_dir]/prompt-engineer/prompting-principles.md`
<!-- </principles_analysis> -->

**Core Logic**: You WILL execute following protocol requirements
- You MUST apply Propose-Confirm-Act protocol for user approval
- You WILL generate structured prompt following template structure exactly:
  - Time Retrieval section with imperative language
  - Input Parameters with REQUIRED/OPTIONAL designation
  - User Interaction Protocol section
  - Process with structured phases (Validation/Execution/Validation)
  - Output Format specification
  - User Communication structure
  - Domain-Specific Rules with clear enforcement
  - Success Criteria checklist
  - Error Handling scenarios
  - Critical Requirements section
- You MUST use imperative language throughout ("You WILL", "You MUST")
- You WILL include XML markup for complex sections
- You MUST ensure generated prompt includes comprehensive error handling
- You WILL validate generated prompt includes all required template sections

### 3. Validation Phase
You WILL validate the generated prompt meets all requirements:
- Confirms to template structure completely (all sections present)
- Uses imperative language consistently throughout
- Includes User Interaction Protocol section
- Contains comprehensive error handling scenarios
- Has measurable success criteria
- Follows established principles for clarity and execution
- Contains proper XML markup where appropriate

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: Complete prompt following template exactly
- Validation checklist: Compliance verification against template and principles
- File location specification: `[id:prompts_dir]/[sub_category]/[prompt_name].md`

## User Communication

### Progress Updates
- Confirmation when sub-categories are listed and user selection obtained
- Confirmation when template and principles are successfully loaded
- Status of duplicate check results in selected sub-category
- Validation results for generated prompt

### Completion Summary
- Generated prompt presented for review via Propose-Confirm-Act
- Validation checklist results showing template compliance
- Save location confirmation if approved: `[id:prompts_dir]/[sub_category]/[prompt_name].md`

### Next Steps
You WILL clearly define:
- Prompt ready for execution (pending user approval)
- File saved location: `[id:prompts_dir]/[sub_category]/[prompt_name].md`
- Confirmation that prompt meets all quality standards

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Generated prompt MUST follow template structure exactly (all sections required)
- Rule 2: Generated prompt MUST use imperative language consistently
- Rule 3: Generated prompt MUST include User Interaction Protocol section
- Rule 4: Generated prompt MUST have comprehensive error handling
- Rule 5: Filename MUST be kebab-case, max 4 words
- Rule 6: Generated prompt MUST include measurable success criteria
- Rule 7: You MUST present available sub-categories and require user selection
- Rule 8: File MUST be saved in selected sub-category folder

## Success Criteria
You WILL consider the task complete when:
- [ ] All required parameters validated and obtained
- [ ] Sub-categories listed and user selection obtained
- [ ] Template and principles files successfully loaded and analyzed
- [ ] Duplicate check completed in selected sub-category (no conflicts found)
- [ ] Prompt generated following template structure exactly
- [ ] Validation confirms 100% template and principles compliance
- [ ] User approval obtained via Propose-Confirm-Act protocol
- [ ] File saved successfully in correct sub-category folder (if requested)
- [ ] Generated prompt includes all critical sections (error handling, success criteria, etc.)

## Required Actions
1. Validate all required input parameters and prerequisites
2. Execute operations following appropriate interaction protocol
3. Generate outputs in specified format
4. Provide user communication and confirmations
5. Define next steps if part of workflow

## Error Handling
You WILL handle these scenarios:
- **Missing/Unclear Requirements**: Request specific clarification with examples
- **Sub-category Access Failed**: Provide error message and request manual sub-category specification
- **Invalid Sub-category Selection**: Re-present available options and request valid selection
- **Template/Principles File Access Failed**: Provide clear error message and manual alternatives
- **Duplicate Prompt Found in Sub-category**: Present existing prompt and ask for modification preferences
- **Template Compliance Validation Failed**: Regenerate prompt addressing specific missing sections
- **User Rejection During Propose-Confirm-Act**: Request specific feedback and iterate
- **File Save Failures in Sub-category**: Provide alternative save methods and troubleshooting steps

⚠️ **Critical Requirements**
- MANDATORY: Follow Propose-Confirm-Act protocol for all prompt generation
- MANDATORY: Generated prompts MUST include ALL template sections without exception
- NEVER generate prompts that don't use imperative language consistently
- NEVER skip validation phase - all generated prompts must be verified against template
- ALWAYS ensure generated prompts include comprehensive error handling
- ALWAYS validate that generated prompts include measurable success criteria
- NEVER save prompts without explicit user approval




