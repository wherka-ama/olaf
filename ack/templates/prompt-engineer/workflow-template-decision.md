# Decision/Switch-Case Workflow Template

> **Note:** All files referenced below are either prompts located in `[id:prompts_dir]` or tools located in `[id:tools_dir]`, as specified in the memory map file.
> The solution to analyze is in [id:core_dir] and all new non-temporary created files are to be created in [id:findings_dir] folder.

# [WORKFLOW_NAME]: [WORKFLOW_DESCRIPTION]

## Workflow Type
Decision/Switch-Case - Conditional branching based on data from previous workflow outputs using lookup tables

## Workflow Overview
[Brief description of what this workflow accomplishes through conditional logic]

## Prerequisites
- [List any required conditions before starting]
- [Dependencies on other workflows or files]
- [Required input files from previous workflows]

## Input Requirements
- **Decision Data Sources:** [List all files that contain decision criteria]
  - `[previous-workflow-output-1].json`
  - `[previous-workflow-output-2].json`
  - `[configuration-file].json`
- **Decision Key:** `[specific-json-path-or-field]` from input files
- **Input Format:** JSON files with specific decision fields

## Output Specifications
- **Decision Log:** `[descriptive-decision-log-name].json`
- **Selected Branch Output:** `[descriptive-branch-output-name].json`
- **Output Location:** [id:findings_dir]

## Decision Logic

### Decision Lookup Table
```json
{
  "decision_table": {
    "[decision_key_name]": {
      "data_source": "[source-file].json",
      "json_path": "[path.to.decision.field]",
      "lookup_mappings": {
        "[value1]": {
          "prompt": "[id:prompts_dir][prompt-for-value1].md",
          "description": "[What happens for value1]"
        },
        "[value2]": {
          "prompt": "[id:prompts_dir][prompt-for-value2].md", 
          "description": "[What happens for value2]"
        },
        "[valueN]": {
          "prompt": "[id:prompts_dir][prompt-for-valueN].md",
          "description": "[What happens for valueN]"
        },
        "default": {
          "prompt": "[id:prompts_dir][default-prompt].md",
          "description": "[What happens when no match found]"
        }
      }
    }
  }
}
```

### Multi-Criteria Decision Table (Optional)
```json
{
  "multi_criteria_decision": {
    "criteria": [
      {
        "name": "[criterion1]",
        "data_source": "[source-file1].json",
        "json_path": "[path.to.field1]"
      },
      {
        "name": "[criterion2]", 
        "data_source": "[source-file2].json",
        "json_path": "[path.to.field2]"
      }
    ],
    "decision_matrix": {
      "[value1A]_[value2A]": {
        "prompt": "[id:prompts_dir][prompt-for-combination1].md",
        "description": "[Description for this combination]"
      },
      "[value1A]_[value2B]": {
        "prompt": "[id:prompts_dir][prompt-for-combination2].md",
        "description": "[Description for this combination]"
      },
      "[value1B]_[value2A]": {
        "prompt": "[id:prompts_dir][prompt-for-combination3].md",
        "description": "[Description for this combination]"
      }
    }
  }
}
```

## Workflow Steps

### Step 1: Decision Data Extraction
- **Action:** Read and extract decision criteria from input files
- **Input:** All specified decision data sources
- **Output:** `[decision-extraction].json`
- **Description:** Extract relevant decision values from previous workflow outputs

### Step 2: Decision Resolution
- **Action:** Apply lookup table logic to determine branch
- **Input:** `[decision-extraction].json` + Decision lookup table
- **Output:** `[decision-result].json`
- **Description:** Match extracted values against lookup table to select appropriate prompt/workflow

### Step 3: Branch Execution
- **Action:** Execute the selected prompt/workflow based on decision
- **Input:** Original workflow inputs + decision context
- **Output:** `[branch-execution-output].json`
- **Description:** Run the specific prompt or sub-workflow determined by the decision logic

## Decision Log Format
```json
{
  "decision_timestamp": "2025-07-28T14:00:00Z",
  "decision_criteria": {
    "[criterion1]": "[extracted_value1]",
    "[criterion2]": "[extracted_value2]"
  },
  "data_sources": [
    {
      "file": "[source-file1].json",
      "field": "[path.to.field]",
      "value": "[extracted_value]"
    }
  ],
  "selected_branch": {
    "lookup_key": "[matched_key]",
    "prompt": "[selected_prompt].md",
    "description": "[branch_description]"
  },
  "execution_result": {
    "success": true,
    "output_file": "[branch-output].json"
  }
}
```

## Data Flow Diagram
```
[Input Files] → [Extract Decision Data] → [Apply Lookup Table] → [Select Branch] → [Execute Branch] → [Branch Output]
     ↓                    ↓                       ↓                  ↓              ↓
[File1.json]      [Decision Data]        [Lookup Result]     [Selected Prompt]  [Final Output]
[File2.json]      [Extracted Values]     [Branch Choice]     [Branch Context]   [Decision Log]
[FileN.json]
```

## Error Handling
- **Missing Decision Data:** [What to do if required decision fields are missing]
- **No Lookup Match:** [How to handle values not in lookup table - use default]
- **Branch Execution Failure:** [What to do if selected branch fails]
- **Invalid Input Files:** [How to handle corrupted or missing input files]

## Validation
- [ ] All decision data sources accessible
- [ ] Decision criteria successfully extracted
- [ ] Lookup table match found (or default used)
- [ ] Selected branch executed successfully
- [ ] Decision log created and complete

## Next Steps
- [What happens after this workflow completes]
- [How the branch output feeds into subsequent workflows]
