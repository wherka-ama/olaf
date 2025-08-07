---
name: orchestrate-comprehensive-codebase-benchmark
description: Master benchmark orchestrator that executes multiple workflow chains on a single codebase for comprehensive system validation and comparative analysis
tags: [benchmark, orchestrator, validation, testing, comprehensive-analysis, system-health]
---

# Comprehensive Codebase Assessment Suite (Benchmark Orchestrator)

## Workflow Type
Master/Orchestrator - Executes multiple complete workflow chains for comprehensive system validation

## Workflow Overview
Provides comprehensive system validation by executing business analysis, code quality assessment, troubleshooting, and knowledge management workflows on a single codebase, generating comparative metrics and quality assessments for system benchmarking.

## Prerequisites
- Access to target codebase for comprehensive analysis
- Log files for troubleshooting workflow testing
- PowerShell execution permissions for script-based workflows
- Sufficient time allocation (estimated 2-4 hours for complete benchmark)

## Input Requirements
- **Primary Input:** Target codebase path and project context
- **Configuration Input:** Benchmark scope, comparison baseline, quality thresholds
- **Agent Metadata:** Agent version name, model name/version being used for benchmark execution
- **Input Format:** Codebase path, project description, agent/model identifiers, historical benchmark data (optional)

## Output Specifications
- **Orchestrator Log:** `benchmark-orchestrator-log-YYYYMMDD-NNN.json`
- **Benchmark Report:** `comprehensive-benchmark-report-YYYYMMDD-NNN.md`
- **Comparative Analysis:** `benchmark-comparison-YYYYMMDD-NNN.json`
- **Individual Workflow Outputs:** All sub-workflow results preserved
- **Output Location:** [id:findings_dir]benchmark-YYYYMMDD-NNN/

## Benchmark Workflow Chain

### Phase 1: Discovery & Baseline Assessment
#### Sub-Workflow 1A: Project Structure Analysis
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]architect/analyze-technical-stack.md`
- **Input Requirements:** Codebase path, project context
- **Output Produced:** `project-structure-analysis-YYYYMMDD-NNN.md`
- **Metrics Tracked:** Discovery time, component identification accuracy
- **Success Criteria:** Complete project structure documented with technology stack

#### Sub-Workflow 1B: Codebase Risk Assessment
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]other-users/analyze-codebase-risk.md`
- **Input Requirements:** Codebase path and technical stack from Sub-Workflow 1A
- **Output Produced:** `codebase-risk-baseline-YYYYMMDD-NNN.md`
- **Metrics Tracked:** Risk identification completeness, vulnerability assessment accuracy
- **Success Criteria:** Comprehensive risk assessment with security and maintainability overview

#### Sub-Workflow 1C: Business Requirements Baseline
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]business-analyst/analyze-business-requirements.md`
- **Input Requirements:** Codebase analysis from previous sub-workflows
- **Output Produced:** `business-requirements-baseline-YYYYMMDD-NNN.md`
- **Metrics Tracked:** Requirements identification completeness, stakeholder mapping accuracy
- **Success Criteria:** Baseline business requirements documented for comparison

### Phase 2: Business Analysis Pipeline Validation
#### Sub-Workflow 2: Complete Business Assessment
- **Type:** Orchestrator
- **Prompt/Workflow:** `[id:prompts_dir]other-users/orchestrate-project-assessment-pipeline.md`
- **Input Requirements:** Project context and codebase from Phase 1
- **Output Produced:** Complete business analysis pipeline results
- **Metrics Tracked:** 
  - Pipeline execution time
  - Requirements completeness score
  - Functional specification quality
  - Test plan coverage metrics
  - Stakeholder satisfaction simulation
- **Success Criteria:** All pipeline phases complete with quality gates passed
- **Benchmark Validation:** Compares against previous business analysis runs

### Phase 3: Code Quality Assessment Suite
#### Sub-Workflow 3A: Multi-File Code Review
- **Type:** Sequential (Multiple Files)
- **Prompt/Workflow:** `[id:prompts_dir]developer/review-code.md`
- **Input Requirements:** Representative code files from different modules
- **Output Produced:** `code-review-comprehensive-YYYYMMDD-NNN.md`
- **Metrics Tracked:**
  - Review thoroughness score
  - Issues identified per file type
  - Security vulnerability detection rate
  - Code quality improvement suggestions
- **Success Criteria:** Comprehensive review of core system components

#### Sub-Workflow 3B: Codebase Risk Analysis
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]other-users/analyze-codebase-risk.md`
- **Input Requirements:** Complete codebase and review results from 3A
- **Output Produced:** `codebase-risk-assessment-YYYYMMDD-NNN.md`
- **Metrics Tracked:**
  - Risk identification accuracy
  - Mitigation strategy quality
  - Business impact assessment precision
