---
name: phase-7-standards-quality
description: Standards and quality workflow - code style, complexity analysis, dependency analysis, licensing
tags: [standards, quality, complexity, dependencies, licensing]
---

# Phase 7: Standards and Quality Workflow

## Overview
Analyzes code standards, complexity metrics, dependency management, and licensing compliance. Parallel execution possible for independent tasks.

## Tasks in This Phase

### Task 19: Code Style Analysis
- **Prompt:** `[id:prompts_dir]onboard/prompts/analyze-code-style-standards.md`
- **Output:** `analyze-code-style-standards.md`
- **Description:** Analyzes code formatting, style guides, and conventions, and consistency

### Task 19: Complexity Analysis
- **Prompt:** `[id:prompts_dir]onboard/prompts/analyze-cyclomatic-complexity-metrics.md`
- **Output:** `analyze-cyclomatic-complexity-metrics.md`
- **Python Script:** `complexity_analyzer.py`
- **Description:** Measures cyclomatic complexity and code quality metrics

### Task 21: Dependency Analysis
- **Prompt:** `[id:prompts_dir]onboard/prompts/analyze-dependency-management.md`
- **Output:** `analyze-dependency-management.md`
- **Description:** Analyzes dependency management and version control update strategies

### Task 22: Licensing and Legal Analysis
- **Prompt:** `[id:prompts_dir]onboard/prompts/analyze-licensing-legal-compliance.md`
- **Output:** `analyze-licensing-legal-compliance.md`
- **Description:** Analyzes licensing, legal compliance, and intellectual property considerations

## Execution Order
Parallel execution possible - all tasks can run independently

## Dependencies
- Phase 1-6 complete (foundation through security analysis required)

## Success Criteria
- Code style and formatting standards documented
- Complexity metrics and quality issues identified
- Dependency risks and management strategies analyzed
- Licensing compliance verified and documented

## Output Location
`[id:product_docs_dir]repo_name]/standards-quality/`
