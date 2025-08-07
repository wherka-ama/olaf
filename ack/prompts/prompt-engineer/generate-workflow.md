# Generate Workflow Prompt

## Purpose
Interview users to create structured workflows based on standard templates, or generate workflows from specification files.

## Available Workflow Templates
- **Sequential/Chained:** `[id:templates_dir]prompt-engineer/workflow-template-sequential.md`
- **Iterative:** `[id:templates_dir]prompt-engineer/workflow-template-iterative.md` 
- **Decision/Switch-Case:** `[id:templates_dir]prompt-engineer/workflow-template-decision.md`
- **Master/Orchestrator:** `[id:templates_dir]prompt-engineer/workflow-template-orchestrator.md`

## Input Requirements
- **Mode 1:** Interactive interview with user
- **Mode 2:** Specification file (`workflow-specification.json`)

## Generation Process

### Interview Mode

#### Step 1: Workflow Type Discovery
Ask the user:
1. "What does your workflow need to accomplish?"
2. "Does your workflow coordinate complete sub-workflows (Orchestrator), have steps that must happen in order (Sequential), repeat until done (Iterative), or choose different paths based on data (Decision)?"
3. "Do any steps depend on outputs from previous steps?"
4. "Are you chaining together complete workflows or individual prompts/tools?"

**Classification Logic:**
- **Orchestrator** if: Chains complete sub-workflows, coordinates multiple workflows, manages data flow between workflows
- **Sequential** if: Steps have dependencies, linear progression, outputs feed into next step
- **Iterative** if: Same process repeats, has stopping criteria, needs user authorization to continue
- **Decision** if: Different actions based on data values, conditional branching, switch-case logic

#### Step 2: Template-Specific Questions

**For Orchestrator Workflows:**
1. "List all the sub-workflows that need to be chained together. For each sub-workflow:"
   - "What type is it (Sequential/Iterative/Decision/Orchestrator)?"
   - "What does this sub-workflow accomplish?"
   - "What input does it need to start?"
   - "What output does it produce?"
   - "Which previous sub-workflow outputs does it depend on?"
2. "How should outputs be consolidated between sub-workflows?"
3. "What should happen if a sub-workflow fails?"
4. "Are there any critical checkpoints where user approval is needed?"

**For Sequential Workflows:**
1. "List all the steps in order. For each step:"
   - "What does this step do?"
   - "What input does it need?"
   - "What output does it produce?"
   - "Is it a prompt file or a tool/script?"
2. "What are the overall input requirements to start this workflow?"
3. "What is the final output when complete?"

**For Iterative Workflows:**
1. "What process needs to be repeated?"
2. "What determines when to stop iterating?"
3. "What should be recommended to the user for continue/stop decisions?"
4. "What data needs to be tracked between iterations?"
5. "What is the maximum number of iterations allowed?"

**For Decision Workflows:**
1. "What data determines which path to take?"
2. "Which files contain this decision data?"
3. "What are all the possible values and what should happen for each?"
4. "Is there a default action if no match is found?"
5. "Do you need multiple criteria for decisions?"

### Specification File Mode

#### Expected Specification Format
```json
{
  "workflow_type": "sequential|iterative|decision|orchestrator",
  "workflow_name": "[Name]",
  "description": "[Description]",
  "inputs": [
    {
      "name": "[Input name]",
      "type": "file|data|parameter",
      "format": "json|md|txt",
      "description": "[What this input provides]"
    }
  ],
  "outputs": [
    {
      "name": "[Output name]",
      "format": "json|md|txt", 
      "description": "[What this output contains]"
    }
  ],
  "workflow_specific": {
    // Sequential specific
    "steps": [
      {
        "name": "[Step name]",
        "type": "prompt|tool",
        "file": "[filename].md|[filename].ps1",
        "input": "[input description]",
        "output": "[output description]"
      }
    ],
    // Iterative specific  
    "iteration_logic": {
      "completion_criteria": "[What determines completion]",
      "max_iterations": 10,
      "recommendation_logic": "[How to recommend continue/stop]"
    },
    // Decision specific
    "decision_criteria": {
      "data_sources": ["[file1].json", "[file2].json"],
      "decision_field": "[json.path.to.decision.field]",
      "lookup_table": {
        "[value1]": "[prompt1].md",
        "[value2]": "[prompt2].md"
      }
    },
    // Orchestrator specific
    "sub_workflows": [
      {
        "name": "[Sub-workflow name]",
        "type": "sequential|iterative|decision|orchestrator",
        "file": "[sub-workflow-file].md",
        "input_sources": ["orchestrator_input", "[previous-sub-workflow].output"],
        "output": "[sub-workflow-output].json",
        "description": "[What this sub-workflow does]"
      }
    ],
    "data_flow_rules": {
      "consolidation_logic": "[How outputs are consolidated]",
      "transformation_points": "[Where data is transformed between sub-workflows]"
    }
  }
}
```

## Generation Algorithm

### Step 1: Template Selection
```
IF workflow_type == "sequential" THEN
    LOAD workflow-template-sequential.md
ELIF workflow_type == "iterative" THEN  
    LOAD workflow-template-iterative.md
ELIF workflow_type == "decision" THEN
    LOAD workflow-template-decision.md
ELIF workflow_type == "orchestrator" THEN
    LOAD workflow-template-orchestrator.md
```

### Step 2: Template Population
1. Replace all `[WORKFLOW_NAME]` with specified name
2. Replace all `[WORKFLOW_DESCRIPTION]` with description
3. Populate input/output sections with gathered data
4. Fill template-specific sections based on workflow type

### Step 3: Validation
- Verify all template placeholders filled
- Check input/output file naming follows conventions
- Validate JSON structures if present
- Ensure file references use memory map format

### Step 4: Output Generation
- Create new workflow file: `[workflow-name].md`
- Save to `[id:prompts_dir][workflow-name].md`
- Generate summary of created workflow

## File Naming Conventions
- Workflow files: `[verb-noun-complement].md` (kebab-case)
- Output files: `[descriptive-name-explaining-content].json`
- Use explicit, descriptive names that explain file contents

## JSON Format Standards
- Use camelCase for field names
- Include timestamp fields: ISO 8601 format
- Include metadata: version, author, creation date
- Structure data logically with nested objects
- Always include validation/success fields

## Example Usage

### Interactive Session:
```
USER: I need a workflow to analyze code complexity
ASSISTANT: I'll help you create a workflow. What does your workflow need to accomplish?
USER: It should detect project type, then analyze complexity, then generate a report
ASSISTANT: This sounds like a Sequential workflow since steps depend on each other. Let me ask about each step...
[Interview continues]
```

### Specification File:
```
INPUT: workflow-specification.json
OUTPUT: analyze-code-complexity-workflow.md (generated workflow)
```

## Completion Criteria
- [ ] Workflow type correctly identified
- [ ] All template sections populated
- [ ] Input/output chain validated
- [ ] File follows naming conventions
- [ ] Generated workflow is ready for use