- **Success Criteria:** Complete risk profile with actionable mitigation strategies

### Phase 4: Troubleshooting Workflow Validation
#### Sub-Workflow 4: Log Analysis & Troubleshooting
- **Type:** Orchestrator
- **Prompt/Workflow:** `[id:prompts_dir]troubleshooting/orchestrate-log-troubleshooting-workflow.md`
- **Input Requirements:** Historical log files and codebase from Phase 1
- **Output Produced:** Complete troubleshooting analysis results
- **Metrics Tracked:**
  - Log parsing accuracy
  - Issue prioritization effectiveness
  - Source mapping precision
  - Root cause identification success rate
  - Resolution recommendation quality
- **Success Criteria:** Successful correlation of log issues to source code with actionable fixes
- **Benchmark Validation:** Measures troubleshooting efficiency improvements

### Phase 5: Knowledge Management & Documentation
#### Sub-Workflow 5A: Expert Contact Analysis
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]other-users/find-expert-contact.md`
- **Input Requirements:** Various expertise queries based on findings from previous phases
- **Output Produced:** `expert-contact-analysis-YYYYMMDD-NNN.md`
- **Metrics Tracked:**
  - Contact recommendation accuracy
  - Expertise matching precision
  - Response completeness score
- **Success Criteria:** Accurate contact recommendations for identified technical areas

#### Sub-Workflow 5B: Decision Record Generation
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]project-manager/create-decision-record.md`
- **Input Requirements:** Key architectural decisions identified throughout benchmark
- **Output Produced:** `benchmark-decision-records-YYYYMMDD-NNN.md`
- **Metrics Tracked:**
  - Decision documentation completeness
  - Template compliance score
  - Rationale quality assessment
- **Success Criteria:** Comprehensive decision documentation with proper formatting

