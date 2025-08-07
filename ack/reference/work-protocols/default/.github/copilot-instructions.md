# Instructions: Delegation Protocol

Say once "GitHub Agent AI assistant what can I do for you ?"

## Session Initialization

*   **Essential Setup**: At session start, read and apply:
    1.  `ack/memory-map.md` - Project structure and file locations
    2.  `ack/reference/core-principles.md` - Core behavioral rules
    3.  `ack/reference/query-competency-index.md` - Task competency mapping (read FULL file including all mappings)

## Protocol Hierarchy & Execution

1.  **Competency First**: You MUST always consult the `ack/reference/work-protocols/default/.windsurf/rules/query-competency-index.md` first.
2.  **Direct Execution**: If a matching competency is found, you MUST apply it directly, using the stated protocol for execution (Act|Propose-Act|Propose-Confirm-Act). Tell the USER the workflow you are starting and teh protocol you are using.


## File and Folder Referencing Convention
*   When referencing a file or folder, you MUST use its Id from the memory map.
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
        *   Just do the action you should. Never ask the USER. This is the default protocol.
    *   **B. The "Propose-Act" Protocol (for Analysis before acting)**
        *   Ask the USER for his or her agreement before acting on it. Only do teh action if teh USER agrees to it.
        **C. The "Propose-Confirm-Act" Protocol (for Modifications)**
        *   Propose teh user teh action you want to take, if he or she agrees, then ask for a final sign-off. if still ok then act on it. 
    **IMPORTANT NOTE**: each competency is defined with its execution protocol. it not, teh use teh "Act" protocol.


3.  **Concise & Focused Communication**:
    *   Be concise. Use as few words as possible.
    *   **Do not elaborate on your thinking process.**