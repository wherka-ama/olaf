# DFD Analysis Main Coordinator

> Output Directory Directive: All files mentioned in this coordinator and produced by any DFD sub‑prompt MUST be created and maintained inside the directory `[id:findings_dir]dfd/`. If the directory does not yet exist, create it before writing files. When a filename is referenced below (e.g., `DFD_master_progress.md`), the effective full path is `[id:findings_dir]dfd/DFD_master_progress.md` (and likewise for all other required artifact files). Do not write or duplicate these files outside `[id:findings_dir]dfd/`.

## Overview
This is the master coordinator for Data Flow Diagram (DFD) analysis. It manages the execution of four specialized sub-prompts based on current progress and conditions.

## Prerequisites
Before starting any DFD analysis, you MUST create the master progress tracking file.

**Create `DFD_master_progress.md` first (path: `[id:findings_dir]dfd/DFD_master_progress.md`):**

```markdown
# Master DFD Analysis Progress for [Application Name]

## Overall Progress Tracking
**Analysis Started:** [Date]
**Last Updated:** [Date]
**Current Phase:** [Phase Name]
**Overall Completion:** [X/12 steps completed]

## Master Task Checklist

### Phase A: Initial Analysis (Sub-prompt 1)
- [ ] **Step 1**: Initial System Understanding
- [ ] **Step 2**: Context Diagram Creation
- [ ] **Step 3**: Level 1 DFD Task Planning

### Phase B: Level 1 Analysis (Sub-prompt 2)
- [ ] **Step 4**: Level 1 DFD Creation
- [ ] **Step 5**: Level 1 vs Level 2 Validation
- [ ] **Step 6**: Level 1 Refinement (if needed)
- [ ] **Step 7**: Level 2 Task Planning

### Phase C: Level 2 Analysis (Sub-prompt 3)
- [ ] **Step 8**: Level 2 DFD Creation
- [ ] **Step 9**: Level 2 Validation

### Phase D: Final Documentation (Sub-prompt 4)
- [ ] **Step 10**: Final Documentation
- [ ] **Step 11**: Quality Review
- [ ] **Step 12**: Stakeholder Review

## Current Status
**Active Phase:** [A/B/C/D]
**Next Sub-prompt:** [1/2/3/4]
**Ready for User Review:** [Yes/No]

## File Status (all under `[id:findings_dir]dfd/`)
- [ ] `DFD_master_progress.md` - This master tracking file
- [ ] `[App]_analysis.md` - Main analysis document
- [ ] `DFD_level1_tasks.md` - Level 1 task tracking
- [ ] `DFD_level2_tasks.md` - Level 2 task tracking (only if Level 2 required)
- [ ] `DFD_level_analysis.md` - Final level analysis

### Required Artifacts Naming Contract (STRICT)
These filenames are REQUIRED (case‑sensitive, exact). The assistant MUST create / update them with these exact names only, all rooted at `[id:findings_dir]dfd/`:

1. `[id:findings_dir]dfd/DFD_master_progress.md`
2. `[id:findings_dir]dfd/[App]_analysis.md`  (Replace `[App]` with the agreed application identifier. Keep suffix `_analysis.md`. Example: `Code2DFD_analysis.md`.)
3. `[id:findings_dir]dfd/DFD_level1_tasks.md`
4. `[id:findings_dir]dfd/DFD_level2_tasks.md` (ONLY if Level 2 Decision = Yes. If Decision = No, DO NOT create this file.)
5. `[id:findings_dir]dfd/DFD_level_analysis.md` (ALWAYS create in Phase D even if Level 2 Decision = No; must contain a section documenting the Level 2 decision and rationale.)

Prohibited alternative names (DO NOT use; if generated, they MUST be renamed to `DFD_level_analysis.md` and the incorrect file removed):
- `DFD_Final_Documentation.md`
- `DFD_final_documentation.md`
- `Final_Documentation.md`
- `FinalDocumentation.md`
- `Final_Analysis.md`
- `Level_Analysis.md`
- Any other variation not exactly `DFD_level_analysis.md`

Guard Clause:
If the model is about to output a “final” synthesis file under any name other than `DFD_level_analysis.md`, it MUST stop, rename, and re‑emit as `DFD_level_analysis.md`.

Self‑Validation Step (must run BEFORE concluding Phase D):
1. List the files in the working set.
2. Confirm each required filename exists (or is correctly omitted for `DFD_level2_tasks.md` when Level 2 = No).
3. Confirm no prohibited names exist.
4. Write a line in `DFD_master_progress.md` under a new subsection `### Filename Compliance`:
	- `Filename Compliance: PASS` (only if all checks succeed) otherwise `Filename Compliance: FAIL - <issue>`.

End‑of‑Phase D Checklist Additions (append to master progress):
- [ ] Filenames validated (exact contract)
- [ ] `DFD_level_analysis.md` present
- [ ] No prohibited filename variants
- [ ] Level 2 decision documented inside `DFD_level_analysis.md`

