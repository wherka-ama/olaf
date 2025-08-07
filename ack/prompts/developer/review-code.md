---
name: review-code
description: Perform a comprehensive code review focusing on quality, security, and maintainability.
tags: [code-review, quality-assurance, security, best-practices]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **code_changes**: string - Code or diff to be reviewed
- **language**: string - Programming language of the code
- **context**: string - (Optional) Additional context about the changes
- **focus_areas**: array[enum] - (Optional) Specific areas to focus on (security, performance, style, etc.)

## Process

1. **Initial Analysis**:
   - Review code structure and organization
   - Check for code smells and anti-patterns
   - Verify adherence to coding standards
   - Assess error handling and logging

2. **Security Assessment**:
   - Identify potential vulnerabilities
   - Check input validation
   - Review authentication/authorization
   - Verify secure coding practices

3. **Quality Evaluation**:
   - Assess code readability
   - Check test coverage
   - Review documentation
   - Evaluate maintainability

4. **Performance Check**:
   - Identify potential bottlenecks
   - Review resource usage
   - Check for memory leaks
   - Assess algorithm efficiency

## Output/Result Format
Use `[id:templates_dir]developer/code-review-template.md` to structure the review findings:
- Follow the template's sections for consistency
- Include all required fields from the template
- Replace placeholder content with actual findings
- Maintain the structured format for documentation

## Output to USER
1. **Critical Issues**:
   - Security vulnerabilities
   - Major bugs
   - Performance concerns

2. **Recommendations**:
   - Code improvements
   - Best practices
   - Refactoring suggestions

3. **Positive Feedback**:
   - Well-implemented features
   - Clean code examples
   - Good practices followed

## Domain-Specific Rules
- Rule 1: Be constructive and specific
- Rule 2: Reference relevant standards
- Rule 3: Prioritize findings by severity
- Rule 4: Provide clear examples
- Rule 5: Consider context and constraints

## Required Actions
1. Analyze code changes
2. Identify issues and improvements
3. Document findings
4. Provide actionable feedback
5. Highlight positive aspects

⚠️ **Critical Notes**
- Never expose sensitive information
- Consider the change's context
- Balance perfection with practicality
- Respect team conventions
- Keep feedback objective
