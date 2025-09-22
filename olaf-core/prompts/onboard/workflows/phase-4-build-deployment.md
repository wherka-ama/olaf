---
name: phase-4-build-deployment
description: Build and deployment workflow - build process, CI/CD, deployment strategy, infrastructure analysis
tags: [build, deployment, cicd, infrastructure]
---

# Phase 4: Build and Deployment Workflow

## Overview
Analyzes build processes, CI/CD pipelines, deployment strategies, and infrastructure patterns.

## Tasks in This Phase

### Task 10: Local Build Process Analysis
- **Prompt:** `[id:prompts_dir]onboard/prompts/document-local-build-process.md`
- **Output:** `document-local-build-process.md`
- **Description:** Documents local development and build processes

### Task 11: CI/CD Pipeline Analysis
- **Prompt:** `[id:prompts_dir]onboard/prompts/analyze-cicd-pipeline-setup.md`
- **Output:** `analyze-cicd-pipeline-setup.md`
- **Description:** Analyzes continuous integration and deployment pipelines

### Task 12: Deployment Strategy Analysis
- **Prompt:** `[id:prompts_dir]onboard/prompts/analyze-deployment-strategy-methods.md`
- **Output:** `analyze-deployment-strategy-methods.md`
- **Description:** Documents deployment methods and strategies

### Task 24: Infrastructure as Code Analysis
- **Prompt:** `[id:prompts_dir]onboard/prompts/analyze-infrastructure-code-patterns.md`
- **Output:** `analyze-infrastructure-code-patterns.md`
- **Description:** Analyzes infrastructure automation and patterns

## Execution Order
Sequential execution recommended:
1. Local Build Process (establishes baseline)
2. CI/CD Pipeline Analysis (builds on local process)
3. Deployment Strategy Analysis (requires CI/CD understanding)
4. Infrastructure as Code Analysis (comprehensive infrastructure view)

## Dependencies
- Phase 1-3 complete (foundation, technology, and testing analysis required)

## Success Criteria
- Build processes clearly documented
- CI/CD pipelines mapped and analyzed
- Deployment strategies identified
- Infrastructure patterns documented

## Output Location
`[id:product_docs_dir]repo_name]/build-deployment/`
