# Iterative Workflow Template

> **Note:** All files referenced below are either prompts located in `[id:prompts_dir]reduce-code-complexity` or tools located in `[id:tools_dir]reduce-code-complexity`, as specified in the memory map file.
> The solution to analyze is in [id:core_dir] and all new non-temporary created files are to be created in [id:findings_dir]reduce-code-complexity.

# 6-Refactoring Workflow: Iterative Complexity Reduction Implementation

## Workflow Type
Iterative - Repeated cycles of refactoring implementation with user authorization and recommendations after each iteration

## Workflow Overview
Implements the strategic refactoring plan through iterative cycles, executing prioritized complexity reduction activities with user authorization between cycles, progress validation, and continuous improvement based on implementation results.

## Prerequisites
- 5-Analysis-Strategy workflow completed successfully with comprehensive implementation strategy
- Access to complete strategic refactoring plan and implementation roadmap
- Development environment prepared with necessary tools and access permissions
- Team trained on refactoring patterns and implementation approach

## Input Requirements
- **Primary Input:** `5-analysis-strategy-2-implementation-strategy.md` from Analysis Strategy workflow
- **Secondary Inputs:** All previous analysis results and foundation data
- **Iteration State:** Current refactoring progress and iteration results
- **Input Format:** markdown implementation strategy and iteration state data

## Output Specifications
- **Primary Output:** `6-refactoring-iteration-{N}-results.json` for each iteration
- **Final Output:** `6-refactoring-final-results.json` with complete refactoring outcomes
- **Progress Tracking:** `6-refactoring-progress-tracker.json` maintained throughout iterations
- **Iteration State:** `6-refactoring-iteration-{N}-state.json` for each iteration state tracking
- **Output Location:** [id:findings_dir]reduce-code-complexity

## Iteration Configuration
- **Max Iterations:** 10 (configurable based on refactoring scope)
- **Iteration Duration:** 1-2 weeks per iteration (varies by complexity)
- **Success Threshold:** 80% of planned complexity reduction achieved
- **Failure Threshold:** 3 consecutive iterations with <20% progress

## Initial State Setup

Follow template structure: `[id:templates_dir]reduce-code-complexity/iteration-state.json`

The initial iteration state should be created as `6-refactoring-iteration-0-state.json` using the template with the following example values:
- **iteration_number**: 0 (starting iteration)
- **total_refactoring_targets**: Total number of targets from implementation strategy
- **completed_targets**: 0 (no targets completed initially)
- **current_phase**: "Phase 1: Quick Wins" (or appropriate phase from implementation strategy)
- **overall_progress**: 0 (no progress initially)
- **implementation_strategy_source**: Reference to the implementation strategy file
- **next_targets**: First set of targets to be addressed
- **team_readiness**: "confirmed" or current team readiness status
- **environment_ready**: "pending_validation" or current environment status

Replace all placeholder values (enclosed in square brackets) with actual iteration state data based on the implementation strategy and current project status.
```

## Iteration Logic

### Pre-Iteration Setup
1. **Iteration Planning**: Load implementation strategy and determine next refactoring targets
2. **Resource Validation**: Confirm team availability and required tools/environment
3. **Risk Assessment**: Review current system state and potential iteration risks
4. **Progress Baseline**: Establish baseline metrics for iteration success measurement

### Iteration Execution Steps

#### Step 1: Code Analysis and Refactoring Implementation
- **Prompt/Tool:** `[id:prompts_dir]reduce-code-complexity/6-refactoring-1-implementation.md`
- **Input:** Target preparation results + implementation strategy
- **Output:** `6-refactoring-2-implementation.json`
- **Description:** Execute refactoring implementation using defined patterns and techniques with comprehensive testing

### Iteration Success Criteria
- [ ] All planned refactoring targets for iteration completed successfully
- [ ] Measurable complexity reduction achieved (minimum 15% per iteration)
- [ ] All tests passing with no functional regressions


### Iteration Failure Criteria
- [ ] Critical system failures or regressions introduced
- [ ] Less than 10% complexity reduction achieved
- [ ] Major blockers preventing target completion
- [ ] Significant timeline overruns (>50% of planned iteration duration)

## User Authorization Points

### Between Each Iteration
**Authorization Request Format:**
```
## Iteration {N} Completion Report

### Achievements:
- Completed targets: {target_list}
- Complexity reduction: {percentage}%
- Quality improvements: {metrics}

### Next Iteration Plan:
- Planned targets: {next_target_list}
- Estimated effort: {effort_estimate}
- Expected outcomes: {expected_results}

### Recommendations:
- Continue with planned targets
- Adjust scope based on current progress
- Address any identified risks or blockers

**Authorization Request:** Proceed with Iteration {N+1}? [Yes/No/Modify]
```

### Critical Decision Points
1. **Phase Transitions**: When moving between implementation iterations (Quick Wins → Critical Components → Strategic Enhancements)
2. **Scope Adjustments**: When significant changes to refactoring scope are needed
3. **Risk Escalation**: When high-risk issues require stakeholder decision
4. **Resource Reallocation**: When team capacity or timeline constraints require adjustment

## Progress Tracking
- **Iteration Progress**: Track completion of refactoring targets per iteration
- **Complexity Metrics**: Continuous monitoring of cyclomatic complexity, Halstead metrics, and code quality
- **Quality Indicators**: Bug rates, test coverage, performance metrics
- **Team Velocity**: Development speed and team satisfaction metrics

## Completion Conditions

### Successful Completion
- All high-priority refactoring targets completed
- Overall complexity reduction target achieved (≥40%)
- System stability and performance maintained
- Team processes and documentation updated

### Early Termination Conditions
- Critical system stability issues requiring immediate halt
- Resource constraints preventing continuation
- Business priority changes requiring scope adjustment
- Technical blockers that cannot be resolved within reasonable timeframe

## Final Outputs
- **Comprehensive Results**: Complete refactoring outcomes with before/after metrics
- **Lessons Learned**: Documentation of successful patterns and challenges encountered
- **Maintenance Guide**: Ongoing practices to prevent complexity regression
- **Team Knowledge**: Updated processes and enhanced team capabilities

## Error Handling
- **Iteration Failures**: Rollback to previous stable state, analyze root cause, adjust approach
- **System Regressions**: Immediate rollback procedures, root cause analysis, mitigation strategies
- **Resource Issues**: Scope adjustment, timeline extension, or resource reallocation
- **Technical Blockers**: Escalation procedures, alternative approach evaluation, expert consultation

## Next Steps
- Implementation complete - conduct final evaluation and documentation
- Establish ongoing complexity monitoring and prevention practices
- Plan future refactoring iterations based on evolving system needs
- Knowledge transfer and process improvement recommendations
