# Iterative Workflow Template

> **Note:** All files referenced below are either prompts located in `[id:prompts_dir]` or tools located in `[id:tools_dir]`, as specified in the memory map file.
> The solution to analyze is in [id:core_dir] and all new non-temporary created files are to be created in [id:findings_dir] folder.

# [WORKFLOW_NAME]: [WORKFLOW_DESCRIPTION]

## Workflow Type
Iterative - Repeats the same process until completion criteria are met with user authorization

## Workflow Overview
[Brief description of what this workflow accomplishes through iteration]

## Prerequisites
- [List any required conditions before starting]
- [Dependencies on other workflows or files]

## Input Requirements
- **Primary Input:** [Description of main input for first iteration]
- **Iteration State File:** `[descriptive-iteration-state-name].json`
- **Input Format:** JSON file containing iteration state and progress data

## Output Specifications
- **Iteration Output:** `[descriptive-iteration-output-name].json` (updated each iteration)
- **Final Output:** `[descriptive-final-output-name].json`
- **Progress Tracking:** `[descriptive-progress-tracking-name].json`
- **Output Location:** [id:findings_dir]

## Iteration Logic

### Iteration Step: [STEP_NAME]
- **Prompt/Tool:** `[id:prompts_dir][prompt-file-name].md` or `[id:tools_dir][tool-name].ps1`
- **Input:** 
  - First iteration: [Initial input]
  - Subsequent iterations: Output from previous iteration + `[iteration-state-file].json`
- **Output:** `[iteration-output-file].json`
- **Description:** [What each iteration does]
- **Validation:** [How to verify iteration completion]

## Completion Criteria
```json
{
  "completion_criteria": {
    "primary_condition": "[Main condition to check]",
    "secondary_conditions": [
      "[Additional condition 1]",
      "[Additional condition 2]"
    ],
    "max_iterations": [number],
    "success_threshold": "[Measurable threshold]"
  }
}
```

## User Authorization Process

### After Each Iteration:
1. **Present Results:** Display iteration output and current progress
2. **Provide Recommendation:** 
   - **Continue:** "[Reason to continue with next iteration]"
   - **Stop:** "[Reason to stop - completion achieved]"
   - **Modify:** "[Reason to adjust approach]"
3. **Request Authorization:** "Based on the analysis, I recommend [RECOMMENDATION]. Shall I proceed?"

### Recommendation Logic:
- **Continue if:** [Conditions that suggest more iterations needed]
- **Stop if:** [Conditions that suggest completion achieved]
- **Modify if:** [Conditions that suggest approach adjustment needed]

## Data Flow Diagram
```
[Initial Input] → [Iteration 1] → [Output 1] → [User Auth] → [Iteration 2] → [Output 2] → [User Auth] → ... → [Final Output]
                     ↑                            ↑                            ↑
               [State File]              [Updated State]              [Updated State]
```

## State Management
- **State File Format:** `[iteration-state-name].json`
```json
{
  "iteration_number": 1,
  "start_time": "2025-07-28T14:00:00Z",
  "current_status": "[status]",
  "previous_outputs": [
    {
      "iteration": 1,
      "output_file": "[file-name].json",
      "timestamp": "2025-07-28T14:00:00Z"
    }
  ],
  "completion_progress": {
    "criteria_met": ["[criterion1]"],
    "criteria_pending": ["[criterion2]"],
    "progress_percentage": 65
  }
}
```

## Error Handling
- **Iteration Failure:** [What to do if an iteration fails]
- **State Recovery:** [How to recover from corrupted state]
- **Rollback:** [How to return to previous iteration]

## Completion Actions
- [ ] All completion criteria met
- [ ] Final output validated
- [ ] State file archived
- [ ] [Additional completion actions]

## Next Steps
- [What happens after this workflow completes]
- [Which workflow to execute next, if any]
