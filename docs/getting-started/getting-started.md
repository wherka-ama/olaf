# OLAF Getting Started Guide

**Target Audience:** New OLAF users and developers

## Overview

OLAF (Optimized LLM Agent Framework) is a competency-driven AI agent framework that enables structured, protocol-based interactions with Large Language Models. This guide demonstrates OLAF's core capabilities through practical examples and real conversation records.

---

## What You'll Learn

This getting started guide walks you through OLAF's key features:

1. **Competency Discovery** - How to find available AI capabilities
2. **Conversation Documentation** - How to capture and analyze AI interactions  
3. **Knowledge Research** - How to conduct structured research with AI
4. **Prompt Engineering** - How to create standardized AI prompts
5. **Research Planning** - How to manage complex, multi-session research projects

Each section includes:
- ✅ **Live Examples** - Real conversation records showing actual usage
- 🔗 **Linked Resources** - Direct links to prompts, templates, and outputs
- 📋 **Step-by-Step Instructions** - How to replicate the examples
- 🎯 **Best Practices** - Tips for effective usage

---

## Section 1: Discovering Available Competencies

### The `/list-competencies` Command

OLAF provides a simple way to discover all available AI competencies through the `/list-competencies` workflow.

**What it does:**
- Lists all available AI competencies organized by role (developer, researcher, project-manager, etc.)
- Shows the trigger phrases that activate each competency
- Displays the execution protocol (Act, Propose-Act, Propose-Confirm-Act)

**How to use it:**
1. Type `/list-competencies` in your AI chat
2. The system will read the competency index and display all available capabilities
3. Use the trigger phrases to activate specific competencies

**Example Output Structure:**
```
Developer Competencies:
- "review code" → developer/review-code.md (Act protocol)
- "code review" → developer/review-code.md (Act protocol)

Researcher Competencies:  
- "search and learn" → researcher/search-and-learn.md (Act protocol)
- "research and report" → researcher/research-and-report.md (Propose-Confirm-Act protocol)

Project Manager Competencies:
- "store conversation" → project-manager/store-conversation-record.md (Act protocol)
- "create job" → project-manager/create-job.md (Act protocol)
```

**Key Benefits:**
- **Discoverability**: Find capabilities you didn't know existed
- **Consistency**: Standardized trigger phrases across all competencies
- **Protocol Awareness**: Understand how each competency will interact with you

---

## Section 2: Documenting AI Conversations

### The "Store Conversation" Competency

One of OLAF's most powerful features is automatic conversation documentation using the **"store conversation"** competency.

**📋 Live Example:** [Conversation Record 20250926-1453](conversations/conversation-record-20250926-1453.md)

This example shows a complete research session where the user:
1. Requested research on AWS Strands and AgentCore
2. Approved a research plan  
3. Received a comprehensive technical report
4. Used "store conversation" to document the entire session

**What the competency captures:**
- **Timeline**: Exact timestamps of each interaction
- **Actions Taken**: Every file read, search performed, and output created
- **Files Created/Modified**: Complete audit trail of all changes
- **User Interactions**: Full conversation flow with context

**How to use it:**
1. At the end of any AI session, simply say: **"store conversation"**
2. OLAF automatically:
   - Finds the store-conversation competency
   - Retrieves current timestamp
   - Creates a detailed narrative record
   - Saves it to the conversations directory

**Generated Output Location:**
```
olaf-data/product/documentations/conversations/
└── conversation-record-YYYYMMDD-HHmm.md
```

**Why this matters:**
- **Accountability**: Full audit trail of AI assistance
- **Knowledge Transfer**: Share exactly what was accomplished
- **Session Continuity**: Resume work across multiple sessions
- **Learning**: Understand how competencies work in practice

---

## Section 3: Structured Knowledge Research

### The "Search and Learn" Competency

The **"search and learn"** competency demonstrates OLAF's ability to conduct focused research using web search capabilities.

**How it works:**
1. **Competency Detection**: OLAF finds the competency in its library using trigger phrases like "search and learn"
2. **Parameter Collection**: Requests essential information if not provided:
   - Research topic/question
   - Scope and focus areas
   - Target audience level
