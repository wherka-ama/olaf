Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Generate Test Plan</promptName>
        <typeOfPrompt>generation</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <context>
        <objective>Generate a comprehensive and detailed test plan based on a provided functional specification document for an application.</objective>
        <inputs>
            <input name="functional_specification" type="user-provided" required="true" description="Functional Specification Document for the application"/>
            <input name="application_name" type="user-provided" required="true" description="Name of the application under test"/>
        </inputs>
        <outputs>
            <output name="test_plan_markdown" type="llm-generated" format="markdown" description="Well-structured, comprehensive test plan document"/>
        </outputs>
    </context>
    <workBreakdownStructure>
        <phase id="1" name="Input Analysis">
            <delivers>Understanding of the application's requirements and scope</delivers>
            <actions>
                <action id="1.1" name="Analyze functional specification" protocol="act">
                    <goal>Extract all requirements, user roles, business rules, and features</goal>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Test Plan Generation">
            <delivers>Comprehensive test plan covering all aspects of the functional specification</delivers>
            <actions>
                <action id="2.1" name="Scope of Testing" protocol="act">
                    <goal>Define functional, integration, and performance tests</goal>
                </action>
                <action id="2.2" name="Test Case Design" protocol="act">
                    <goal>Design test cases in both human-readable and Gherkin formats</goal>
                </action>
                <action id="2.3" name="Test Data Requirements" protocol="act">
                    <goal>Specify test data for happy path, boundaries, and error conditions</goal>
                </action>
                <action id="2.4" name="Structure and Organization" protocol="act">
                    <goal>Organize test plan by modules, features, and test types</goal>
                </action>
                <action id="2.5" name="Language and Terminology" protocol="act">
                    <goal>Ensure business-oriented language and alignment with specification terminology</goal>
                </action>
            </actions>
        </phase>
        <phase id="3" name="Quality Review">
            <delivers>Test plan meets quality, clarity, and traceability standards</delivers>
            <actions>
                <action id="3.1" name="Review for coverage, clarity, and maintainability" protocol="act">
                    <goal>Ensure all requirements are covered, test cases are clear, and the plan is maintainable</goal>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
</prompt>
```
