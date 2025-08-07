---
name: analyze-technical-stack
description: Automatically discover, analyze, and assess a technical stack with minimal user input, identifying components, evaluating effectiveness, and providing recommendations.
tags: [analysis, technical-stack, discovery]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **project_root**: string - (Optional) Path to the project root directory for automated analysis
- **manual_input**: object - (Optional) Any known technical stack information to supplement automated discovery

## Process

1. **Automated Discovery**:
   - If project_root is provided:
     - Scan directory structure to identify project type (web, mobile, backend, etc.)
     - Parse package manager files (package.json, requirements.txt, etc.)
     - Detect framework and library usage from source code
     - Identify build tools and configuration files
     - Find database configuration and ORM usage
     - Discover CI/CD configuration and deployment scripts

2. **Analysis**:
   - For each discovered component:
     - Identify version and compatibility
     - Check for known vulnerabilities
     - Assess maintenance status and community support
     - Evaluate performance characteristics
     - Check documentation availability

3. **Intelligent Gap Analysis**:
   - Identify any critical missing information
   - Formulate minimal, targeted questions for user
   - Only request information that couldn't be automatically determined

4. **Comprehensive Assessment**:
   - Evaluate architecture patterns
   - Identify technical debt
   - Assess security posture
   - Evaluate scalability
   - Check test coverage and quality metrics

5. **Report Generation**:
   - Use template: `[id:templates_dir]architect/tech-stack-template.md`
   - Populate all relevant sections with discovered information
   - Generate architecture diagrams
   - Include version compatibility matrix
   - Document configuration requirements and recommendations

## Output/Result Format
- Final report saved as: `[id:findings_dir]technical-stack-analysis-for-<project_name>-YYYYMMDD-NNN.md`
  - `YYYYMMDD`: Current date in year-month-day format
  - `NNN`: 3-digit serial number (001, 002, etc.) for multiple reports on same day
- Interactive markdown report with collapsible sections
- Visual dependency graph
- Risk assessment matrix
- Automated recommendations
- Actionable insights

## Output to USER
1. **Initial Scan Results** (immediate):
   - Detected technologies
   - Initial findings
   - Any critical issues found

2. **Follow-up Questions** (if needed):
   - Only for information that couldn't be discovered automatically
   - Multiple-choice or yes/no when possible
   - Context-aware based on already discovered information

3. **Final Report**:
   - Executive summary
   - Detailed analysis
   - Recommendations
   - Migration paths
   - Resource requirements

## Domain-Specific Rules
- Rule 1: Always prefer automated discovery over user input
- Rule 2: Group related questions to minimize interactions
- Rule 3: Provide context for any requested information
- Rule 4: Validate user inputs against known patterns
- Rule 5: Update analysis with new information dynamically

## Required Actions
1. Perform initial automated scan
2. Analyze discovered components
3. Identify information gaps
4. Request minimal required input
5. Generate comprehensive report

⚠️ **Critical Notes**
- Never ask for information that can be automatically determined
- Always explain why specific information is needed
- Provide clear examples when requesting input
- Allow partial information and make reasonable assumptions
- Clearly document any assumptions made
- Provide a way to update or correct information