3. **Web Research**: Uses the agent's web search tools to gather current information
4. **Report Generation**: Creates a structured report with findings and sources

**Key Features:**
- **Current Information**: Always searches for up-to-date web sources
- **Source Documentation**: Provides full URLs and citations
- **Structured Output**: Organized findings with clear sections
- **Scope Management**: Focuses research based on user requirements

**Example Usage:**
```
User: "search and learn about microservices architecture patterns"

OLAF Response:
1. Identifies the search-and-learn competency
2. Requests any missing parameters (scope, audience)
3. Conducts web searches for current information
4. Creates structured report with findings
5. Saves report to findings directory
```

**Output Location:**
```
olaf-data/findings/research/
└── research-report-YYYYMMDD-HHmm.md
```

---

## Section 4: Advanced Research with User Review

### The "Research and Report" Competency

For complex research requiring user oversight, OLAF provides the **"research and report"** competency with the **Propose-Confirm-Act** protocol.

**📋 Live Example:** [Research Plan 20250926-1445](research/research-plan-20250926-1445.md)

This example shows how OLAF:
1. Created a detailed 7-chapter research plan for AWS Strands and AgentCore
2. Presented the plan for user approval
3. Executed systematic research across multiple web sources
4. Generated a comprehensive technical report

**Protocol Flow:**
1. **Propose**: Creates detailed research plan with scope, questions, and chapter structure
2. **Confirm**: Waits for user approval before proceeding
3. **Act**: Executes research systematically, updating progress

**Key Benefits:**
- **User Control**: Review and modify research scope before execution
- **Structured Approach**: Organized chapter-by-chapter execution
- **Progress Tracking**: Clear milestones and deliverables
- **Session Continuity**: Can pause and resume across multiple sessions

**Generated Outputs:**
```
olaf-data/findings/research/
├── research-plan-YYYYMMDD-HHmm.md      # Approved research plan
└── research-report-YYYYMMDD-HHmm.md    # Final comprehensive report
```

**When to use this competency:**
- Complex research requiring multiple sources
- Technical analysis for decision-making
- Competitive analysis and market research
- Any research where you want to review the approach first

---

## Section 5: Creating Custom AI Prompts

### The "Create Prompt" Competency

OLAF enables you to create standardized AI prompts that follow framework principles and templates.

**How it works:**
1. **Template-Based**: Uses standardized templates from `olaf-core/templates/`
2. **Role Organization**: Automatically categorizes prompts by role (developer, researcher, etc.)
3. **Consistency**: Ensures all prompts follow OLAF core principles
4. **Deduplication**: Checks for existing similar prompts to avoid duplicates

**Prompt Structure Analysis:**

All OLAF prompts follow this standardized structure:

```markdown
---
name: prompt-name
description: Brief description of what the prompt does
tags: [relevant, tags, for, categorization]
---

## Framework Validation
[Standard OLAF framework requirements]

## Time Retrieval  
[Timestamp handling instructions]

## Input Parameters
[Required and optional parameters]

## User Interaction Protocol
[Act/Propose-Act/Propose-Confirm-Act specification]

## Process
[Step-by-step execution instructions]

## Output Format
[Expected deliverables and file locations]

## Success Criteria
[Checklist for completion validation]
```

**Example: Finding Created Prompts**

After using the "create prompt" competency, you can find your new prompt in:
```
olaf-core/prompts/<category>/
└── your-new-prompt.md
```

**Categories include:**
- `developer/` - Code analysis, review, testing prompts
- `researcher/` - Research, analysis, investigation prompts  
- `project-manager/` - Planning, documentation, tracking prompts
- `business-analyst/` - Requirements, specifications, user stories
- `technical-writer/` - Documentation, tutorials, presentations

**Template Analysis:**

The create-prompt competency uses templates from:
```
olaf-core/templates/<category>/
└── prompt-template.md
```

These templates ensure:
- **Consistency**: All prompts follow the same structure
- **Completeness**: Required sections are never missed
- **Standards Compliance**: Automatic adherence to OLAF principles
- **Quality**: Built-in validation and success criteria

---

## Section 6: Understanding OLAF Protocols

### Interaction Protocols Explained

