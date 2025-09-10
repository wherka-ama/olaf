---
name: phase-1-foundation
description: Foundation analysis workflow - workspace content, repo classification, language analysis, size metrics
tags: [foundation, workspace, classification, metrics]
---

# Phase 1: Foundation Analysis Workflow

## Overview
Foundation phase that must execute first. Establishes baseline understanding of the repository structure, application types, programming languages, and size metrics.

## Tasks in This Phase

### Task 1: Workspace Content Analysis
- **Prompt:** `[id:prompts_dir]common/prompts/analyze-workspace-content-structure.md`
- **Output:** `analyze-workspace-content-structure.md`
- **Python Script:** `workspace_content_analyzer.py`
- **Description:** Analyzes directory structure, file organization, and content patterns

### Task 2: Repository Application Classification
- **Prompt:** `[id:prompts_dir]common/prompts/classify-repo-application-types.md`
- **Output:** `classify-repo-application-types.md`
- **Description:** Identifies application types, frameworks, and architectural patterns

### Task 3: Programming Language Analysis
- **Prompt:** `[id:prompts_dir]common/prompts/analyze-repo-language-distribution.md`
- **Output:** `analyze-repo-language-distribution.md`
- **Python Script:** `language_distribution_analyzer.py`
- **Description:** Analyzes language distribution, file counts, and code metrics

### Task 4: Repository Size Metrics
- **Prompt:** `[id:prompts_dir]common/prompts/measure-repo-size-metrics.md`
- **Output:** `measure-repo-size-metrics.md`
- **Python Script:** `repo_size_metrics_calculator.py`
- **Description:** Calculates repository size, file counts, and growth metrics

## Execution Order
Sequential execution required:
1. Workspace Content Analysis (establishes baseline)
2. Repository Application Classification (builds on workspace understanding)
3. Programming Language Analysis (requires file structure knowledge)
4. Repository Size Metrics (comprehensive metrics calculation)

## Dependencies
- None (this is the foundation phase)

## Success Criteria
- All 4 foundation analysis documents generated
- Repository structure and content clearly documented
- Application type and language distribution identified
- Size and complexity metrics established

## Output Location
`[id:product_docs_dir]repo_name]/foundation/`
