Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Bootstrap Functional Specification from Code</promptName>
        <typeOfPrompt>generation</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <context>
        <objective>Analyze the provided source code to extract and describe its functionalities from a business and user perspective, creating a draft functional specification using business terminology and focusing on what the system does.</objective>
        <inputs>
            <input name="source_code" type="user-provided" required="true" description="The source code to analyze for functional specification generation">
                Path to the application's source code or codebase directory
            </input>
        </inputs>
        <outputs>
            <output name="functional_specification" type="llm-generated" format="markdown" description="Draft functional specification in business language">
                Populated template based on [id:templates_dir]functional-specification-template.md
            </output>
        </outputs>
    </context>
    <outcomes>
        <expected>Source code is successfully read and analyzed</expected>
        <expected>Functional specification is generated in business language</expected>
        <expected>Output is structured according to the functional-specification-template</expected>
    </outcomes>
    <workBreakdownStructure>
        <phase id="1" name="Source Analysis">
            <delivers>Understanding of system's business purpose and features</delivers>
            <onFailure>Request user to provide a valid codebase path</onFailure>
            <actions>
                <action id="1.1" name="Read and analyze source code" protocol="act">
                    <goal>Extract business-relevant content and structure from the codebase</goal>
                    <inputs>
                        <input name="source_code" type="user-provided" required="true" description="Path to source code"/>
                    </inputs>
                    <verification>Source code is successfully read and understood</verification>
                    <steps>
                        <step id="1.1.1">
                            <do>Read the source code</do>
                            <use>File reading capabilities</use>
                            <produce>Raw content of the codebase</produce>
                        </step>
                        <step id="1.1.2">
                            <do>Analyze code to identify business purpose, features, user scenarios, business objects, business rules, and UI aspects</do>
                            <use>Source code content</use>
                            <produce>Structured understanding for functional specification</produce>
                        </step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Specification Generation">
            <delivers>Draft functional specification in business language</delivers>
            <onFailure>Request user clarification or additional input</onFailure>
            <actions>
                <action id="2.1" name="Generate functional specification" protocol="act">
                    <goal>Create a draft functional specification using business language and the provided template</goal>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
</prompt>
```
