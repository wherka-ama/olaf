---
name: orchestrate-project-onboarding-analysis
description: Comprehensive project analysis orchestrator for onboarding new team members or understanding existing projects
tags: [orchestrator, onboarding, analysis, documentation, project-setup]
---

# Project Onboarding Analysis Orchestrator

## Workflow Type
Master/Orchestrator - Coordinates comprehensive project analysis through multiple specialized sub-workflows

## Workflow Overview
Orchestrates systematic project analysis for onboarding purposes by executing specialized analysis workflows, checking for existing documentation to avoid duplication, and synthesizing results into comprehensive project overview documentation.

## Prerequisites
- Access to target repository path
- Write permissions to product documentation directory
- All referenced analysis prompts available in prompts directory

## Input Requirements
- **Primary Input:** Absolute path to repository to be analyzed
- **Configuration Input:** Target documentation output directory path
- **Input Format:** Repository path (string), optional existing document verification

## Output Specifications
- **Orchestrator Log:** `project-onboarding-orchestrator-log-YYYYMMDD-NNN.json`
- **Final Consolidated Output:** `product-overview.md`
- **Sub-workflow Outputs:** Repository setup, technical stack, architecture, test stack, API specification documents
- **Output Location:** `[id:product_docs_dir]repo_name]/`

## Phase-Based Sub-Workflow Chain

### Phase 1: Foundation Workflow
- **Type:** Sequential (Must Execute First)
- **Sub-Workflow:** `[id:prompts_dir]common/workflows/phase-1-foundation.md`
- **Tasks:** Workspace analysis, repo classification, language analysis, size metrics
- **Dependencies:** None
- **Output:** Foundation analysis documents

### Phase 2: Technology Understanding Workflow
- **Type:** Sequential
- **Sub-Workflow:** `[id:prompts_dir]common/workflows/phase-2-technology.md`
- **Tasks:** Technology stack analysis
- **Dependencies:** Phase 1 complete
- **Output:** Technology analysis documents

### Phase 3: Testing and Quality Workflow
- **Type:** Parallel Execution Possible
- **Sub-Workflow:** `[id:prompts_dir]common/workflows/phase-3-testing-quality.md`
- **Tasks:** Unit testing, integration testing, code coverage, performance testing
- **Dependencies:** Phase 1-2 complete
- **Output:** Testing and quality analysis documents

### Phase 4: Build and Deployment Workflow
- **Type:** Sequential
- **Sub-Workflow:** `[id:prompts_dir]common/workflows/phase-4-build-deployment.md`
- **Tasks:** Build process, CI/CD, deployment strategy, infrastructure analysis
- **Dependencies:** Phase 1-3 complete
- **Output:** Build and deployment analysis documents

### Phase 5: Architecture and Data Workflow
- **Type:** Parallel Execution Possible
- **Sub-Workflow:** `[id:prompts_dir]common/workflows/phase-5-architecture-data.md`
- **Tasks:** Database architecture, API design, architecture patterns
- **Dependencies:** Phase 1-4 complete
- **Output:** Architecture and data analysis documents

### Phase 6: Security and Governance Workflow
- **Type:** Sequential
- **Sub-Workflow:** `[id:prompts_dir]common/workflows/phase-6-security-governance.md`
- **Tasks:** Authentication, security patterns, data governance
- **Dependencies:** Phase 1-5 complete
- **Output:** Security and governance analysis documents

### Phase 7: Standards and Quality Workflow
- **Type:** Parallel Execution Possible
- **Sub-Workflow:** `[id:prompts_dir]common/workflows/phase-7-standards-quality.md`
- **Tasks:** Code style, complexity analysis, dependency analysis, licensing
- **Dependencies:** Phase 1-6 complete
- **Output:** Standards and quality analysis documents

### Phase 8: Documentation and Practices Workflow
- **Type:** Sequential
- **Sub-Workflow:** `[id:prompts_dir]common/workflows/phase-8-documentation-practices.md`
- **Tasks:** Documentation analysis, spec-driven development, error handling
- **Dependencies:** Phase 1-7 complete
- **Output:** Documentation and practices analysis documents

### Phase 9: Risk Analysis Workflow
- **Type:** Sequential (Requires Historical Data)
- **Sub-Workflow:** `[id:prompts_dir]common/workflows/phase-9-risk-analysis.md`
- **Tasks:** Hotspot analysis, critical contributors analysis
- **Dependencies:** Phase 1-8 complete
- **Output:** Risk analysis documents

