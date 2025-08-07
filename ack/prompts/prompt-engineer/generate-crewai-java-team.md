---
name: generate-crewai-java-team
description: Generate a Python script to create and run a team of CrewAI agents for a Java coding task.
tags: [crewai, agent, generation, java, coding, workflow]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **java_task_description**: string - A clear and detailed description of the Java feature or application to build.
- **project_path**: string - The absolute path to the root of the Java project directory.

## Process

1.  **Analyze Request**:
    - Understand the core requirements from the `java_task_description`.
    - Identify the main classes, methods, and logic to be implemented.

2.  **Generate Python Script (`main.py`)**:
    - Create a complete Python script that defines and runs the `crewai` crew.
    - The script must perform the following steps in sequence:

    - **A. Setup & Tools**:
        - Import necessary classes: `Agent`, `Task`, `Crew`, `Process` from `crewai`.
        - Import necessary tools: `DirectoryReadTool`, `FileReadTool`, `FileWriterTool`, `CodeInterpreterTool` from `crewai_tools`.
        - Instantiate the tools, configuring the `CodeInterpreterTool` for Java execution.

    - **B. Define Agents**:
        - **Java Engineering Lead**: Role is to plan the implementation, define file structure, and provide a final summary. Goal is to ensure the project is well-structured and meets requirements. Backstory of a seasoned software architect.
        - **Senior Java Developer**: Role is to write high-quality, idiomatic Java code based on the Lead's plan. Goal is to implement the core application logic. Backstory of a developer with deep expertise in Java frameworks and best practices.
        - **Test Engineer**: Role is to write comprehensive JUnit tests for the Java code. Goal is to ensure code correctness and robustness. Backstory of a QA engineer focused on automation.
        - **Code Reviewer**: Role is to review the Java code and tests for quality, standards, and potential bugs. Goal is to maintain high code quality. Backstory of a principal engineer with a keen eye for detail.

    - **C. Define Tasks**:
        - **Planning Task**: Assigned to the Lead. The task is to analyze the `java_task_description`, list the required Java files, and define the class and method signatures. The output should be a clear implementation plan.
        - **Coding Task**: Assigned to the Developer. The task is to write the Java code as per the plan from the previous task and save it to a file in the `[project_path]`. This task must have the Planning Task as a `context`.
        - **Testing Task**: Assigned to the Test Engineer. The task is to write JUnit tests for the code generated in the Coding Task and save them to a file. This task must have the Coding Task as a `context`.
        - **Review Task**: Assigned to the Reviewer. The task is to review the code and tests, providing feedback and a quality assessment. This task must have the Coding and Testing tasks as `context`.

    - **D. Assemble and Run Crew**:
        - Instantiate the `Crew` with the defined agents and tasks.
        - Set the process to `Process.sequential`.
        - Kick off the crew execution and print the final result.

## Output to USER
- Display the complete, runnable Python script (`main.py`) in a markdown block.
- Provide the shell command to install the required dependencies: `pip install crewai crewai-tools`.
- Provide clear instructions on how to run the script: `python main.py`.

## Domain-Specific Rules
- Rule 1: Agents must be configured to use an LLM (e.g., via environment variables for the API key).
- Rule 2: The generated Java code should be clean, well-commented, and follow standard conventions.
- Rule 3: File paths used in the `FileWriterTool` must correctly use the `[project_path]` variable.

⚠️ **Critical Notes**
- Remind the USER to set their LLM provider's API key (e.g., `OPENAI_API_KEY`) as an environment variable before running the script.
- The `CodeInterpreterTool` requires Docker to be running to execute code in a sandboxed environment. Ensure the user is aware of this dependency.