OLAF uses three distinct interaction protocols to balance safety and efficiency:

#### **Act Protocol** (Direct Execution)
- **When used**: Safe, read-only operations
- **Behavior**: Executes immediately without asking
- **Examples**: Reading files, listing directories, searching code
- **User experience**: Fast, efficient, minimal interruption

#### **Propose-Act Protocol** (Analysis Before Action)  
- **When used**: Actions requiring user agreement
- **Behavior**: Presents plan, waits for approval, then executes
- **Examples**: Code modifications, file creation, research execution
- **User experience**: One confirmation step, maintains control

#### **Propose-Confirm-Act Protocol** (Multi-Step Validation)
- **When used**: Complex, multi-step operations with significant impact
- **Behavior**: 
  1. **Propose**: Present detailed plan
  2. **Review**: Wait for user feedback
  3. **Confirm**: Ask for final sign-off  
  4. **Act**: Execute only after confirmation
- **Examples**: Large research projects, system modifications, complex analysis
- **User experience**: Maximum control, suitable for complex tasks

**Protocol Selection:**
Each competency specifies its protocol in the competency index. This ensures consistent behavior and appropriate safety levels.

---

## Section 7: File Organization and Memory Map

### Understanding OLAF's Structure

OLAF uses a standardized file organization system with ID-based references:

#### **Core Framework** (`olaf-core/`)
- **Prompts**: `olaf-core/prompts/<role>/` - All AI competency definitions
- **Templates**: `olaf-core/templates/<role>/` - Standardized templates  
- **Tools**: `olaf-core/tools/` - Utility scripts and analyzers
- **Reference**: `olaf-core/reference/` - Core principles and guides

#### **Work Environment** (`olaf-data/`)
- **Projects**: `olaf-data/projects/` - Jobs, changelogs, project tracking
- **Product**: `olaf-data/product/` - Decision records, documentation
- **Findings**: `olaf-data/findings/` - Research outputs, analysis results
- **Peoples**: `olaf-data/peoples/` - Team member information

#### **File Referencing Convention**
OLAF uses ID-based file references for consistency:
- **Files**: `[id:file_id]` → `olaf-data/specific-file.md`
- **Directories**: `[id:dir_id]` → `olaf-data/specific-directory/`
- **Files in Directories**: `[id:dir_id]filename.ext`

This system ensures:
- **Consistency**: Same references across all prompts and documentation
- **Maintainability**: Easy to update paths in one location
- **Clarity**: Clear understanding of file locations

---

## Next Steps

### Getting Started Checklist

- [ ] **Try `/list-competencies`** - Discover available AI capabilities
- [ ] **Use "store conversation"** - Document your first AI session  
- [ ] **Experiment with "search and learn"** - Conduct focused research
- [ ] **Try "research and report"** - Experience the Propose-Confirm-Act protocol
- [ ] **Create a custom prompt** - Build your own AI competency
- [ ] **Explore the file structure** - Understand OLAF's organization

### Advanced Usage

Once comfortable with basics:
- **Create Jobs**: Use project management competencies for task tracking
- **Code Analysis**: Leverage developer competencies for code review and improvement
- **Documentation**: Use technical writer competencies for comprehensive documentation
- **Team Collaboration**: Share conversation records and research reports

### Getting Help

- **Competency Index**: Check `olaf-core/reference/query-competency-index.md` for all available capabilities
- **Core Principles**: Review `olaf-core/reference/core-principles.md` for framework guidelines
- **Examples**: Explore `docs/getting-started/` for real usage examples

---

## Summary

OLAF transforms AI interactions from ad-hoc conversations into structured, documented, and repeatable processes. By using competencies, protocols, and standardized templates, you can:

- **Discover** AI capabilities systematically
- **Document** all AI interactions automatically  
- **Research** complex topics with proper oversight
- **Create** standardized AI prompts and workflows
- **Collaborate** effectively using shared conversation records

The framework ensures consistency, safety, and knowledge preservation across all AI-assisted work.

**Ready to start?** Try `/list-competencies` in your next AI conversation!

---

*This documentation was generated using OLAF competencies and demonstrates the framework's capabilities through real examples and conversation records.*
