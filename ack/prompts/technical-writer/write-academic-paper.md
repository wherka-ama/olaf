---
name: write-academic-paper
description: Generate well-structured academic-style papers in markdown format for technical and managerial audiences
tags: [academic, paper, markdown, technical, solution, documentation]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **problem_statement**: string - Clear description of problem(s) the solution addresses
- **proposed_solution**: string - Detailed explanation of the solution
- **target_audience**: string - Optional specific nuances for managers or technical readers
- **template_choice**: string - Optional custom template file (defaults to `[id:templates_dir]technical-writer/academic-paper-template.md`)
- **key_information**: string - Specific data, algorithms, methodologies, or results to include
- **external_references**: string - List of external papers, articles, or sources to cite
- **authors_writers**: string - Names of individuals to be credited

## Process

1. **Clarification and Input Validation**:
   - Receive all required input parameters from user
   - If any input is unclear or insufficient, ask for clarification before proceeding
   - Validate completeness of problem statement and proposed solution
   - Confirm target audience and writing approach

2. **Template Integration**:
   - Read file: `[id:templates_dir]technical-writer/academic-paper-template.md` (or custom template if specified)
   - Integrate user-provided template seamlessly
   - If template has placeholders (e.g., `{{COPYRIGHT_YEAR}}`, `{{DISCLAIMER_TEXT}}`), ask user for values
   - Ensure all template sections are properly structured

3. **Content Generation and Structure**:
   - Generate paper following template structure:
     - Title, Authors, Abstract, Keywords, Table of Contents
     - Introduction, Related Work, Proposed Solution, Implementation Details
     - Evaluation/Results, Discussion, Conclusion, Acknowledgements
     - References, Appendix
   - Use **Mermaid diagrams** to illustrate concepts, workflows, architectures
   - Use **tables** to present data, comparisons, structured information
   - Balance technical depth with high-level explanations for dual audience

4. **Finalization and Quality Assurance**:
   - Ensure all references properly formatted with complete information:
     - Title, Author(s), Publication date, URL/DOI, Publisher, Page numbers
   - Verify all diagrams and tables are correctly formatted and referenced
   - Double-check acronyms are defined in "Acronyms and Terms" section
   - Review for clarity for both technical and managerial perspectives
   - Save complete markdown content to appropriate location

## Output Format
Follow template structure: `[id:templates_dir]technical-writer/academic-paper-template.md`

Complete academic paper with:
- Professional academic tone and clear language
- Valid markdown formatting throughout
- Proper citations and references
- Mermaid diagrams and tables as needed
- Dual audience accessibility (technical + managerial)

## Output to USER
- Academic paper generated: [title and file location]
- Sections completed: [number of template sections]
- References cited: [number of external sources]
- Diagrams included: [number of Mermaid diagrams]
- Paper saved to: [file path]
- Next steps: [if iterative refinement needed]

## Academic Writing Rules
- Rule 1: Strictly follow instructions - do not assume or invent when unsure
- Rule 2: Ask for additional information if needed rather than making assumptions
- Rule 3: Use iterative approach for complex papers - seek user confirmation at each step
- Rule 4: Maintain professional academic tone while ensuring accessibility for both audiences
