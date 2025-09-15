---
name: analyze-code-style-conventions
description: Analyze naming conventions per language, formatting tools, and style guide compliance
tags: [code, style, conventions, formatting]
---

## Framework Validation
You MUST apply the <olaf-work-instructions> framework.
You MUST pay special attention to:
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
- **language_analysis_file**: string - Path to language distribution analysis output (REQUIRED)
- **repository_name**: string - Name of the repository for output file naming (REQUIRED)
- **output_location**: string - Target directory for analysis output (OPTIONAL, default: olaf-data/product/context/{repository-name}/)

## User Interaction Protocol
You MUST follow the established interaction protocol strictly:
- Act / Propose-Act / Propose-Confirm-Act (defined externally)
- Use Act protocol for this analysis task

## Prerequisites
You MUST verify the preceding phase/action was completed:
1. You MUST verify language analysis (Task #3) was completed
2. You WILL validate expected outcomes from previous step:
   - `analyze-repo-language-distribution.md` exists with language data

## Process

### 1. Validation Phase
You WILL verify all requirements:
- Confirm language_analysis_file exists and is readable
- Validate repository_name follows naming conventions
- Check write access to output location

### 2. Execution Phase

**Style Configuration Detection**:
- Identify style configuration files (.eslintrc, .prettierrc, pyproject.toml, etc.)
- Analyze formatting tool configurations and rules

**Naming Convention Analysis**:
- Document naming conventions by language (camelCase, snake_case, PascalCase)
- Analyze consistency of naming patterns across codebase
- Identify naming convention violations and inconsistencies

**Style Guide Compliance Assessment**:
- Evaluate adherence to established style guides (PEP 8, Google Style Guide, etc.)
- Analyze code formatting consistency and automated formatting usage
- Document style guide deviations and improvement opportunities

**Core Logic**: Execute following protocol requirements
- Apply Act protocol for code style analysis
- Analyze naming conventions per language, formatting tools, style guide compliance
- Document style consistency and improvement recommendations

### 3. Validation Phase
You WILL validate results:
- Confirm style configuration analysis is comprehensive
- Verify naming convention documentation covers all languages
- Validate style guide compliance assessment provides actionable insights

## Output Format
You WILL generate outputs following this structure:
- Primary deliverable: `analyze-code-style-conventions.md` in `[id:ads_dir]product/context/{repository-name}/`
- Supporting files: Style configuration matrix and naming convention guide
- Documentation: Structured markdown with code style analysis and recommendations

## User Communication

### Progress Updates
- Confirmation when style configuration detection completes
- Naming convention analysis progress
- Style guide compliance assessment completion status
- Timestamp identifier used: [YYYYMMDD-HHmm format]

### Completion Summary
- Style configurations identified and analyzed
- Naming conventions documented with consistency analysis
- Style guide compliance assessed with improvement recommendations
- Output file location: `[id:ads_dir]product/context/{repository-name}/analyze-code-style-conventions.md`

### Next Steps
You WILL clearly define:
- Code style analysis completed for Phase 7 Task #15
- Dependency analysis ready for Phase 7 Task #20
- Files provided: style data for quality assessment
- Dependencies: Task #3 (language analysis) completed

## Domain-Specific Rules
You MUST follow these constraints:
- Rule 1: Analyze actual code style implementations, not just configuration files
- Rule 2: Document language-specific naming conventions with examples
- Rule 3: Assess style consistency across team members and time periods
- Rule 4: Provide specific recommendations for style standardization

## Success Criteria
You WILL consider the task complete when:
- [ ] Style configurations analyzed across all languages
- [ ] Naming conventions documented with consistency assessment
- [ ] Style guide compliance evaluated with specific recommendations
- [ ] Code formatting tool usage analyzed
- [ ] Output file generated with comprehensive code style analysis

## Required Actions
1. Validate language analysis input file
2. Execute style configuration detection and naming convention analysis
3. Generate style guide compliance assessment and recommendations
4. Create structured output file with code style analysis
5. Provide completion summary and next steps

## Error Handling
You WILL handle these scenarios:
- **Missing Input Files**: Request completion of prerequisite tasks first
- **No Style Configuration Found**: Document ad-hoc styling and recommend standardization
- **Python Script Missing**: Continue with manual style analysis, note missing automation
- **Inconsistent Style Patterns**: Document variations and recommend style guide adoption

⚠️ **Critical Requirements**
- MANDATORY: Analyze actual code style implementations across all source files
- NEVER assume style quality based on configuration file presence alone
- ALWAYS document naming convention consistency with specific examples
- ALWAYS provide actionable recommendations for style standardization and automation
