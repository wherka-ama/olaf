# DFD Analysis Main Coordinator

## Overview
This is the master coordinator for Data Flow Diagram (DFD) analysis. It manages the execution of four specialized sub-prompts based on current progress and conditions.

## Prerequisites
Before starting any DFD analysis, you MUST create the master progress tracking file.

**Create `DFD_master_progress.md` first:**

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

## File Status
- [ ] `DFD_master_progress.md` - This master tracking file
- [ ] `[App]_analysis.md` - Main analysis document
- [ ] `DFD_level1_tasks.md` - Level 1 task tracking
- [ ] `DFD_level2_tasks.md` - Level 2 task tracking
- [ ] `DFD_level_analysis.md` - Final level analysis

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
**Execution Condition:**
- Master progress shows Steps 1-7 completed
- Level 2 analysis is required (master progress indicates this)
- Steps 8-9 are not completed

**Load:** `dfd_subprompt_3_level2.md`
**Covers:** Level 2 creation and validation

### Phase D: Final Documentation (Sub-prompt 4)
**Execution Condition:**
- Master progress shows Steps 1-9 completed (or Steps 1-7 if Level 2 not required)
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

**If session is interrupted:**
- Master progress file maintains state
- Resume from appropriate sub-prompt based on last completed step
- User review required before resuming
