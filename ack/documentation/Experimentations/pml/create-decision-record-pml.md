Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Create Decision Record</promptName>
        <typeOfPrompt>generation</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <context>
        <objective>Create a new decision record in the [id:decision_records_dir] directory, following the [id:decision-record-template] format and naming conventions.</objective>
        <inputs>
            <input name="decision_title" type="user-provided" required="true" description="Concise description of the decision"/>
            <input name="decision_type" type="user-provided" required="true" description="Type of decision (Architecture, Project, Business, Functional, People, Technical, Security, Other)"/>
            <input name="status" type="user-provided" required="false" default="Proposed" description="Status of the decision (defaults to Proposed)"/>
            <input name="context_problem" type="user-provided" required="true" description="Brief context and problem statement"/>
            <input name="decision_drivers" type="user-provided" required="true" description="Factors influencing the decision"/>
            <input name="options" type="user-provided" required="true" description="Options being considered (with pros and cons if known)"/>
            <input name="selected_option" type="user-provided" required="false" description="Selected option (if already determined)"/>
            <input name="decision_makers" type="user-provided" required="true" description="Decision makers"/>
            <input name="stakeholders" type="user-provided" required="true" description="Stakeholders"/>
        </inputs>
        <outputs>
            <output name="decision_record_file" type="file" format="markdown" description="New decision record file created in [id:decision_records_dir] following the template and naming conventions"/>
            <output name="decision_register_entry" type="file" format="markdown" description="Entry added to [id:decision-records-register]"/>
            <output name="changelog_entry" type="file" format="markdown" description="Changelog entry for new decision record creation"/>
        </outputs>
    </context>
    <workBreakdownStructure>
        <phase id="1" name="Information Gathering">
            <delivers>All required decision information collected from user</delivers>
            <actions>
                <action id="1.1" name="Prompt for decision information" protocol="act">
                    <goal>Collect all required fields for the decision record</goal>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Decision Record Creation">
            <delivers>Decision record file created and populated</delivers>
            <actions>
                <action id="2.1" name="Generate Decision ID" protocol="act">
                    <goal>Generate unique Decision ID in format DR-YYYYMMDD-NN</goal>
                </action>
                <action id="2.2" name="Create decision record file" protocol="act">
                    <goal>Create and populate the decision record file using the template</goal>
                </action>
            </actions>
        </phase>
        <phase id="3" name="Register and Changelog Update">
            <delivers>Register and changelog updated</delivers>
            <actions>
                <action id="3.1" name="Update decision register" protocol="act">
                    <goal>Add entry to [id:decision-records-register], creating it if necessary</goal>
                </action>
                <action id="3.2" name="Add changelog entry" protocol="act">
                    <goal>Add documentation changelog entry for new decision record</goal>
                </action>
            </actions>
        </phase>
        <phase id="4" name="Confirmation">
            <delivers>User confirmation and file path provided</delivers>
            <actions>
                <action id="4.1" name="Confirm creation" protocol="act">
                    <goal>Confirm to user that the decision record has been created and provide the file path</goal>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
    <references>
        <reference id="decision-record-template" type="file" path="[id:decision-record-template]"/>
        <reference id="decision-records-dir" type="directory" path="[id:decision_records_dir]"/>
        <reference id="decision-records-register" type="file" path="[id:decision-records-register]"/>
    </references>
</prompt>
```
