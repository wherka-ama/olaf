Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Create Person Record</promptName>
        <typeOfPrompt>generation</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <context>
        <objective>Create a new person record in the [id:peoples_dir] directory, following the [id:people-template] format and naming conventions.</objective>
        <inputs>
            <input name="full_name" type="user-provided" required="true" description="Full name of the person"/>
            <input name="nickname" type="user-provided" required="false" description="Nickname (if any)"/>
            <input name="email" type="user-provided" required="true" description="Email address"/>
            <input name="role" type="user-provided" required="true" description="Role in the project or organization"/>
            <input name="project_start_date" type="user-provided" required="true" description="Project start date (YYYYMMDD)"/>
            <input name="project_end_date" type="user-provided" required="false" description="Project end date (YYYYMMDD or 'Ongoing')"/>
            <input name="contact_guidance" type="user-provided" required="true" description="When to contact this person and for what"/>
            <input name="areas_of_expertise" type="user-provided" required="true" description="Areas of expertise (with proficiency levels if known)"/>
            <input name="project_responsibilities" type="user-provided" required="true" description="Project responsibilities"/>
            <input name="preferred_contact_methods" type="user-provided" required="true" description="Preferred contact methods (urgent vs. non-urgent)"/>
            <input name="working_hours" type="user-provided" required="true" description="Working hours/time zone"/>
            <input name="notes" type="user-provided" required="false" description="Additional notes (working style, preferences, etc.)"/>
        </inputs>
        <outputs>
            <output name="person_record_file" type="file" format="markdown" description="New person record file created in [id:peoples_dir] following the template and naming conventions"/>
            <output name="people_register_entry" type="file" format="markdown" description="Entry added to [id:people-register]"/>
            <output name="changelog_entry" type="file" format="markdown" description="Changelog entry for new person record creation"/>
        </outputs>
    </context>
    <workBreakdownStructure>
        <phase id="1" name="Information Gathering">
            <delivers>All required person information collected from user</delivers>
            <actions>
                <action id="1.1" name="Prompt for person information" protocol="act">
                    <goal>Collect all required fields for the person record</goal>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Person Record Creation">
            <delivers>Person record file created and populated</delivers>
            <actions>
                <action id="2.1" name="Generate Person File Name" protocol="act">
                    <goal>Generate unique file name in format role-name-YYYYMMDDHHmm.md</goal>
                </action>
                <action id="2.2" name="Create person record file" protocol="act">
                    <goal>Create and populate the person record file using the template</goal>
                </action>
            </actions>
        </phase>
        <phase id="3" name="Register and Changelog Update">
            <delivers>Register and changelog updated</delivers>
            <actions>
                <action id="3.1" name="Update people register" protocol="act">
                    <goal>Add entry to [id:people-register], creating it if necessary</goal>
                </action>
                <action id="3.2" name="Add changelog entry" protocol="act">
                    <goal>Add documentation changelog entry for new person record</goal>
                </action>
            </actions>
        </phase>
        <phase id="4" name="Confirmation">
            <delivers>User confirmation and file path provided</delivers>
            <actions>
                <action id="4.1" name="Confirm creation" protocol="act">
                    <goal>Confirm to user that the person record has been created and provide the file path</goal>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
    <references>
        <reference id="people-template" type="file" path="[id:people-template]"/>
        <reference id="people-dir" type="directory" path="[id:peoples_dir]"/>
        <reference id="people-register" type="file" path="[id:people-register]"/>
    </references>
</prompt>
```
