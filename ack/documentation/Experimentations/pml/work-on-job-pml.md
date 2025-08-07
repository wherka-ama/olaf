Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Work on Job (PML)</promptName>
        <typeOfPrompt>job-process</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <context>
        <objective>Guide the process of working on an existing job by identifying the job, executing tasks, tracking progress, updating documentation, and maintaining the job status.</objective>
        <inputs>
            <input name="job_id" type="user-provided" required="false" description="ID of the job to work on">Job identifier or path to job file. If not provided, active jobs will be listed for selection.</input>
            <input name="subtask" type="user-provided" required="false" description="Specific subtask to execute">Optional subtask or step to focus on within the job.</input>
        </inputs>
        <outputs>
            <output name="job_status_update" type="llm-generated" format="markdown" description="Status update for the job">Current status, next tasks/subtasks, and last update time for the job.</output>
            <output name="progress_documentation" type="llm-generated" format="markdown" description="Progress documentation and changelog entries">Updated job file and changelog entries reflecting progress.</output>
        </outputs>
    </context>
    <outcomes>
        <expected>Job is identified and current status is presented to the user</expected>
        <expected>Tasks and subtasks are executed with regular progress updates</expected>
        <expected>Job file and changelog are updated as progress is made</expected>
        <expected>Task plan is reviewed and modified if needed</expected>
        <expected>User is prompted to continue or pause after each subtask</expected>
    </outcomes>
    <workBreakdownStructure>
        <phase id="1" name="Job Identification and Status Check">
            <delivers>Job ID and current status</delivers>
            <onFailure>Request user to provide a valid job ID or select from active jobs</onFailure>
            <actions>
                <action id="1.1" name="Identify job and present status" protocol="act">
                    <goal>Determine which job to work on and present its status</goal>
                    <inputs>
                        <input name="job_id" type="user-provided" required="false" description="Job ID or path"/>
                    </inputs>
                    <verification>Job is selected and status is presented</verification>
                    <steps>
                        <step id="1.1.1"><do>Check if job ID is provided</do></step>
                        <step id="1.1.2"><do>If not, list active jobs and prompt user to select</do></step>
                        <step id="1.1.3"><do>Read job file and present current status, next tasks, and last update time</do></step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Task Execution">
            <delivers>Subtasks executed and progress tracked</delivers>
            <onFailure>Request clarification or additional information from user</onFailure>
            <actions>
                <action id="2.1" name="Execute task or subtask" protocol="act">
                    <goal>Work on the identified task or subtask and provide updates</goal>
                    <inputs>
                        <input name="subtask" type="user-provided" required="false" description="Subtask to execute"/>
                    </inputs>
                    <verification>Progress is updated and communicated</verification>
                    <steps>
                        <step id="2.1.1"><do>Work on the subtask</do></step>
                        <step id="2.1.2"><do>Provide regular progress updates</do></step>
                        <step id="2.1.3"><do>Request clarification or present options if needed</do></step>
                    </steps>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
</prompt>
```
