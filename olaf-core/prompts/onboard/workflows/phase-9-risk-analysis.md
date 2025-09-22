---
name: phase-9-risk-analysis
description: Risk analysis workflow - hotspot analysis, critical contributors analysis (requires historical data)
tags: [risk, hotspots, contributors, historical]
---

# Phase 9: Risk Analysis Workflow

## Overview
Analyzes code hotspots and critical contributor patterns. Requires historical data and version control analysis.

## Tasks in This Phase

### Task 18: Hotspot Analysis
- **Prompt:** `[id:prompts_dir]onboard/prompts/identify-code-hotspot-patterns.md`
- **Output:** `identify-code-hotspot-patterns.md`
- **Python Script:** `hotspot_analyzer.py`
- **Description:** Identifies code hotspots, frequently changed files, and risk areas

### Task 28: Critical Contributors Analysis
- **Prompt:** `[id:prompts_dir]onboard/prompts/analyze-critical-contributor-impact.md`
- **Output:** `analyze-critical-contributor-impact.md`
- **Python Script:** `contributor_analyzer.py`
- **Description:** Identifies key contributors and knowledge concentration risks, and bus factor risks

## Execution Order
Sequential execution recommended:
1. Hotspot Analysis (identifies risk areas)
2. Critical Contributors Analysis (analyzes human factors)

## Dependencies
- Phase 1-8 complete (all previous analysis required)
- Historical data available (git history, commit logs)

## Success Criteria
- Code hotspots and risk areas identified
- Critical contributor dependencies analyzed
- Bus factor and knowledge concentration risks documented
- Risk mitigation recommendations provided

## Output Location
`[id:product_docs_dir]repo_name]/risk-analysis/`
