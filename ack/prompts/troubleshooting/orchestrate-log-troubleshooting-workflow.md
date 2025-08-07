---
name: orchestrate-log-troubleshooting-workflow
description: End-to-end troubleshooting workflow that combines automated log-to-source mapping with guided analysis for rapid issue resolution
tags: [troubleshooting, orchestrator, logs, debugging, source-mapping, workflow]
---

# Log Troubleshooting Orchestrator

## Workflow Type
Master/Orchestrator - Combines automated script execution with guided analysis workflow

## Workflow Overview
Provides comprehensive troubleshooting capabilities by first generating log-to-source mappings automatically, then guiding users through structured analysis to identify root causes and solutions.

## Prerequisites
- Access to codebase requiring troubleshooting
- PowerShell execution permissions
- Log files containing error traces or suspicious patterns
- Issue description or specific symptoms

## Input Requirements
- **Primary Input:** Codebase path and issue description
- **Configuration Input:** Log file path, file extensions to scan, specific log entries of concern
- **Input Format:** Paths and descriptive text

## Output Specifications
- **Orchestrator Log:** `log-troubleshooting-orchestrator-log-YYYYMMDD-NNN.json`
- **Final Consolidated Output:** `troubleshooting-analysis-consolidated-YYYYMMDD-NNN.md`
- **Sub-workflow Outputs:** Log-source mapping JSON, structured troubleshooting analysis
- **Output Location:** [id:findings_dir]

## Sub-Workflow Chain

### Sub-Workflow 1: Log Priority Analysis
- **Type:** Script Execution
- **Script:** `[id:tools_dir]troubleshooting/analyze-log-priorities.ps1`
- **Input Requirements:**
  - Primary: Log file path (mandatory)
  - Optional: Time range, maximum results, custom severity patterns
- **Output Produced:** `log-priorities-analysis-YYYYMMDD-NNN.json`
- **Description:** Parses log file to identify and prioritize critical errors, warnings, and exceptions with frequency analysis
- **Success Criteria:** Priority analysis file generated with categorized issues and severity rankings
- **Failure Handling:** Verify log file exists and is readable, adjust severity patterns, provide sample data format

### Sub-Workflow 2: User Issue Selection
- **Type:** Interactive Selection
- **Interface:** Priority analysis results presentation
- **Input Requirements:**
  - Primary: Priority analysis results from Sub-Workflow 1
  - User input: Selected issue indices or patterns to investigate
- **Output Produced:** `selected-issues-YYYYMMDD-NNN.json`
- **Description:** Presents prioritized issues to user for selection, focusing subsequent analysis on critical problems
- **Success Criteria:** User selects one or more high-priority issues for detailed investigation
- **Failure Handling:** If no selection made, default to top 3 critical issues, allow re-selection with different criteria

### Sub-Workflow 3: Targeted Log-Source Mapping
- **Type:** Script Execution
- **Script:** `[id:tools_dir]troubleshooting/analyze-log-source-mapping.ps1`
- **Input Requirements:**
  - Primary: Codebase path (mandatory)
  - Filtering: Selected issues from Sub-Workflow 2 to focus mapping
  - Optional: Custom file extensions, output path
- **Output Produced:** `targeted-log-source-mapping-YYYYMMDD-NNN.json`
- **Description:** Scans codebase for logging statements related to selected issues, creating focused mapping between specific log entries and source code locations
- **Success Criteria:** Targeted mapping file generated with source locations for selected issues
- **Failure Handling:** Verify codebase path exists, expand search patterns if no matches found, fallback to broader mapping

### Sub-Workflow 4: Guided Troubleshooting Analysis
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]troubleshooting/troubleshoot-logs-to-sources.md`
- **Input Requirements:**
  - Primary: Targeted log-source mapping file from Sub-Workflow 3
  - Additional: Selected priority issues from Sub-Workflow 2, issue description, time range
- **Output Produced:** `focused-troubleshooting-analysis-YYYYMMDD-NNN.md`
- **Description:** Uses targeted mapping data to guide structured analysis of selected critical issues, identify root causes, and recommend specific fixes
- **Success Criteria:** Complete troubleshooting analysis focused on selected issues with root cause identification and actionable recommendations
- **Failure Handling:** Validate mapping file format, request additional log context, escalate to expert contact lookup if issues remain unresolved

## Data Flow and Dependencies

```
Issue Description + Codebase Path → PowerShell Script Execution
                    ↓
            Log-Source Mapping JSON
                    ↓
        Guided Troubleshooting Analysis
                    ↓
     Consolidated Troubleshooting Report
