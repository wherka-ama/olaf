Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Evolve Code Iteratively</promptName>
        <typeOfPrompt>generation</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <context>
        <objective>Incrementally improve code based on specific goals (performance, maintainability, testability) using a structured, iterative approach.</objective>
        <inputs>
            <input name="code" type="user-provided" required="true" description="The code to be analyzed and evolved"/>
            <input name="primary_goals" type="user-provided" required="true" description="Primary goals: Performance, Maintainability, Testability (one or more)"/>
        </inputs>
        <outputs>
            <output name="iteration_report" type="llm-generated" format="markdown" description="Detailed report for each iteration including critique, options, analysis, recommendation, and assessment"/>
            <output name="final_code" type="llm-generated" format="code" description="The evolved code after all approved iterations"/>
        </outputs>
    </context>
    <workBreakdownStructure>
        <phase id="1" name="Initial Assessment">
            <delivers>Baseline understanding and metrics for the code</delivers>
            <actions>
                <action id="1.1" name="Code Analysis" protocol="act">
                    <goal>Analyze code structure, patterns, anti-patterns, and dependencies</goal>
                </action>
                <action id="1.2" name="Goal Alignment" protocol="act">
                    <goal>Clarify and document primary optimization goals</goal>
                </action>
                <action id="1.3" name="Establish Baseline Metrics" protocol="act">
                    <goal>Measure and document baseline metrics for the selected goals</goal>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Iterative Improvement">
            <delivers>Incremental improvements to the code</delivers>
            <actions>
                <action id="2.1" name="Current State Critique" protocol="act">
                    <goal>Critique current code against goals and identify issues</goal>
                </action>
                <action id="2.2" name="Dual Solution Proposal" protocol="act">
                    <goal>Present two distinct approaches to address issues</goal>
                </action>
                <action id="2.3" name="Comparative Analysis" protocol="act">
                    <goal>Analyze and compare both options</goal>
                </action>
                <action id="2.4" name="Recommendation & Signoff" protocol="act">
                    <goal>Recommend an option and request user approval</goal>
                </action>
                <action id="2.5" name="Iteration Assessment" protocol="act">
                    <goal>Reassess metrics and document improvements after implementation</goal>
                </action>
            </actions>
        </phase>
        <phase id="3" name="Termination">
            <delivers>Explicit stopping point for the iterative process</delivers>
            <actions>
                <action id="3.1" name="Termination Criteria" protocol="act">
                    <goal>Determine if further iterations are warranted based on improvement and goals</goal>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
</prompt>
```
