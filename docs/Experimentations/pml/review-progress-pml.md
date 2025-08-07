---
title: Review Progress (PML)
description: Embedded PML prompt for the Review Progress competency, with XML content for use in prompt-driven workflows.
tags: [review, progress, planning, assessment, pml, xml, prompt]
---

# Review Progress (PML) Prompt

The following is an embedded Prompt Markup Language (PML) XML definition for the Review Progress competency. Use this as a structured prompt for progress review workflows.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Review Progress (PML)</promptName>
        <typeOfPrompt>generation</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <context>
        <objective>Guide the process of conducting a comprehensive work review to assess progress, identify accomplishments, and plan upcoming priorities, based on the workflow and prompt in review-progress.md and review-progress.md.</objective>
        <inputs>
            <input name="review_period" type="user-provided" required="true" description="The time period to review (e.g., past 7 days)">Time period for the review</input>
            <input name="focus_areas" type="user-provided" required="false" description="Specific project areas or metrics to focus on">Optional focus areas</input>
        </inputs>
        <outputs>
            <output name="progress_review_document" type="llm-generated" format="markdown" description="A comprehensive progress review document, following the template and structure defined in the workflow and prompt.">Progress review report</output>
        </outputs>
    </context>
    <outcomes>
        <expected>All significant work from the review period is documented</expected>
        <expected>Accomplishments, challenges, and priorities are clearly stated</expected>
        <expected>Document is well-structured, actionable, and saved in the correct location</expected>
    </outcomes>
    <workBreakdownStructure>
        <phase id="1" name="Preparation Phase">
            <delivers>All relevant documents and review parameters are gathered</delivers>
            <actions>
                <action id="1.1" name="Gather Documents and Define Review Period" protocol="act">
                    <goal>Collect all necessary documents and define the review period</goal>
                    <steps>
                        <step id="1.1.1">Gather relevant documents, task lists, and project status information</step>
                        <step id="1.1.2">Define the exact review period (start and end dates)</step>
                        <step id="1.1.3">Set aside dedicated time for thorough review</step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Review Execution">
            <delivers>Comprehensive review of work completed</delivers>
            <actions>
                <action id="2.1" name="Follow Master Prompt Instructions" protocol="act">
                    <goal>Execute the review as per the master prompt</goal>
                    <steps>
                        <step id="2.1.1">Follow the detailed instructions in review-progress.md</step>
                        <step id="2.1.2">Use the output template provided in the prompt to structure findings</step>
                        <step id="2.1.3">Be honest and comprehensive in assessment</step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="3" name="Documentation">
            <delivers>Progress review document completed and saved</delivers>
            <actions>
                <action id="3.1" name="Complete and Save Review" protocol="act">
                    <goal>Document findings and save the review</goal>
                    <steps>
                        <step id="3.1.1">Complete the template with specific, actionable information</step>
                        <step id="3.1.2">Save the review with a dated filename for future reference</step>
                        <step id="3.1.3">Share with relevant stakeholders if required</step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="4" name="Action Planning">
            <delivers>Action items and updated project plans</delivers>
            <actions>
                <action id="4.1" name="Identify and Plan Actions" protocol="act">
                    <goal>Identify actions based on review findings and update plans</goal>
                    <steps>
                        <step id="4.1.1">Identify specific actions based on review findings</step>
                        <step id="4.1.2">Update project plans and priorities as needed</step>
                        <step id="4.1.3">Schedule follow-up activities or meetings</step>
                    </steps>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
    <constraints>
        <constraint>Strictly follow instructions in the workflow and prompt</constraint>
        <constraint>Do not assume or invent information</constraint>
        <constraint>Ask for additional information if needed</constraint>
    </constraints>
    <references>
        <reference path="/PML/pml.xsd" description="Prompt Markup Language schema"/>
    </references>
</prompt>
```