#### Sub-Workflow 5C: Comprehensive Documentation
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]business-analyst/bootstrap-functional-spec-from-code.md`
- **Input Requirements:** All analysis results from previous phases
- **Output Produced:** `comprehensive-system-documentation-YYYYMMDD-NNN.md`
- **Metrics Tracked:**
  - Documentation completeness score
  - Cross-reference accuracy
  - Stakeholder value assessment
- **Success Criteria:** Complete system documentation integrating all workflow findings

## Benchmark Metrics Framework

### Execution Metrics
```json
{
  "total_execution_time": "duration_in_minutes",
  "phase_timings": {
    "discovery_baseline": "minutes",
    "business_analysis": "minutes", 
    "code_quality": "minutes",
    "troubleshooting": "minutes",
    "knowledge_management": "minutes"
  },
  "resource_utilization": {
    "files_analyzed": "count",
    "scripts_executed": "count",
    "templates_used": "count",
    "prompts_invoked": "count"
  }
}
```

### Quality Scores
```json
{
  "overall_quality_score": "0-100",
  "workflow_scores": {
    "business_analysis": "0-100",
    "code_quality": "0-100", 
    "troubleshooting": "0-100",
    "documentation": "0-100"
  },
  "template_compliance": "0-100",
  "cross_workflow_consistency": "0-100",
  "output_completeness": "0-100"
}
```

### Comparative Analysis
```json
{
  "benchmark_id": "YYYYMMDD-NNN",
  "baseline_comparison": {
    "performance_delta": "percentage_change",
    "quality_improvement": "score_difference",
    "consistency_trend": "improving|stable|degrading"
  },
  "regression_detection": {
    "workflow_regressions": ["list_of_degraded_workflows"],
    "quality_regressions": ["list_of_quality_issues"],
    "performance_regressions": ["list_of_slowdowns"]
  }
}
```

## Orchestrator Execution Steps

### Step 1: Benchmark Initialization
1. Collect agent metadata from user:
   - Agent version name (e.g., "Cascade v2.1", "Custom Agent v3.0")
   - Model name and version (e.g., "Claude-3.5-Sonnet", "GPT-4", "Custom-Model-v2.3")
   - Execution environment details
2. Create benchmark session directory structure
3. Initialize metrics tracking system with agent metadata
4. Validate all prerequisite conditions
5. Create baseline timestamp and configuration including agent/model information
6. User approval checkpoint: "Agent metadata collected. Begin comprehensive benchmark execution?"

### Step 2: Phase 1 - Discovery & Baseline (Sequential)
1. Execute project structure analysis
2. Run technical stack assessment  
3. Generate complexity baseline
4. Consolidate discovery metrics
5. User approval checkpoint: "Discovery complete. Proceed to business analysis?"

### Step 3: Phase 2 - Business Analysis Validation (Orchestrated)
1. Launch complete business assessment pipeline
2. Monitor execution and collect metrics
3. Validate quality gates and completion criteria
4. Store pipeline results and performance data
5. User approval checkpoint: "Business analysis complete. Proceed to code quality assessment?"

### Step 4: Phase 3 - Code Quality Assessment (Parallel/Sequential)
1. Execute multi-file code review workflow
2. Run comprehensive codebase risk analysis
3. Correlate findings across quality workflows
4. Generate consolidated quality assessment
5. User approval checkpoint: "Code quality assessment complete. Proceed to troubleshooting validation?"

### Step 5: Phase 4 - Troubleshooting Validation (Orchestrated)
1. Launch log troubleshooting workflow with test data
2. Measure mapping accuracy and resolution effectiveness
3. Validate troubleshooting methodology performance
4. Document troubleshooting capabilities assessment
5. User approval checkpoint: "Troubleshooting validation complete. Proceed to knowledge management?"

### Step 6: Phase 5 - Knowledge Management (Sequential)
1. Execute expert contact analysis with test queries
2. Generate decision records for key findings
3. Create comprehensive system documentation
4. Validate documentation quality and completeness
5. User approval checkpoint: "Knowledge management complete. Generate final benchmark report?"

### Step 7: Benchmark Consolidation & Reporting
1. Aggregate all workflow outputs and metrics
2. Calculate comparative scores against baselines
3. Generate comprehensive benchmark report
4. Create comparative analysis with previous runs
5. Archive benchmark session for future comparisons

## Quality Gates & Validation

### Phase Completion Criteria
- **Discovery Phase:** 100% project structure mapped, technical stack identified
- **Business Analysis:** All pipeline phases completed with stakeholder validation
- **Code Quality:** Critical issues identified, security vulnerabilities assessed
- **Troubleshooting:** Log-to-source mapping achieved, root causes identified
- **Knowledge Management:** Expert contacts mapped, documentation generated

### Cross-Workflow Validation
- **Data Consistency:** Technical findings consistent across workflows
- **Template Compliance:** All outputs follow standardized templates
- **Quality Thresholds:** Minimum quality scores achieved for each workflow type
- **Integration Validation:** Workflow outputs properly reference each other

## Comparative Analysis Features

### Trend Analysis
- **Performance Trends:** Execution time improvements/degradations over benchmark runs
- **Quality Trends:** Output quality evolution across multiple benchmark executions
- **Consistency Trends:** Template compliance and standardization improvements

### Regression Detection
- **Workflow Regressions:** Identification of workflows performing worse than baseline
- **Quality Regressions:** Detection of declining output quality or completeness
- **Performance Regressions:** Recognition of execution time degradations

### Improvement Recommendations
- **Workflow Optimizations:** Suggestions for improving underperforming workflows
- **Quality Enhancements:** Recommendations for improving output quality scores
- **System Health:** Overall ecosystem health assessment and improvement strategies

## Success Metrics

### System Validation Success
- **Comprehensive Coverage:** All major workflow types successfully executed
- **Quality Thresholds:** Minimum quality scores achieved across all workflows
- **Integration Success:** Workflows properly integrate and reference each other
- **Template Compliance:** All outputs follow standardized formatting

### Benchmark Effectiveness
- **Reproducibility:** Consistent results across multiple benchmark runs
- **Comparative Value:** Clear metrics for measuring system improvements
- **Regression Detection:** Successful identification of system degradations
- **Actionable Insights:** Clear recommendations for system improvements

## Follow-up Actions
- **Performance Optimization:** Address identified workflow bottlenecks
- **Quality Improvements:** Enhance workflows with low quality scores
- **System Integration:** Improve cross-workflow data consistency
- **Documentation Updates:** Update templates and workflows based on findings
- **Continuous Monitoring:** Schedule regular benchmark executions for system health

## Integration Points
- **All Major Workflows:** Integrates business analysis, code quality, troubleshooting, and knowledge management
- **Script Ecosystem:** Utilizes PowerShell scripts for automated analysis components
- **Template System:** Validates template compliance across all workflow outputs
- **Competency Index:** Validates workflow discoverability and routing effectiveness
