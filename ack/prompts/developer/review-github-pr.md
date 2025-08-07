---
name: review-github-pr
description: Perform a comprehensive code review of GitHub Pull Requests with automated analysis and feedback.
tags: [code-review, github, pull-request, automation]
---

## Time Retrieval
Get current time in YYYYMMDD-HHmm format using terminal:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **pr_number**: number - (Optional) GitHub PR number (default: latest open PR)
- **repository**: string - (Optional) Repository in format 'owner/repo' (default: current context)
- **review_scope**: array[enum] - (Optional) Focus areas (security, performance, style, etc.)
- **auto_approve**: boolean - (Optional) Auto-approve if no issues found (default: false)

## Process

1. **PR Initialization**:
   - Fetch PR details and metadata
   - List all changed files
   - Check PR status and mergeability
   - Verify branch protection rules

2. **Code Analysis**:
   - For each changed file:
     - Run automated code review
     - Check for security vulnerabilities
     - Verify coding standards
     - Assess test coverage

3. **Review Generation**:
   - Create structured feedback
   - Categorize findings by severity
   - Include code suggestions
   - Reference relevant standards

4. **PR Interaction**:
   - Post review comments
   - Request changes if needed
   - Approve if criteria met
   - Update status checks

## Output/Result Format
- GitHub PR review with:
  - Summary of findings
  - File-specific comments
  - Suggested improvements
  - Security recommendations
  - Overall assessment

## Output to USER
1. **Review Summary**:
   - PR overview
   - Key findings
   - Required actions

2. **Detailed Feedback**:
   - Per-file analysis
   - Code suggestions
   - Security concerns

3. **Review Status**:
   - Approval status
   - Blocking issues
   - Next steps

## Domain-Specific Rules
- Rule 1: Respect GitHub review guidelines
- Rule 2: Follow team's coding standards
- Rule 3: Prioritize security issues
- Rule 4: Provide actionable feedback
- Rule 5: Maintain professional tone

## Required Actions
1. Authenticate with GitHub
2. Fetch PR details
3. Analyze code changes
4. Generate review
5. Submit feedback

⚠️ **Critical Notes**
- Never expose sensitive information
- Follow branch protection rules
- Respect code ownership
- Document review decisions
- Consider CI/CD status
