# Sequential/Chained Workflow Template

> **Note:** All files referenced below are either prompts located in `[id:prompts_dir]` or tools located in `[id:tools_dir]`, as specified in the memory map file.
> The solution to analyze is in [id:core_dir] and all new non-temporary created files are to be created in [id:findings_dir] folder.

# [WORKFLOW_NAME]: [WORKFLOW_DESCRIPTION]

## Workflow Type
Sequential/Chained - Each step depends on the output of the previous step

## Workflow Overview
[Brief description of what this workflow accomplishes]

## Prerequisites
- [List any required conditions before starting]
- [Dependencies on other workflows or files]

## Input Requirements
- **Primary Input:** [Description of main input]
- **Secondary Inputs:** [Optional additional inputs]
- **Input Format:** [File format, data structure, etc.]

## Output Specifications
- **Primary Output:** [Main output file/result]
- **Secondary Outputs:** [Additional outputs if any]
- **Output Location:** [Where outputs are stored]

## Workflow Steps

### Step 1: [STEP_NAME]
- **Prompt/Tool:** `[id:prompts_dir][prompt-file-name].md` or `[id:tools_dir][tool-name].ps1`
- **Input:** [What this step consumes]
- **Output:** [What this step produces]
- **Description:** [What this step does]
- **Validation:** [How to verify step completion]

### Step 2: [STEP_NAME]
- **Prompt/Tool:** `[id:prompts_dir][prompt-file-name].md` or `[id:tools_dir][tool-name].ps1`
- **Input:** [Output from Step 1 + any additional inputs]
- **Output:** [What this step produces]
- **Description:** [What this step does]
- **Validation:** [How to verify step completion]

### Step N: [STEP_NAME]
- **Prompt/Tool:** `[id:prompts_dir][prompt-file-name].md` or `[id:tools_dir][tool-name].ps1`
- **Input:** [Output from Step N-1 + any additional inputs]
- **Output:** [Final workflow output]
- **Description:** [What this step does]
- **Validation:** [How to verify step completion]

## Data Flow Diagram
```
[Input] → [Step 1] → [Output 1] → [Step 2] → [Output 2] → ... → [Step N] → [Final Output]
```

## Error Handling
- **Step Failure:** [What to do if a step fails]
- **Recovery:** [How to restart from a failed step]
- **Rollback:** [How to undo partial completion]

## Completion Criteria
- [ ] All steps completed successfully
- [ ] All outputs validated
- [ ] No critical errors encountered
- [ ] [Additional completion criteria]

## Next Steps
- [What happens after this workflow completes]
- [Which workflow to execute next, if any]