Header Requirement inside `DFD_level_analysis.md`:
The first heading of that file MUST be:
```
# Final Level Analysis (File: DFD_level_analysis.md – REQUIRED NAME)
```
Followed immediately by an executive summary paragraph.

Rationale:
Consistent naming enables automated diffing, tooling integration, and reliable metrics (useful file detection). Previous ambiguity led to variants like `DFD_Final_Documentation.md`; this contract eliminates drift.


## Level 2 Decision Status
**⚠️ This section MUST be completed during Step 7:**
### Level 2 Required?
- **Decision:** [Yes/No - REQUIRED]
- **Reason:** [Justification - REQUIRED]  
- **Processes requiring Level 2:** [List or "None" - REQUIRED]
- **Task File Created:** [Yes/No - REQUIRED]
- **Decision Date:** [Date - REQUIRED]

## Session Management
**Last Session End:** [Date/Time]
**Session Handoff Notes:** [Notes for next session]
**User Review Required:** [Yes/No]
```

## Sub-prompt Execution Logic

### Phase A: Initial Analysis (Sub-prompt 1)
**Execution Condition:** 
- Master progress file exists
- Steps 1-3 are not completed
- No `DFD_level1_tasks.md` file exists

**Load:** `dfd_subprompt_1_initial.md`
**Covers:** System understanding, Context diagram, Level 1 task planning

### Phase B: Level 1 Analysis (Sub-prompt 2)
**Execution Condition:**
- Master progress shows Steps 1-3 completed
- `DFD_level1_tasks.md` file exists
- Steps 4-7 are not completed

**Load:** `dfd_subprompt_2_level1.md`
**Covers:** Level 1 creation, validation, refinement, Level 2 planning

### Phase C: Level 2 Analysis (Sub-prompt 3)
**Execution Condition (ALL must be true):**
- Master progress shows Steps 1-7 completed
- Master progress contains "### Level 2 Required?" section with "Decision: Yes"
- `DFD_level2_tasks.md` file exists
- Steps 8-9 are not completed

**Load:** `dfd_subprompt_3_level2.md`
**Covers:** Level 2 creation and validation

### Phase D: Final Documentation (Sub-prompt 4)
**Execution Condition (ONE of these):**
- Master progress shows Steps 1-9 completed AND Level 2 decision was "Yes"
- Master progress shows Steps 1-7 completed AND contains "### Level 2 Required?" section with "Decision: No" AND `DFD_level2_tasks.md` file does NOT exist
- Steps 10-12 are not completed

**Load:** `dfd_subprompt_4_final.md`
**Covers:** Final documentation, quality review, stakeholder review

## User Review Points

**🛑 MANDATORY USER REVIEW REQUIRED BEFORE EACH PHASE:**

Before executing any sub-prompt, the user must:
1. Review the master progress file
2. Confirm the current phase status
3. Approve proceeding to the next sub-prompt
4. Restart the session with the appropriate sub-prompt

## Execution Instructions

### For AI Assistant:
1. **Always check master progress file first**
2. **Verify execution conditions before loading sub-prompt**
3. **Request user confirmation before phase transitions**
4. **Update master progress after each sub-prompt completion**

### For Users:
1. **Start by creating master progress file**
2. **Review progress before each session**
3. **Confirm phase transitions**
4. **Update master progress as you proceed**

## Sub-prompt File Structure

```
dfd_main_coordinator.md          (this file)
├── dfd_subprompt_1_initial.md   (Steps 1-3)
├── dfd_subprompt_2_level1.md    (Steps 4-7)
├── dfd_subprompt_3_level2.md    (Steps 8-9)
└── dfd_subprompt_4_final.md     (Steps 10-12)
```

## Next Steps

1. **Create master progress file** using the template above
2. **Check current status** and determine which phase you're in
3. **Load appropriate sub-prompt** based on execution conditions
4. **Proceed with analysis** following the loaded sub-prompt
5. **Update master progress** after completing each phase

## Error Handling

**If conditions are not met:**
- Check master progress file exists and is up to date
- Verify all required files from previous phases exist
- Ensure master progress is coherent with actual completion status
- Request user review and correction before proceeding

**Integrity Checks Before Phase Transitions:**
- **Before Phase C**: Verify "### Level 2 Required?" section exists with "Decision: Yes" AND `DFD_level2_tasks.md` file exists
- **Before Phase D**: Verify either (Steps 1-9 complete) OR (Steps 1-7 complete AND "Decision: No" AND no `DFD_level2_tasks.md` file)
- **Step 7 Verification**: Step 7 should NEVER be marked complete unless the decision section exists AND (if Decision: Yes) the task file exists

**If session is interrupted:**
- Master progress file maintains state
- Resume from appropriate sub-prompt based on last completed step
- User review required before resuming
