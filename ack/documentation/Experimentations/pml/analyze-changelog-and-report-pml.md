Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Changelog Register Analysis and Discrepancy Reporting</promptName>
        <typeOfPrompt>analysis-reporting</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <context>
        <objective>Analyze changelog register entries since a given start date, cross-reference with prompt files (-pml.md), identify discrepancies, allow user resolution, and generate a summary report.</objective>
        <inputs>
            <input name="start_date" type="user-provided" required="true" description="Start date in YYYYMMDD format for changelog analysis"/>
        </inputs>
        <outputs>
            <output name="summary_report" type="file" format="markdown" description="Summary report of work done, saved in [id:findings_dir]ChangelogSummaries/ with a timestamped filename"/>
        </outputs>
    </context>
    <workBreakdownStructure>
        <phase id="1" name="User Input">
            <delivers>Start date for analysis</delivers>
            <actions>
                <action id="1.1" name="Prompt for start date" protocol="act">
                    <goal>Obtain start date from user</goal>
                    <inputs>
                        <input name="start_date" type="user-provided" required="true"/>
                    </inputs>
                    <verification>Start date is in YYYYMMDD format</verification>
                    <steps>
                        <step id="1.1.1">
                            <do>Prompt the user to provide a start date in YYYYMMDD format</do>
                            <produce>Start date value</produce>
                        </step>
                        <step id="1.1.2">
                            <do>Validate the format of the provided date</do>
                            <produce>Confirmed valid start date</produce>
                        </step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Changelog Register Extraction">
            <delivers>Parsed changelog register entries</delivers>
            <actions>
                <action id="2.1" name="Read changelog register" protocol="act">
                    <goal>Read and parse [id:changelog_register] for entries</goal>
                    <inputs>
                        <input name="changelog_file" type="file" required="true"/>
                    </inputs>
                    <verification>Entries are parsed with date, type, and description</verification>
                    <steps>
                        <step id="2.1.1">
                            <do>Read the entire content of the changelog file [id:changelog_register]</do>
                            <produce>Raw changelog content</produce>
                        </step>
                        <step id="2.1.2">
                            <do>Parse the content to extract entries by date, type, and description</do>
                            <produce>Structured list of changelog entries</produce>
                        </step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="3" name="Prompt File Listing and Discrepancy Analysis">
            <delivers>Discrepancy analysis between changelog and prompt files</delivers>
            <actions>
                <action id="3.1" name="List prompt files" protocol="act">
                    <goal>List all prompt files with -pml.md extension in [id:prompts_dir]</goal>
                    <inputs>
                        <input name="prompts_dir" type="file" required="true"/>
                    </inputs>
                    <verification>Prompt file list is obtained</verification>
                    <steps>
                        <step id="3.1.1">
                            <do>Search for all files with the -pml.md extension in [id:prompts_dir]</do>
                            <produce>List of prompt files (-pml.md)</produce>
                        </step>
                    </steps>
                </action>
                <action id="3.2" name="Cross-reference and identify discrepancies" protocol="act">
                    <goal>Identify discrepancies between changelog entries and prompt files</goal>
                    <inputs>
                        <input name="prompt_files" type="llm-generated" required="true"/>
                        <input name="changelog_entries" type="llm-generated" required="true"/>
                    </inputs>
                    <verification>Discrepancies are identified</verification>
                    <steps>
                        <step id="3.2.1">
                            <do>For each changelog entry, check if it relates to a prompt file. If not, list as: 'Changelog entry ... seems to lack a corresponding prompt file.'</do>
                            <produce>List of changelog entries missing prompt files</produce>
                        </step>
                        <step id="3.2.2">
                            <do>For each prompt file, check if it is referenced in any changelog entry since the start date. If not, list as: 'Prompt file ... does not appear to be referenced in changelog entries since [start date].'</do>
                            <produce>List of prompt files not referenced in changelog</produce>
                        </step>
                        <step id="3.2.3">
                            <do>Compile a consolidated list of all identified discrepancies</do>
                            <produce>Consolidated discrepancy list</produce>
                        </step>
                    </steps>
                </action>
                <action id="3.3" name="Present discrepancies and user interaction" protocol="act">
                    <goal>Present discrepancies to user and offer actionable options</goal>
                    <inputs>
                        <input name="discrepancy_list" type="llm-generated" required="true"/>
                    </inputs>
                    <verification>User decisions are collected for each discrepancy</verification>
                    <steps>
                        <step id="3.3.1">
                            <do>Present each discrepancy to the user with options: [1] Create new prompt, [2] Link to existing prompt, [3] Acknowledge and ignore</do>
                            <produce>User decisions for each discrepancy</produce>
                        </step>
                        <step id="3.3.2">
                            <do>Act on user decisions (invoke workflows or note acknowledgment)</do>
                            <produce>Updated changelog entries and/or prompt files as needed</produce>
                        </step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="4" name="Generate and Save Summary Report">
            <delivers>Summary report of work done</delivers>
            <actions>
                <action id="4.1" name="Generate summary report" protocol="act">
                    <goal>Generate a summary report of filtered changelog entries, grouped by type/theme</goal>
                    <inputs>
                        <input name="filtered_changelog_entries" type="llm-generated" required="true"/>
                    </inputs>
                    <verification>Summary report is generated</verification>
                    <steps>
                        <step id="4.1.1">
                            <do>Group changelog entries by type/theme and format into a summary</do>
                            <produce>Formatted summary report</produce>
                        </step>
                    </steps>
                </action>
                <action id="4.2" name="Save summary report" protocol="act">
                    <goal>Save the summary report to [id:findings_dir]ChangelogSummaries/ with a timestamped filename</goal>
                    <inputs>
                        <input name="summary_report" type="llm-generated" required="true"/>
                    </inputs>
                    <verification>Summary report is saved to the correct location</verification>
                    <steps>
                        <step id="4.2.1">
                            <do>Determine current date/time and construct output filename</do>
                            <produce>Output filename</produce>
                        </step>
                        <step id="4.2.2">
                            <do>Save the summary report to the target directory and filename</do>
                            <produce>Saved summary report file</produce>
                        </step>
                    </steps>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
</prompt>
```
