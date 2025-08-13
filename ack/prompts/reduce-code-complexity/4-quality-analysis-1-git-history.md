---
name: 4-quality-analysis-1-git-history
description: Analyze git repository history to identify code change patterns, hotspots, and evolution trends for refactoring prioritization
tags: [quality-analysis, git-history, hotspots, change-patterns]
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
- **foundation_report_file**: string - Path to foundation report (3-discovery-baselining-consolidation-report.json)
- **output_location**: string - Where to save git analysis results (defaults to [id:findings_dir]/reduce-code-complexity/)

## Previous Steps or Phase
1. 3-Discovery-Baselining-Consolidation workflow completed successfully
2. Expected outcomes: Comprehensive project foundation with build/test baselines and quality metrics established

## Process

1. **Git Automation Integration**

### Existing Git Analysis Tools
   - Execute script: `[id:tools_dir]reduce-code-complexity/4-quality-analysis-1-analyze-git-history.ps1` for getting potential hotspots in git history
- **Output**: files-to-be-analyzed.txt file with git history analysis results
- **Integration**: Results feed into subsequent complexity and Halstead analysis steps

2. **Evolution Trend Analysis**:
   - Analyze codebase evolution patterns and growth trends
   - Identify architectural changes and major refactoring events
   - Document technical debt accumulation patterns
   - Assess code quality trends over time

## Output Format
Follow template structure: `[id:Id:findings_dir]reduce-code-complexity/files-to-be-analyzed.txt`


## Output to USER
- Confirmation: "Git history analysis completed successfully"
- Location: "Results saved to [id:findings_dir]reduce-code-complexity/files-to-be-analyzed.txt"
- Timestamp: Analysis completion time
- Next phase: "Ready for Quality Analysis Step 2: Complexity Assessment"
   - Provides code hotspots and change patterns for complexity analysis prioritization
   - Identifies high-risk areas requiring immediate attention during refactoring
   - Establishes data-driven foundation for strategic refactoring planning

## Domain-Specific Rules
- Rule 1: Git analysis must cover sufficient history period (minimum 6 months) for meaningful pattern identification
- Rule 2: Hotspot identification must correlate multiple factors (change frequency, complexity, bug correlation)
- Rule 3: All identified hotspots must be validated to exist in current codebase before prioritization
