Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Create Job from Template</promptName>
        <typeOfPrompt>generation</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>Anthropic Claude Sonnet 4</modelTestedWith>
        <preferredProfile>PROJECT MANAGER</preferredProfile>
    </metadata>
    <context>
        <objective>Create a new job file in the jobs directory following the job template structure, with proper ID generation and system integration</objective>
        <inputs>
            <input name="job_title" type="user-provided" required="true" description="Concise description of the job">
                Brief, clear title that describes the job's main purpose
            </input>
            <input name="job_type" type="user-provided" required="true" description="Category of job being created">
                One of: User Story | Bug Fix | Task | Refactoring | Spike | Feature Enhancement | Other
            </input>
            <input name="priority" type="user-provided" required="true" description="Priority level for the job">
                One of: High | Medium | Low
            </input>
            <input name="job_description" type="user-provided" required="true" description="Brief description of the job's goal/objective">
                Clear explanation of what the job aims to accomplish
            </input>
            <input name="initial_tasks" type="user-provided" required="false" description="Any known initial tasks for the job">
                List of specific tasks or steps that are already identified
            </input>
            <input name="reference_links" type="user-provided" required="false" description="Critical documentation, SDKs, or reference links">
                URLs or references to relevant documentation or resources
            </input>
            <input name="assignee" type="user-provided" required="false" description="Person assigned to the job">
                Name of the person assigned, defaults to @AssigneeName if not provided
            </input>
            <input name="job_template" type="file" ref="[id:templates_dir]job-template.md" required="true" description="Template structure for job files">
                Standard job template with required sections and format
            </input>
            <input name="job_register" type="file" ref="[id:jobs]" required="true" description="Job register file for tracking and serial number management">
                Central register containing current serial number and active jobs list
            </input>
        </inputs>
        <outputs>
            <output name="job_file" type="file" format="markdown" description="Complete job file created from template">
                New job file named JOB-{serial}.md in the jobs directory with all required sections populated
            </output>
            <output name="updated_register" type="file" format="markdown" description="Updated job register with new job entry">
                Job register file updated with new job entry and incremented serial number
            </output>
        </outputs>
    </context>
</prompt>
```
