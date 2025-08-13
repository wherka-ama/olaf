---
name: prepare-conversation-handover
description: Create a clear and concise handover document to ensure smooth transition between conversation sessions or team members.
tags: [handover, documentation, workflow, collaboration]
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
- **author**: string - Name of the person preparing the handover
- **next_steps**: array[object] - List of tasks to be completed next
- **context**: string - (Optional) Additional context or notes
- **timezone**: string - (Optional) Timezone for timestamps (default: "CEDT")

## Process

1. **Session Analysis**:
   - Review current conversation context
   - Identify key files and resources
   - Note important decisions and discussions
   - Capture current state and progress

2. **Handover Preparation**:
   - Document file locations and purposes
   - List pending tasks with priorities
   - Note any blockers or dependencies
   - Include relevant references and links

3. **Document Generation**:
   - Create structured handover document
   - Add timestamp and metadata
   - Include clear action items
   - Ensure all critical information is captured

## Output/Result Format
- Markdown document with:
  - Session metadata
  - Project state summary
  - File and resource references
  - Next steps and action items

## Output to USER
1. **Handover Document**:
   - Complete markdown file
   - Saved to `[id:handover]`
   - Ready for sharing or continuation

2. **Confirmation**:
   - Summary of created handover
   - Location of saved file
   - Next steps for the user

## Domain-Specific Rules
- Rule 1: Always include timestamps in specified timezone
- Rule 2: Use absolute paths for all file references
- Rule 3: Keep language clear and concise
- Rule 4: Structure information for easy scanning
- Rule 5: Include all necessary context for handover

## Required Actions
1. Gather session information
2. Identify key files and resources
3. Document current state
4. Define next steps
5. Generate handover document

## Handover Template
```markdown
# Conversation Handover Note

**Author:** [Your Name]  
**Timestamp:** [YYYYMMDD-HHmm TZ]  
**Project:** [Project Name]

## Current State
[Brief 1-2 sentence summary of current status]

## Key Files
- **Current Job:** [path] - [description]
- **Changelog:** [path] - [last entry summary]
- **Other Files:**
  - [path] - [purpose]
  - [path] - [purpose]

## Next Steps
1. [ ] Task 1 (Owner: [Who])
   - Details
   - Dependencies
2. [ ] Task 2 (Owner: [Who])
   - Details
   - Dependencies

## Important Notes
- [Any critical information or warnings]
- [Dependencies or blockers]
- [Decisions made in this session]

## References
- [Link to documentation]
- [Related conversations]
- [Additional resources]
```

⚠️ **Critical Notes**
- Always use absolute paths
- Include all necessary context
- Keep it concise but complete
- Update timestamps when reusing
- Verify all links and references
