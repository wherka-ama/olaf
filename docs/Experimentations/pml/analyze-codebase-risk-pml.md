# Analyze Codebase Risk (PML Prompt)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Analyze Codebase Risk</promptName>
        <typeOfPrompt>analysis</typeOfPrompt>
        <dateLastEdited>2025-07-17</dateLastEdited>
        <modelTestedWith>GPT-4</modelTestedWith>
        <preferredProfile>CODE_QUALITY_ANALYST</preferredProfile>
    </metadata>
    <context>
        <objective>Analyze a codebase for complexity, knowledge concentration, and bug fix risks, and provide actionable insights and a prioritized refactoring plan.</objective>
        <!-- All required inputs (codebase location, analysis depth, branch name) are collected directly by the script during execution. No user input is required at the prompt level. -->
        <outputs>
            <output name="risk_analysis_report" type="llm-generated" format="markdown" description="Comprehensive report identifying critical files and risk factors"/>
            <output name="refactoring_plan" type="llm-generated" format="markdown" description="Prioritized refactoring recommendations"/>
            <output name="analysis_summary" type="llm-generated" format="markdown" description="Executive summary of findings"/>
        </outputs>
    </context>
    <outcomes>
        <expected>Identification of complex, high-risk, and knowledge-concentrated files</expected>
        <expected>Actionable refactoring plan</expected>
        <expected>Clear summary for stakeholders</expected>
    </outcomes>
    <workBreakdownStructure>
        <phase id="1" name="Execution">
            <delivers>Complete set of analysis reports and configuration summary</delivers>
            <actions>
                <action id="1.1" name="Automated codebase risk analysis" protocol="auto-act">
                    <goal>Execute risk analysis script and generate reports without manual intervention. All input collection is handled by the script.</goal>
                    <steps>
                        <step id="1.1.1"><do>Automatically execute Analyze-CodebaseRisk.ps1 script (script will prompt for and collect all required inputs)</do></step>
                        <step id="1.1.2"><do>Generate and store analysis reports</do></step>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Results Interpretation">
            <delivers>Summary of key findings and next steps</delivers>
            <actions>
                <action id="2.1" name="Automated summarization and interpretation" protocol="auto-act">
                    <goal>Automatically read and interpret analysis results, presenting concise summary and recommendations</goal>
                    <steps>
                        <step id="2.1.1"><do>Automatically read executive summary from generated reports</do></step>
                        <step id="2.1.2"><do>Automatically identify and highlight most critical files</do></step>
                        <step id="2.1.3"><do>Automatically present refactoring plan and next steps</do></step>
                    </steps>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
    <constraints>
        <requirement name="script-execution" description="Must use Analyze-CodebaseRisk.ps1 for analysis"/>
        <requirement name="output-location" description="Reports must be stored in [id:findings_dir]codebase-risk-analysis/[codebase-name]/"/>
        <requirement name="completeness" description="All risk dimensions (complexity, knowledge, bug fixes) must be analyzed"/>
        <requirement name="actionability" description="Recommendations must be practical and prioritized"/>
        <requirement name="naming-convention" description="Filename must be analyze-codebase-risk.xml"/>
    </constraints>
    <references>
        <reference id="powershell-script" type="script" path="./Analyze-CodebaseRisk.ps1"/>
        <reference id="comprehensive-analysis-script" type="script" path="./Invoke-ComprehensiveCodebaseAnalysis.ps1"/>
        <reference id="naming-conventions" type="principle" path="./standards/naming-conventions.md"/>
    </references>
</prompt>
```

---

**Usage Guidance:**

- Use this prompt with a PML-compatible LLM or automation tool.
- Provide the codebase location, analysis depth, and (if needed) branch name as inputs.
- The system will execute the `Analyze-CodebaseRisk.ps1` script, generate reports, and summarize findings.
- Review the generated risk analysis report, refactoring plan, and executive summary for actionable insights.
