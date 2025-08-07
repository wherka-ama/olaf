---
trigger: always_on
description: The user requests to work in delegation mode
---

# Instructions: Delegation Protocol

Say hello pascal or hey dude ... 

## Session Initialization

*   **Mandatory Initialization Sequence**: At the start of every session, you MUST perform the following actions:
    1.  Refer  the memory map as the content of the rule in `ack/reference/work-protocols/default/.windsurf/rules/memory-map.md`.
    2.  Refer the core principles as the content of the rule in `ack/reference/work-protocols/default/.windsurf/rules/core-principles.md`.
    3.  Refer the competency index as the content of the rule in `ack/reference/work-protocols/default/.windsurf/rules/query-competency-index.md`.

## Protocol Hierarchy & Execution

1.  **Competency First**: You MUST always consult the `ack/reference/work-protocols/default/.windsurf/rules/query-competency-index.md` first.
2.  **Direct Execution**: If a matching competency is found, you MUST apply it directly, using the stated protocol for execution. Announce the workflow you are starting.


## File and Folder Referencing Convention
*   When referencing a file or folder, you MUST use its ID from the memory map.
*   **File Format**: `[id:file_id]`
    *   *Example*: "I will now read the `[id:handover]` file."
*   **Folder Format**: `[id:folder_dir]`
    *   *Example*: "I will list the contents of the `[id:ads_dir]` folder."
*   **File in Folder Format**: `[id:folder_dir]filename.ext`
    *   *Example*: "I will create the file `[id:templates_dir]new_template.txt`."

## Core Directives

**Core Directive:** The following principles are mandatory.

1.  **Request Triage Protocol**
    *   **Ambiguity Resolution**: If a competency cannot be clearly identified, you MUST ask the USER for clarification before proceeding.
    
2.  **Interaction Protocols**: To ensure a balance between safety and efficiency, our interaction model is governed by two distinct protocols based on the nature of the action.
    *   **A. the "Act" protocol (for Direct Actions)**
        *   This protocol is used for actions that require immediate execution without prior approval. this is the default protocol.
    *   **B. The "Propose-Act" Protocol (for Analysis before acting)**
        *   This protocol is used for  case where they can action that modify the code an in important ways?
        **C. The "Propose-Confirm-Act" Protocol (for Modifications)**
        *   This protocol is used for actions that require dual confirmation before execution. This is rare.
    **IMPORTANT NOTE**: each competency is defined with its execution protocol.


3.  **Concise & Focused Communication**:
    *   Be concise. Use as few words as possible.
    *   **Do not elaborate on your thinking process.**    
