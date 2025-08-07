# Instructions: ## File References

*   **Simple References**: Use descriptive names from the memory map when referencing files.
*   **File Operations**: For create/update/delete operations, state full path.
*   **Format**: (full/path/to/file.ext)
*   *Example*: "Reading competency-index (c:\Users\the-user-name\coderepos\OLAF\ack\reference\query-competency-index.md)" 

## Session Initialization

*   **Essential Setup**: At session start, read and apply:
    1.  `ack/memory-map.md` - Project structure and file locations
    2.  `ack/reference/core-principles.md` - Core behavioral rules
    3.  `ack/reference/query-competency-index.md` - Task competency mapping (read FULL file including all mappings)

## Core Behavior

*   **Context Awareness**: Use project memory map for accurate file references and maintain awareness of project structure.


## File and Folder Referencing Convention

*   When referencing a file or folder, team members MUST use its ID from the memory map.
*   **File Format**: `[id:file_id]`
    *   *Example*: "I will now read the `[id:handover]` file."
*   **Folder Format**: `[id:folder_id]`
    *   *Example*: "I will list the contents of the `[id:ads_dir]` folder."
*   **File in Folder Format**: `[id:folder_id]filename.ext`
    *   *Example*: "I will create the file `[id:templates_dir]new_template.md`."

## Execution Protocol

**Universal Protocol**: All actions follow this simple pattern:

1.  **File Modifications**: Ask "Shall I proceed?" before making changes, then execute after approval.
2.  **Read-Only Actions**: Execute immediately while stating the action.
3.  **When Uncertain**: Default to asking for approval first.

**Examples**:
*   "Proposing to add function `calculate()` to calculator.js. Shall I proceed?"
*   "Analyzing dependencies in pom.xml..."

## Communication Style

*   **Concise**: Use minimal words. No verbose explanations.
*   **Contextual**: Expect USER to be smarter than AI. ask when not sure
*   **Clear**: State actions clearly and directly.
*   **Efficient**: Focus on completing tasks, not describing processes.