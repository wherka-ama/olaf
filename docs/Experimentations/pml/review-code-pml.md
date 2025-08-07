Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Review Code</promptName>
        <typeOfPrompt>analysis</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <context>
        <objective>Guide the process of performing a detailed code review with a focus on quality, security, and maintainability.</objective>
        <inputs>
            <input name="code_changes" type="user-provided" required="true" description="Code or code changes to be reviewed"/>
        </inputs>
        <outputs>
            <output name="review_findings" type="llm-generated" format="markdown" description="Formatted code review findings using the code-review-template"/>
            <output name="best_practice" type="llm-generated" format="markdown" description="Best practice recommendation using the practice-template"/>
        </outputs>
    </context>
    <workBreakdownStructure>
        <phase id="1" name="Detailed Code Examination">
            <delivers>Thorough review of code changes</delivers>
            <actions>
                <action id="1.1" name="High-Level Overview" protocol="act">
                    <goal>Summarize code purpose, scope, and fulfillment</goal>
                </action>
                <action id="1.2" name="Code Quality Assessment" protocol="act">
                    <goal>Assess structure, standards, error handling, performance, readability, and documentation</goal>
                </action>
                <action id="1.3" name="Functional Correctness" protocol="act">
                    <goal>Check for logic errors, edge cases, race conditions, and validation</goal>
                </action>
                <action id="1.4" name="Security Review" protocol="act">
                    <goal>Identify security vulnerabilities and risks</goal>
                </action>
                <action id="1.5" name="Testing Adequacy" protocol="act">
                    <goal>Evaluate test coverage and quality</goal>
                </action>
                <action id="1.6" name="Documentation" protocol="act">
                    <goal>Review code comments, README, and API docs</goal>
                </action>
                <action id="1.7" name="Specific Recommendations" protocol="act">
                    <goal>Provide actionable feedback and improvement suggestions</goal>
                </action>
                <action id="1.8" name="Positive Feedback" protocol="act">
                    <goal>Acknowledge good practices and elegant solutions</goal>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Document Findings">
            <delivers>Code review findings and documentation</delivers>
            <actions>
                <action id="2.1" name="Format findings" protocol="act">
                    <goal>Format findings using the code-review-template and propose file creation</goal>
                </action>
            </actions>
        </phase>
        <phase id="3" name="Propose Best Practice">
            <delivers>Best practice recommendation for the team</delivers>
            <actions>
                <action id="3.1" name="Prepare best practice" protocol="act">
                    <goal>Prepare and propose best practice using the practice-template</goal>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
    <references>
        <reference id="practices_dir" type="directory" path="[id:practices_dir]"/>
        <reference id="templates_dir" type="directory" path="[id:templates_dir]"/>
        <reference id="code_reviews_dir" type="directory" path="[id:code_reviews_dir]"/>
    </references>
</prompt>
```
