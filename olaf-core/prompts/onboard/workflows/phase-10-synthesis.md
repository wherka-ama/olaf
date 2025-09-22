---
name: phase-10-synthesis
description: Synthesis workflow - business domain synthesis, final consolidation (final phase)
tags: [synthesis, business-domain, consolidation, final]
---

# Phase 10: Synthesis Workflow

## Overview
Final phase that synthesizes all analysis results into comprehensive project overview and business domain understanding.

## Tasks in This Phase

### Task 27: Business Domain Synthesis
- **Prompt:** `[id:prompts_dir]onboard/prompts/synthesize-business-domain-context.md`
- **Output:** `synthesize-business-domain-context.md`
- **Description:** Synthesizes business domain context from all previous analyses

### Final Consolidation: Product Overview Generation
- **Process:** Built-in consolidation logic
- **Output:** `product-overview.md`
- **Description:** Consolidates all analysis documents into comprehensive project overview
- **Input:** All analysis documents from phases 1-9

## Execution Order
Sequential execution required:
1. Business Domain Synthesis (analyzes business context)
2. Final Consolidation (creates comprehensive overview)

## Dependencies
- All phases 1-9 complete (requires all analysis documents)

## Success Criteria
- Business domain context clearly synthesized
- Comprehensive product overview generated
- All analysis results consolidated and summarized
- Actionable insights and recommendations provided

## Output Location
`[id:product_docs_dir]repo_name]/synthesis/`
Final `product-overview.md` in root: `[id:product_docs_dir]repo_name]/`
