# Sequential/Chained Workflow Template

> **Note:** All files referenced below are either prompts located in `[id:prompts_dir]reduce-code-complexity/` or tools located in `[id:tools_dir]reduce-code-complexity/`, as specified in the memory map file.
> The solution to analyze is in [id:core_dir] and all new non-temporary created files are to be created in [id:findings_dir]reduce-code-complexity/.

# 5-Analysis-Strategy Workflow: Strategic Refactoring Planning

## Workflow Type
Sequential/Chained - Each strategic planning step builds upon previous analysis and creates comprehensive refactoring strategy

## Workflow Overview
Transforms comprehensive quality analysis results into actionable refactoring strategies through risk assessment, impact analysis, and strategic prioritization to create implementable roadmap for complexity reduction.

## Prerequisites
- 4-Quality-Analysis workflow completed successfully with integrated complexity assessment
- Access to all quality analysis outputs (git history, complexity metrics, Halstead analysis)
- Write permissions to `[id:findingstrategy documents
- Understanding of project constraints and refactoring objectives

## Input Requirements
- **Primary Input:** ``4-quality-analysis-2-complexity-assessment.md` from 4-Quality-Analysis workflow
- **Secondary Inputs:** All quality analysis outputs and foundation report
- **Input Format:** Markdown analysis results and comprehensive quality assessments

## Output Specifications
- **Primary Output:** `5-analysis-strategy-2-implementation-strategy.md`
- **Secondary Outputs:** `5-analysis-strategy-1-prioritization-roadmap.md`
- **Output Location:** [id:findings_dir]reduce-code-complexity/

## Workflow Steps

### Step 1: Strategic Prioritization and Roadmap Planning
- **Prompt/Tool:** `[id:prompts_dir]reduce-code-complexity/5-analysis-strategy-1-prioritization-roadmap.md`
- **Input:** ``4-quality-analysis-2-complexity-assessment.md`
- **Output:** `5-analysis-strategy-1-prioritization-roadmap.md`
- **Description:** Create  prioritization roadmap balancing complexity reduction benefits against implementation risks, resource constraints, and business objectives to establish refactoring roadmap
- **Validation:** Verify prioritization considers multiple factors (complexity impact, risk level, resource requirements, business value) and provides clear sequencing for refactoring activities

### Step 2: Implementation Strategy and Resource Planning
- **Prompt/Tool:** `[id:prompts_dir]reduce-code-complexity/5-analysis-strategy-2-implementation-strategy.md`
- **Input:** `5-analysis-strategy-1-prioritization-roadmap.md`
- **Output:** `5-analysis-strategy-2-implementation-strategy.md`
- **Description:** Develop detailed and iterative implementation strategies for prioritized refactoring activities including resource allocation, timeline estimation, testing strategies, and success metrics
**CRITICAL:** The strategy must be iterative and small iterations allowing for incremental improvements.
- **Validation:** Verify implementation strategy includes detailed execution plans, resource requirements, timeline estimates, and measurable success criteria for each refactoring phase

## Data Flow Diagram
```
[Quality Analysis Results] → [Step 1: Strategic Prioritization] → [5-analysis-strategy-1-prioritization-roadmap.md] → [Step 2: Implementation Strategy] → [5-analysis-strategy-2-implementation-strategy.md] → [Complete Strategic Refactoring Plan]
```

## Error Handling
- **Step Failure:** Log detailed error information, assess impact on strategic planning completeness
- **Recovery:** Each strategy step can be restarted independently using preserved analysis data
- **Rollback:** No rollback needed as this is a planning process with no system modifications

## Completion Criteria
- [ ] All strategic planning steps completed successfully with comprehensive refactoring strategy
- [ ] Risk assessment covers all identified refactoring targets with mitigation strategies
- [ ] Strategic prioritization provides clear roadmap with resource and timeline estimates
- [ ] Implementation strategy includes detailed execution plans and success metrics
- [ ] Complete strategic refactoring plan ready for iterative implementation

## Next Steps
- Proceed to Sub-workflow 6: Refactoring (Iterative Implementation)
- Strategic refactoring plan provides foundation for iterative complexity reduction implementation
- Implementation strategy guides execution with clear priorities, timelines, and success metrics
