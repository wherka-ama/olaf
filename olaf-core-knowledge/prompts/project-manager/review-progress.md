---
name: review-progress
description: Conduct a comprehensive work review to assess progress, identify accomplishments, and plan upcoming priorities.
tags: [review, progress, planning, assessment]
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
- **review_period**: string - Time period to review (e.g., "past 7 days", "Q2 2025")
- **focus_areas**: array[string] - (Optional) Specific projects or metrics to focus on
- **team_members**: array[string] - (Optional) Team members to include in the review
- **metrics**: array[enum] - (Optional) Key metrics to evaluate (velocity, quality, delivery, etc.)

## Process

1. **Data Collection**:
   - Gather work logs and activity data
   - Review completed tasks and milestones
   - Analyze performance metrics
   - Collect team member updates

2. **Progress Analysis**:
   - Compare against goals and OKRs
   - Identify achievements and blockers
   - Assess resource allocation
   - Evaluate team performance

3. **Reporting**:
   - Generate progress summary
   - Highlight key accomplishments
   - Document challenges and learnings
   - Provide actionable insights

4. **Planning**:
   - Set priorities for next period
   - Adjust timelines if needed
   - Identify risks and mitigation
   - Define success metrics

## Output/Result Format
Use `[id:templates_dir]project-manager/progress-review-template.md` to structure the progress review:
- Follow the template's sections for consistency
- Include all required fields from the template
- Replace placeholder content with actual findings
- Maintain the structured format for documentation

## Output to USER
1. **Progress Overview**:
   - Goals vs. actuals
   - Major achievements
   - Key challenges

2. **Detailed Analysis**:
   - Project status updates
   - Team performance metrics
   - Resource utilization

3. **Next Steps**:
   - Priority actions
   - Timeline adjustments
   - Resource needs

## Domain-Specific Rules
- Rule 1: Focus on data-driven insights
- Rule 2: Maintain constructive feedback
- Rule 3: Align with business objectives
- Rule 4: Consider team capacity
- Rule 5: Document assumptions

## Required Actions
1. Collect relevant data
2. Analyze progress
3. Generate report
4. Identify improvements
5. Plan next steps

⚠️ **Critical Notes**
- Protect sensitive information
- Be objective and fair
- Include both qualitative and quantitative data
- Link to supporting evidence
- Keep it actionable
