# Sequential/Chained Workflow Template

> **Note:** All files referenced below are either prompts located in `[id:prompts_dir]` or tools located in `[id:tools_dir]`, as specified in the memory map file.
> The solution to analyze is in [id:core_dir] and all new non-temporary created files are to be created in [id:findings_dir]der.

# 1-Discovery Workflow: Comprehensive Project Discovery

## Workflow Type
Sequential/Chained - Each step depends on the output of the previous step

## Workflow Overview
Performs comprehensive project discovery including type detection, environment setup, and build validation to establish a foundation for quality analysis and refactoring.

## Prerequisites
- Access to project source code in `[id:core_dir]`
- Write permissions to `[id:findings_dir]r output files
- Administrative privileges for environment setup (tools/dependencies installation)

## Input Requirements
- **Primary Input:** Project source code files in `[id:core_dir]`
- **Secondary Inputs:** None (first workflow in sequence)
- **Input Format:** Source code files and project configuration files

## Output Specifications
- **Primary Output:** `1-discovery-results.json`
- **Secondary Outputs:** Individual step outputs (project-detection.json, environment-setup.json, build-execution.json)
- **Output Location:** [id:findings_dir]

## Workflow Steps

### Step 1: Project Detection
- **Prompt/Tool:** `[id:prompts_dir]reduce-code-complexity/1-discovery-1-project-detection.md`
- **Input:** Project source code files in `[id:core_dir]`
- **Output:** `1-discovery-1-project-detection.json`
- **Description:** Detect and analyze project type, programming languages, build systems, package managers, and overall structure
- **Validation:** Verify project-detection.json contains complete project metadata including type, languages, and build system information

### Step 2: Environment Setup
- **Prompt/Tool:** `[id:prompts_dir]reduce-code-complexity/1-discovery-2-environment-setup.md`
- **Input:** `1-discovery-1-project-detection.json`
- **Output:** `1-discovery-2-environment-setup.json`
- **Description:** Install and configure required development environments, runtimes, tools, and dependencies based on detected project characteristics
- **Validation:** Verify all required development tools are installed and properly configured

### Step 3: Build Execution
- **Prompt/Tool:** `[id:prompts_dir]reduce-code-complexity/1-discovery-3-build-execution.md`
- **Input:** `1-discovery-1-project-detection.json` + `1-discovery-2-environment-setup.json`
- **Output:** `1-discovery-3-build-execution.json`
- **Description:** Execute and validate the project build process, documenting working build commands and procedures
- **Validation:** Verify build completes successfully and build instructions are documented

## Data Flow Diagram
```
[Project Source Code] → [Step 1: Project Detection] → [project-detection.json] → [Step 2: Environment Setup] → [environment-setup.json] → [Step 3: Build Execution] → [build-execution.json] → [Consolidated Discovery Results]
```

## Error Handling
- **Step Failure:** Log detailed error information, assess impact on subsequent steps, stop workflow if critical failure
- **Recovery:** Each step can be restarted independently using preserved input files
- **Rollback:** Environment changes can be documented and reversed if necessary

## Completion Criteria
- [ ] All steps completed successfully
- [ ] All outputs validated and contain expected data structures
- [ ] No critical errors encountered during discovery process
- [ ] Consolidated discovery results file created with complete project profile

## Next Steps
- Proceed to Sub-workflow 2: Quality Baselining
- Discovery results serve as foundation for all subsequent quality analysis workflows
