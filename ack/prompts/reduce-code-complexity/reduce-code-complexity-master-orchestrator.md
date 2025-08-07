# Master/Orchestrator Workflow Template

> **Note:** All files referenced below are either prompts located in `[id:prompts_dir]` or tools located in `[id:tools_dir]`, as specified in the memory map file.
> The solution to analyze is in [id:core_dir] and all new non-temporary created files are to be created in [id:findings_dir] folder.

# Reduce Code Complexity Master Orchestrator

## Workflow Type
Master/Orchestrator - Coordinates complete sub-workflows and prompts with data flow management, progress tracking, and error recovery

## Workflow Overview
Orchestrates comprehensive code complexity reduction through six integrated sub-workflows, managing data flow between workflows, tracking progress, handling errors, and ensuring systematic approach to complexity reduction with measurable outcomes.

## Prerequisites
- Access to target codebase in `[id:core_dir]`
- Write permissions to `[id:findings_dir]` for all analysis and results
- Development environment with required tools and dependencies
- Team availability for refactoring activities

## Sub-Workflow Definitions

### Sub-workflow 1: Discovery
- **Workflow File:** `[id:prompts_dir]reduce-code-complexity/1-discovery-workflow.md`
- **Type:** Sequential
- **Purpose:** Project type detection, environment setup, and build execution
- **Input:** Project path and basic configuration
- **Output:** `1-discovery-results.json` - Project foundation and build status
- **Dependencies:** None (entry point)

### Sub-workflow 2: Quality Baselining
- **Workflow File:** `[id:prompts_dir]reduce-code-complexity/2-quality-baselining-workflow.md`
- **Type:** Sequential
- **Purpose:** Establish error baselines, setup testing, and create test baselines
- **Input:** `1-discovery-results.json`
- **Output:** `2-quality-baselining-results.json` - Quality and test baselines
- **Dependencies:** Sub-workflow 1 (Discovery)

### Sub-workflow 3: Discovery Baselining Consolidation
- **Workflow File:** `[id:prompts_dir]reduce-code-complexity/3-discovery-baselining-consolidation-workflow.md`
- **Type:** Sequential
- **Purpose:** Consolidate discovery and quality baselining into comprehensive foundation
- **Input:** all json output from 1-Discovery workflow + all json output from 2-Quality-Baselining workflow
- **Output:** `3-discovery-baselining-consolidation-report.json` - Foundation report
- **Dependencies:** Sub-workflows 1 and 2

### Sub-workflow 4: Quality Analysis
- **Workflow File:** `[id:prompts_dir]reduce-code-complexity/4-quality-analysis-workflow.md`
- **Type:** Sequential
- **Purpose:** Git history analysis, complexity assessment, and Halstead metrics
- **Input:** `3-discovery-baselining-consolidation-report.json`
- **Output:** `4-quality-analysis-2-complexity-assessment.json` - Integrated quality analysis
- **Dependencies:** Sub-workflow 3

### Sub-workflow 5: Analysis Strategy
- **Workflow File:** `[id:prompts_dir]reduce-code-complexity/5-analysis-strategy-workflow.md`
- **Type:** Sequential
- **Purpose:** Risk assessment, prioritization, and implementation strategy
- **Input:** `4-quality-analysis-2-complexity-assessment.json`
- **Output:** `5-analysis-strategy-2-implementation-strategy.md` - Strategic refactoring plan
- **Dependencies:** Sub-workflow 4

### Sub-workflow 6: Refactoring
- **Workflow File:** `[id:prompts_dir]reduce-code-complexity/6-refactoring-workflow.md`
- **Type:** Iterative
- **Purpose:** Iterative refactoring implementation with user authorization
- **Input:** `5-analysis-strategy-2-implementation-strategy.md`
- **Output:** `6-refactoring-final-results.json` - Complete refactoring outcomes
- **Dependencies:** Sub-workflow 5

### Sub-workflow 7: Final Consolidation
- **Workflow File:** `[id:prompts_dir]reduce-code-complexity/7-final-consolidation.md`
- **Type:** Sequential
- **Purpose:** Generate comprehensive final report consolidating all workflow outputs
- **Input:** All outputs from Sub-workflows 1-6 + orchestrator state
- **Output:** `reduce-code-complexity-final-results.md` - Comprehensive final report
- **Dependencies:** Sub-workflows 1-6

## Data Flow Management

### Data Flow Diagram
```
[Project Input] → [1-Discovery] → [1-discovery-results.json] → [2-Quality-Baselining] → [2-quality-baselining-results.json] → [3-Discovery-Baselining-Consolidation] → [3-discovery-baselining-consolidation-report.json] → [4-Quality-Analysis] → [4-quality-analysis-3-halstead-metrics.json] → [5-Analysis-Strategy] → [5-analysis-strategy-3-implementation-strategy.md] → [6-Refactoring] → [6-refactoring-final-results.json] → [7-Final-Consolidation] → [reduce-code-complexity-final-results.md]
```

### Data Validation Points
1. **Discovery to Quality Baselining:** Validate project setup and build success
2. **Quality Baselining to Consolidation:** Validate error and test baselines established
3. **Consolidation to Quality Analysis:** Validate comprehensive foundation report
4. **Quality Analysis to Strategy:** Validate integrated complexity analysis
5. **Strategy to Refactoring:** Validate strategic implementation plan
6. **Refactoring to Final Consolidation:** Validate complete refactoring outcomes
7. **Final Consolidation Completion:** Validate comprehensive final report and project completion