### Phase 10: Synthesis Workflow
- **Type:** Sequential (Final Phase)
- **Sub-Workflow:** `[id:prompts_dir]common/workflows/phase-10-synthesis.md`
- **Tasks:** Business domain synthesis, final consolidation
- **Dependencies:** All phases 1-9 complete
- **Output:** `product-overview.md` and consolidated documentation

## Task List Management

### Task List Structure (`olaf-onboarding-tasklist.md`)
- **Task ID:** 1-28 (corresponding to all analysis tasks)
- **Task Name:** Human-readable task description
- **Status:** PENDING, IN_PROGRESS, COMPLETED, SKIPPED
- **Output File:** Target markdown file name
- **Python Script:** Script name if applicable
- **Dependencies:** List of task IDs that must be completed first
- **Timestamp:** When status was last updated
- **Phase:** Which phase (1-10) the task belongs to

### Session Management

### Planned Session Breaks
- **After each phase completion:** Orchestrator stops and instructs user to review outputs
- **New session required:** User must start fresh session to continue to next phase
- **Review period:** Allows user to examine phase results before proceeding
- **Quality control:** Ensures user oversight at each major milestone

### Session Interruption Handling
- If workflow is interrupted mid-phase, task list preserves exact state
- Next session can resume from exact task where it left off
- Dependencies are preserved and checked before execution
- Phase completion reviews are enforced regardless of interruption type
- **Progress visibility:** User can see completion status at any time

## Data Flow Management
- **Task-level execution:** Individual tasks execute based on dependencies and status
- **Conditional execution:** Skip tasks marked as SKIPPED or already COMPLETED
- **Output consolidation:** Final synthesis combines all available analysis documents
- **Error resilience:** Failed tasks don't prevent remaining workflow execution

## Orchestrator Execution Steps

### Step 1: Session Initialization
1. Request repository path from user
2. Define output directory: `[id:product_docs_dir]repo_name]/`
3. **Check for existing task list:** Look for `olaf-onboarding-tasklist.md` in `[id:product_docs_dir]repo_name]/`
4. **If task list exists:**
   - Read task list to determine next pending task
   - Display current progress and next task to user
   - Ask user: continue from where left off or restart?
   - If continuing, skip to Step 3 with next pending task
   - If restarting, proceed to Step 2
5. **If no task list exists:** Proceed to Step 2 (Fresh Start)

### Step 2: Fresh Start Setup
1. Check existing output files in `[id:product_docs_dir]repo_name]/`
2. Present list of existing files to user
3. Allow user to specify which analyses to redo/overwrite
4. **Create initial task list:** `olaf-onboarding-tasklist.md` in `[id:product_docs_dir]repo_name]/` with:
   - All 28 tasks with PENDING status
   - Task dependencies mapped
   - Output file names specified
   - Python script references where available

### Step 3: Task-Level Execution
1. **Task Selection Logic:**
   - Skip tasks where output exists and user chose not to redo (mark SKIPPED)
   - Execute only PENDING tasks with all dependencies COMPLETED
   - Update task status to IN_PROGRESS before starting
2. **For each eligible task:**
   - Execute corresponding prompt from phase workflow
   - Integrate Python script if available
   - Validate task output
   - Update task status to COMPLETED with timestamp
   - Save updated task list
3. **Dependency Validation:**
   - Before each task, verify all dependency tasks are COMPLETED
   - Follow 10-phase execution order
   - Move to next eligible task if dependencies not met
4. **Phase Completion Review:**
   - When all tasks in a phase are COMPLETED, stop execution
   - Display phase completion summary to user
   - List all generated documents for the phase
   - **Instruct user:** "Please review the phase outputs before continuing. Start a new session to proceed to the next phase."
   - Update task list with phase completion timestamp

### Step 4: Final Synthesis
1. Execute Phase 10 synthesis workflow
2. Generate comprehensive product overview
3. Mark all synthesis tasks as COMPLETED
4. Report final completion status to user

## Quality Gates
- Repository path validation before execution
- Sub-workflow output validation before proceeding
- Final output completeness verification

## Error Recovery
- **Sub-workflow Failure:** Log error, continue with remaining workflows
- **Repository Access Error:** Prompt user for correct path
- **Output Directory Error:** Create directory structure as needed

## Success Metrics
- Number of analysis documents generated
- Completeness of final product overview
- Time to complete full analysis
- User satisfaction with onboarding documentation quality
