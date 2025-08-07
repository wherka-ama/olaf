---
name: research-and-report
description: Create research plan, conduct systematic research, and write comprehensive structured report
tags: [research, report, planning, writing, analysis]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **research_topic**: string - Specific topic or question to research
- **scope_boundaries**: string - What is included and excluded from research
- **expected_outcomes**: string - Expected deliverables and target audience
- **timeline**: string - Optional research and writing timeline

## Process

1. **Planning Phase**:
   - Receive research topic from user and clarify ambiguities
   - Analyze topic to define research boundaries
   - Create detailed research plan including:
     - **Scope Statement**: What is included and excluded
     - **Key Research Questions**: Primary questions to answer
     - **Proposed Chapter Structure**: Hierarchical outline
     - **Potential Sources**: Preliminary source list (web, academic, internal docs)
   - Save research plan to: `[id:findings_dir]/research/research-plan-YYYYMMDD-SSS.md`
   - Present plan to user for approval using **Propose-Confirm-Act** protocol

2. **Execution Phase**:
   - Begin research and writing following approved chapter structure
   - For each chapter sequentially:
     - Conduct in-depth research using outlined methods and sources
     - Synthesize gathered information into clear, concise content
     - Draft chapter with appropriate formatting (headings, lists, tables)
     - Present completed chapter to user for review using **Propose-Confirm-Act**
     - Add approved chapter content to: `[id:findings_dir]/reports/research-report-YYYYMMDD-SSS.md`

3. **Finalization Phase**:
   - Compile all approved chapters into single cohesive report
   - Add title page and generate table of contents
   - Ensure consistent formatting throughout document
   - Save final report to: `[id:findings_dir]/reports/research-report-YYYYMMDD-SSS.md`
   - Notify user of completion with file path

## Output Format
Research deliverables following timestamp conventions:
- **Research Plan**: `research-plan-YYYYMMDD-SSS.md`
- **Draft Report**: `research-report-YYYYMMDD-SSS.md` (updated per chapter)
- **Final Report**: Complete compiled report with table of contents

## Output to USER
- Research plan created: [file path]
- Chapters completed: [number/total chapters]
- Final report delivered: [file path and completion timestamp]
- Key findings summary: [brief overview of main insights]

## Research Rules
- Rule 1: Research plan MUST be approved by user before any research begins
- Rule 2: Each chapter MUST be presented for user approval before proceeding to next
- Rule 3: All file paths and naming conventions must follow specified timestamp format
- Rule 4: Use Propose-Confirm-Act protocol for all major deliverable approvals
