---
name: analyze-codebase-risk
description: Analyze a codebase for complexity, knowledge concentration, and bug fix risks, providing actionable insights and a prioritized refactoring plan.
tags: [analysis, code-quality, risk-assessment, refactoring]
---

## Time Retrieval
Get current time in YYYYMMDD-HHmm format using terminal:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **codebase_path**: string - Path to the codebase root directory
- **analysis_depth**: enum[quick,standard,deep] - (Optional) Depth of analysis (default: standard)
- **branch**: string - (Optional) Git branch to analyze (default: main)

## Process

1. **Codebase Analysis**:
   - Scan directory structure
   - Analyze code complexity metrics
   - Identify knowledge concentration (bus factor)
   - Review commit history for bug patterns

2. **Risk Assessment**:
   - Calculate risk scores for files
   - Identify critical files and components
   - Detect potential architectural issues
   - Evaluate test coverage

3. **Report Generation**:
   - Generate executive summary
   - Create detailed risk analysis
   - Develop refactoring recommendations
   - Prioritize action items

## Output/Result Format
- Final report saved as: `[id:findings_dir]CodebaseRisk-YYYYMMDD-NNN.md`
- Interactive markdown with collapsible sections
- Visual risk heatmaps
- Prioritized refactoring plan

## Output to USER
1. **Initial Scan**:
   - Codebase statistics
   - High-level risk assessment
   - Immediate concerns

2. **Detailed Analysis**:
   - File-level risk scores
   - Complexity metrics
   - Knowledge concentration analysis

3. **Actionable Plan**:
   - Prioritized refactoring tasks
   - Quick wins vs. strategic improvements
   - Recommended next steps

## Domain-Specific Rules
- Rule 1: Focus on objective, measurable metrics
- Rule 2: Consider both technical and human factors
- Rule 3: Provide context for all recommendations
- Rule 4: Include confidence levels for automated analysis
- Rule 5: Respect code ownership and team dynamics

## Required Actions
1. Scan and analyze codebase
2. Calculate risk metrics
3. Generate reports
4. Present findings
5. Recommend next steps

⚠️ **Critical Notes**
- Never modify source code during analysis
- Clearly distinguish between facts and recommendations
- Include references to specific code locations
- Consider team capacity in recommendations
- Preserve all analysis artifacts
