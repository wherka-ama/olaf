# Sequential/Chained Workflow Template

> **Note:** All files referenced below are either prompts located in `[id:prompts_dir]` or tools located in `[id:tools_dir]`, as specified in the memory map file.
> The solution to analyze is in [id:core_dir] and all new non-temporary created files are to be created in [id:findingslder.

# 3-Discovery-Baselining-Consolidation Workflow: Comprehensive Project Foundation Report

## Workflow Type
Sequential/Chained - Single consolidation step that depends on outputs from previous workflows

## Workflow Overview
Consolidates findings from Discovery and Quality Baselining workflows into a comprehensive foundation report that provides a complete project profile and baseline for all subsequent analysis and refactoring activities.

## Prerequisites
- 1-Discovery workflow completed successfully with validated build process
- 2-Quality-Baselining workflow completed successfully with comprehensive quality baselines
- All discovery and baselining outputs validated and accessible
- Write permissions to `[id:findings_dir]reduce-code-complexity/` for output files

## Input Requirements
- **Primary Input:** all json output from 1-Discovery workflow
    - **Secondary Inputs:** all json output from 2-Quality-Baselining workflow
    - **Input Format:** JSON configuration and baseline data from previous workflows

## Output Specifications
- **Primary Output:** `3-discovery-baselining-consolidation-report.json`
- **Secondary Outputs:** `3-discovery-baselining-consolidation-report.md` (human-readable report)
- **Output Location:** [id:findings

## Workflow Steps

### Step 1: Foundation Consolidation and Reporting
- **Input:** `all previous json output from 1-Discovery workflow` + `all previous json output from 2-Quality-Baselining workflow`
- **Output:** `3-discovery-baselining-consolidation-report.json` + `3-discovery-baselining-consolidation-report.md`
- **Description:** Consolidate all discovery and baselining findings into comprehensive foundation report with project profile, build/test baseline, error inventory, and readiness assessment for quality analysis
- **Validation:** Verify consolidated report contains complete project foundation data and readiness indicators for subsequent workflows

## Data Flow Diagram
```
[Discovery Results] + [Quality Baselining Results] → [Foundation Consolidation] → [Consolidated Foundation Report] + [Summary Report]
```

## Error Handling
- **Step Failure:** Log detailed error information and assess completeness of available foundation data
- **Recovery:** Consolidation can be restarted with partial data if critical components are available
- **Rollback:** No rollback needed as this is a read-only consolidation process

## Completion Criteria
- [ ] All available discovery and baselining data successfully consolidated
- [ ] Foundation report validated for completeness and accuracy
- [ ] Human-readable summary report generated for stakeholder review
- [ ] Project readiness assessment completed for next phase workflows

## Next Steps
- Proceed to Sub-workflow 4: Quality Analysis
- Foundation report serves as comprehensive input for all subsequent analysis workflows
- Baseline data enables measurement and validation of improvement throughout refactoring process
