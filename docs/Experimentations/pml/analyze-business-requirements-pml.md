Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Analyze Business Requirements (Generated)</promptName>
        <typeOfPrompt>analysis</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <context>
        <objective>Guide the process of reviewing a business requirements document to identify potential issues and generate clarifying questions. This prompt was generated using the meta workflow for enhanced structure and traceability.</objective>
        <inputs>
            <input name="requirements_document" type="user-provided" required="true" description="The business requirements document to analyze"/>
        </inputs>
        <outputs>
            <output name="analysis_report" type="llm-generated" format="markdown" description="A markdown-formatted report following the official requirements analysis template ([id:templates_dir]requirements-analysis-report-template.md)"/>
        </outputs>
    </context>
    <outcomes>
        <expected>Requirements document is read and analyzed in full</expected>
        <expected>Best practices are consulted for analysis</expected>
        <expected>Issues are identified and categorized (ambiguity, incompleteness, lack of testability)</expected>
        <expected>Constructive clarifying questions are generated for each issue</expected>
        <expected>Output report strictly follows the official template</expected>
    </outcomes>
    <workBreakdownStructure>
        <phase id="1" name="Source Analysis">
            <delivers>Understanding of the requirements document</delivers>
            <onFailure>Request user to provide a valid requirements document</onFailure>
            <actions>
                <action id="1.1" name="Read and analyze requirements document" protocol="act">
                    <goal>Extract content and structure from the requirements document</goal>
                    <inputs>
                        <input name="requirements_document" type="user-provided" required="true" description="Path to requirements document"/>
                    </inputs>
                    <verification>Requirements document content is successfully read and understood</verification>
                    <steps>
                        <step id="1.1.1">
                            <do>Read the requirements document content</do>
                            <use>File reading capabilities</use>
                            <produce>Raw content of the requirements document</produce>
                        </step>
                        <step id="1.1.2">
                            <do>Analyze the document structure and identify key requirements</do>
                            <use>Requirements document content</use>
                            <produce>Structured understanding of requirements and potential issues</produce>
                        </step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Best Practices Consultation">
            <delivers>Analysis framework based on best practices</delivers>
            <onFailure>Warn user if best practice guides are missing</onFailure>
            <actions>
                <action id="2.1" name="Consult best practice guides" protocol="act">
                    <goal>Apply best practices to requirements analysis</goal>
                    <inputs>
                        <input name="best_practices" type="reference" required="true" description="Best practice guides for requirements analysis"/>
                    </inputs>
                    <verification>Best practices are referenced and applied</verification>
                    <steps>
                        <step id="2.1.1">
                            <do>Read and apply [id:practices_dir]expressing-business-needs-to-developers.md</do>
                        </step>
                        <step id="2.1.2">
                            <do>Read and apply [id:practices_dir]reviewing-business-requirements-for-dev-and-test.md</do>
                        </step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="3" name="Issue Identification and Question Generation">
            <delivers>List of issues and clarifying questions</delivers>
            <onFailure>Warn user if no issues are found</onFailure>
            <actions>
                <action id="3.1" name="Identify and categorize issues" protocol="act">
                    <goal>Find ambiguity, incompleteness, and lack of testability</goal>
                    <inputs>
                        <input name="requirements_document" type="llm-generated" required="true" description="Analyzed requirements content"/>
                        <input name="best_practices" type="reference" required="true" description="Best practice guides"/>
                    </inputs>
                    <verification>Issues are identified and categorized</verification>
                    <steps>
                        <step id="3.1.1">
                            <do>Identify ambiguous, incomplete, or untestable requirements</do>
                        </step>
                        <step id="3.1.2">
                            <do>For each issue, generate a constructive clarifying question referencing the relevant section</do>
                        </step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="4" name="Report Generation">
            <delivers>Markdown report following the official template</delivers>
            <onFailure>Warn user if template is missing</onFailure>
            <actions>
                <action id="4.1" name="Generate analysis report" protocol="act">
                    <goal>Produce a markdown report using the official template</goal>
                    <inputs>
                        <input name="issues_and_questions" type="llm-generated" required="true" description="List of issues and questions"/>
                        <input name="template" type="reference" required="true" description="Official requirements analysis report template"/>
                    </inputs>
                    <verification>Report strictly follows the template</verification>
                    <steps>
                        <step id="4.1.1">
                            <do>Fill in the template with identified issues and questions</do>
                        </step>
                        <step id="4.1.2">
                            <do>Output the completed report in markdown format</do>
                        </step>
                    </steps>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
    <references>
        <reference id="practices_dir" type="directory" path="[id:practices_dir]"/>
        <reference id="templates_dir" type="directory" path="[id:templates_dir]"/>
    </references>
</prompt>
```