### Data Dependencies
- Sub-workflow 2 requires successful completion of Sub-workflow 1
- Sub-workflow 3 requires successful completion of Sub-workflows 1 and 2
- Sub-workflow 4 requires successful completion of Sub-workflow 3
- Sub-workflow 5 requires successful completion of Sub-workflow 4
- Sub-workflow 6 requires successful completion of Sub-workflow 5
- Sub-workflow 7 requires successful completion of Sub-workflows 1-6

## Progress Tracking

### Workflow State Management

Follow template structure: `[id:templates_dir]reduce-code-complexity/orchestrator-state.md`

The orchestrator state should be maintained as `reduce-code-complexity-current-state.md` in the `[id:findings_dir]reduce-code-complexity/` directory, following the markdown structure defined in the template. Replace all placeholder values (enclosed in square brackets) with actual orchestrator state data, workflow progress, and execution status.

The state file should be updated after each workflow completion and at key progress milestones to maintain accurate tracking of the overall orchestration process.

### Progress Milestones
- **Milestone 1:** Discovery workflow completed - Project foundation established
- **Milestone 2:** Quality baselining completed - Error and test baselines established
- **Milestone 3:** Foundation consolidation completed - Comprehensive foundation report created
- **Milestone 4:** Quality analysis completed - Integrated complexity analysis available
- **Milestone 5:** Strategic planning completed - Implementation roadmap established
- **Milestone 6:** Refactoring completed - Complexity reduction objectives achieved
- **Milestone 7:** Final consolidation completed - Comprehensive final report and project documentation available

## Error Handling and Recovery

### Error Categories
1. **Workflow Execution Errors:** Sub-workflow fails to complete successfully
2. **Data Validation Errors:** Output data doesn't meet validation criteria
3. **Dependency Errors:** Required inputs not available or invalid
4. **System Errors:** Environment or tooling issues preventing execution

### Recovery Strategies
- **Workflow Restart:** Restart failed sub-workflow with corrected inputs
- **Data Repair:** Fix data validation issues and continue from validation point
- **Dependency Resolution:** Resolve missing dependencies and retry
- **Manual Intervention:** Escalate to user for manual resolution when automated recovery fails

### Rollback Procedures
- **Workflow-Level Rollback:** Return to previous successfully completed sub-workflow
- **Data-Level Rollback:** Restore previous valid data state
- **Full Rollback:** Return to initial state and restart entire orchestration

## User Interaction Points

### Required User Authorization
1. **Workflow Initiation:** User confirms project path and objectives
2. **Phase Transitions:** User authorizes progression between major phases
3. **Refactoring Iterations:** User authorizes each refactoring iteration cycle
4. **Critical Decisions:** User resolves high-impact issues or scope changes
5. **Completion Approval:** User approves final results and completion

### User Authorization Format
```
## Workflow Authorization Request

### Current Status:
- Completed: {completed_workflows}
- Current: {current_workflow}
- Progress: {overall_progress}%

### Next Action:
- Workflow: {next_workflow}
- Purpose: {workflow_purpose}
- Expected Duration: {estimated_duration}
- Expected Outcomes: {expected_outcomes}

**Authorization Required:** Proceed with {next_workflow}? [Approve/Reject/Modify]
```

## Orchestration Logic

### Execution Flow
1. **Initialize:** Set up orchestrator state and validate prerequisites
2. **Execute Discovery:** Run Sub-workflow 1 and validate results
3. **Execute Quality Baselining:** Run Sub-workflow 2 and validate results
4. **Execute Consolidation:** Run Sub-workflow 3 and validate results
5. **Execute Quality Analysis:** Run Sub-workflow 4 and validate results
6. **Execute Strategy Planning:** Run Sub-workflow 5 and validate results
7. **Execute Refactoring:** Run Sub-workflow 6 with iterative user authorization
8. **Execute Final Consolidation:** Run Sub-workflow 7 to generate comprehensive final report
9. **Finalize:** Complete orchestration with final validation and project closure

### Validation Logic
- Validate each sub-workflow output against expected schema
- Confirm data dependencies are satisfied before proceeding
- Verify system state and stability between workflows
- Ensure user authorization requirements are met

### Coordination Logic
- Manage data flow between sub-workflows
- Track progress and update state throughout execution
- Handle errors and implement recovery strategies
- Coordinate user interaction and authorization points

## Success Criteria
- [ ] All seven sub-workflows completed successfully
- [ ] Data flow validated at each transition point
- [ ] User authorization obtained for all required decision points
- [ ] Final complexity reduction objectives achieved
- [ ] System stability maintained throughout process
- [ ] Complete documentation and comprehensive final report available

## Completion Outputs
- **Final Results:** `reduce-code-complexity-final-results.md` (comprehensive markdown report)
- **Orchestrator State:** `reduce-code-complexity-current-state.md` (maintained throughout execution)
- **Process Documentation:** Complete execution log and workflow history
- **Quality Metrics:** Before/after complexity measurements and improvements
- **Recommendations:** Future maintenance and complexity prevention strategies

## Next Steps
- Analyze final results and measure success against original objectives
- Implement ongoing complexity monitoring and prevention practices
- Document lessons learned and process improvements
- Plan future complexity reduction iterations based on evolving needs