```

## Orchestrator Execution Steps

### Step 1: Initialize Troubleshooting Session
1. Gather required inputs from user:
   - Codebase path (mandatory)
   - Issue description or symptoms
   - Log file path (if available)
   - Time range of issue occurrence
2. Validate codebase path exists and is accessible
3. Create working directory in `[id:findings_dir]`
4. User approval checkpoint: "Proceed with log-source mapping generation?"

### Step 2: Execute Log-Source Mapping Script
1. Construct PowerShell command with provided parameters:
   ```powershell
   .\analyze-log-source-mapping.ps1 -CodebasePath "path" -LogFile "logfile" -OutputPath "mapping.json"
   ```
2. Execute script in background with progress monitoring
3. Validate generated mapping file for completeness
4. Display mapping summary (files scanned, log statements found, patterns identified)
5. User approval checkpoint: "Mapping complete. Proceed with guided analysis?"

### Step 3: Load Troubleshooting Analysis Workflow
1. Initialize `[id:prompts_dir]troubleshooting/troubleshoot-logs-to-sources.md` workflow
2. Pass generated mapping file as primary input
3. Include user-provided issue description and log entries
4. Set up structured analysis environment
5. Begin guided troubleshooting process

### Step 4: Structured Issue Analysis
1. Load and validate log-source mapping data
2. Guide user through log entry investigation
3. Correlate log patterns with source code locations
4. Identify problematic data patterns and edge cases
5. Generate root cause analysis with confidence levels
6. User approval checkpoint: "Analysis complete. Generate recommendations?"

### Step 5: Solution Generation and Consolidation
1. Generate fix recommendations with code examples
2. Create implementation plan with testing steps
3. Consolidate all findings into comprehensive report
4. Cross-reference mapping data with analysis results
5. Provide executive summary with priority actions

## Quality Gates
- PowerShell script must complete successfully with valid mapping output
- Mapping file must contain source code correlations for log patterns
- User approval required before proceeding to analysis phase
- Troubleshooting analysis must identify at least one potential root cause
- Final report must include actionable recommendations with code examples

## Error Handling
- **Script Execution Failure:** Check PowerShell permissions, validate paths, retry with verbose logging
- **Mapping Generation Issues:** Adjust file extension filters, verify logging patterns in codebase
- **Analysis Workflow Failure:** Validate mapping file format, request additional log context
- **User Rejection:** Allow selective re-execution of specific phases with modified parameters

## Interactive Checkpoints

### Checkpoint 1: Pre-Execution Validation
**User Input Required:**
- Confirm codebase path is correct
- Verify log file accessibility (if provided)
- Approve estimated execution time

### Checkpoint 2: Mapping Review
**User Input Required:**
- Review mapping statistics and coverage
- Confirm log patterns detected are relevant
- Decide whether to proceed with current mapping or refine parameters

### Checkpoint 3: Analysis Direction
**User Input Required:**
- Specify which log entries or patterns to focus on
- Confirm issue description accuracy
- Set analysis priorities (performance, errors, data issues)

### Checkpoint 4: Solution Approval
**User Input Required:**
- Review proposed root causes and confidence levels
- Approve recommended fixes for implementation
- Confirm testing approach and timeline

## Success Metrics
- Complete log-to-source mapping with high pattern coverage
- Root cause identification with high confidence level
- Actionable fix recommendations with implementation details
- Reduction in time from symptom to solution identification
- User satisfaction with troubleshooting effectiveness

## Follow-up Actions
- Schedule implementation of recommended fixes
- Set up monitoring for identified issue patterns
- Update logging practices based on analysis findings
- Create knowledge base entries for recurring issues
- Plan preventive measures and code quality improvements

## Integration Points
- **Contact Lookup:** Can invoke `[id:prompts_dir]other-users/find-expert-contact.md` for escalation
- **Code Review:** May recommend code review workflow for identified problematic areas
- **Documentation:** Can generate decision records for significant architectural findings
- **Monitoring:** May suggest alerts and monitoring improvements based on analysis
