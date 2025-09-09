Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Generate Questionnaire</promptName>
        <typeOfPrompt>generation</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <context>
        <objective>Guide the process of generating a questionnaire, including purpose, drafting, structuring, review, and output formatting.</objective>
        <inputs>
            <input name="purpose" type="user-provided" required="true" description="Primary goal of the questionnaire (e.g., feedback, assessment)"/>
            <input name="audience" type="user-provided" required="true" description="Target audience for the questionnaire"/>
            <input name="question_types" type="user-provided" required="false" description="Preferred question types (open-ended, multiple-choice, Likert, etc.)"/>
            <input name="sections" type="user-provided" required="false" description="Logical sections for grouping questions"/>
        </inputs>
        <outputs>
            <output name="questionnaire_markdown" type="llm-generated" format="markdown" description="Well-structured questionnaire document"/>
        </outputs>
    </context>
    <workBreakdownStructure>
        <phase id="1" name="Purpose and Audience Definition">
            <delivers>Clear purpose and audience for the questionnaire</delivers>
            <actions>
                <action id="1.1" name="Define purpose and audience" protocol="act">
                    <goal>Confirm main goal and target audience</goal>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Drafting Questions">
            <delivers>Drafted questions based on purpose</delivers>
            <actions>
                <action id="2.1" name="Generate questions" protocol="act">
                    <goal>Draft questions using a mix of types as appropriate</goal>
                </action>
            </actions>
        </phase>
        <phase id="3" name="Structuring and Formatting">
            <delivers>Questionnaire grouped and formatted for readability</delivers>
            <actions>
                <action id="3.1" name="Group and format questions" protocol="act">
                    <goal>Group questions into sections, add introduction, and format for clarity</goal>
                </action>
            </actions>
        </phase>
        <phase id="4" name="Review and Refinement">
            <delivers>Reviewed and refined questionnaire</delivers>
            <actions>
                <action id="4.1" name="Present draft and incorporate feedback" protocol="act">
                    <goal>Present draft to user and refine based on feedback</goal>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
    <references>
        <reference id="product_docs_dir" type="directory" path="[id:product_docs_dir]questionnaires/"/>
    </references>
</prompt>
```
