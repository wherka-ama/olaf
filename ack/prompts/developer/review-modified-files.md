---
name: review-modified-files
description: Gather and review modified and new files in current git branch with comprehensive analysis
tags: [code review, git, modified files, quality, security, maintainability]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **branch_name**: string - Optional specific branch to review (defaults to current branch)
- **file_filter**: string - Optional file types to include (e.g., "*.cs,*.js,*.py")
- **batch_size**: number - Optional number of files to process per batch (default: 10)

## Process

1. **Gather Modified Files**:
   - Execute terminal command: `git status --porcelain`
   - Categorize files as:
     - Modified files (indicated by 'M')
     - New files (indicated by 'A' or '?')
     - Deleted files (indicated by 'D')
   - Filter out non-relevant files (binary files, large data files, etc.)
   - Present file list to user for confirmation
   - Process files in batches if many modified files exist

2. **Review Each File**:
   - For each file in confirmed list:
     - Use internal tool: `review-code` competency from `[id:prompts_dir]review-code.md`
     - Prioritize files by importance, complexity, and extent of changes
     - Generate individual review file for each analyzed file
   - Maintain progress tracking across all file reviews

3. **Summarize Overall Findings**:
   - Create comprehensive summary after all files reviewed
   - Determine next available serial number (NNN) for current date
   - Write file: `[id:code_reviews_dir]code-review-summary-{YYYYMMDD-NNN}.md`
   - Include in summary:
     - Number of files reviewed by type (modified, new, deleted)
     - List of all generated code review files
     - Aggregated findings by severity level
     - Common patterns or issues found across multiple files
     - Recommendations for team-wide improvements

## Output Format
Generated files following naming conventions:
- **Individual Reviews**: Per `review-code` competency output format
- **Summary Report**: `code-review-summary-YYYYMMDD-NNN.md`

## Output to USER
- Files gathered: [number of modified/new/deleted files]
- Reviews completed: [number of files successfully reviewed]
- Summary report created: [file path to summary]
- Key findings: [brief overview of critical issues found]
- Recommendations: [high-priority actions for code quality improvement]

## Code Review Rules
- Rule 1: Filter out binary and non-reviewable files before user confirmation
- Rule 2: Process files in manageable batches to avoid overwhelming output
- Rule 3: Prioritize high-impact files (core logic, frequently changed) first
- Rule 4: Generate individual review files before creating summary to ensure completeness
