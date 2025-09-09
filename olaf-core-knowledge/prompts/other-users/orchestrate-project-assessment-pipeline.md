---
name: orchestrate-project-assessment-pipeline
description: End-to-end business analyst workflow from requirements analysis through test planning
tags: [business-analysis, orchestrator, requirements, technical-stack, functional-spec, test-planning]
---

# Business Analyst Project Assessment Pipeline

## Workflow Type
Master/Orchestrator - Chains and coordinates complete sub-workflows and prompts in sequence

## Workflow Overview
Provides comprehensive project assessment capabilities for business analysts by orchestrating requirements analysis, technical evaluation, functional specification creation, and test planning in an integrated pipeline.

## Prerequisites
- Access to project codebase or requirements documentation
- Stakeholder availability for requirements clarification
- Project scope defined at high level

## Input Requirements
- **Primary Input:** Project context (codebase path, initial requirements, or project description)
- **Configuration Input:** Analysis depth preferences, stakeholder contact information
- **Input Format:** Text description or path to project materials

## Output Specifications
- **Orchestrator Log:** `business-analyst-pipeline-log-YYYYMMDD-NNN.json`
- **Final Consolidated Output:** `project-assessment-consolidated-YYYYMMDD-NNN.md`
- **Sub-workflow Outputs:** Requirements analysis, technical stack analysis, functional specification, test plan
- **Output Location:** [id:findings_dir]

## Sub-Workflow Chain

### Sub-Workflow 1: Business Requirements Analysis
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]analyze-business-requirements.md`
- **Input Requirements:**
  - Primary: Project context and initial requirements
  - From Previous: None (starting workflow)
- **Output Produced:** `requirements-analysis-report-YYYYMMDD-NNN.md`
- **Description:** Analyzes and documents business requirements, stakeholder needs, and success criteria
- **Success Criteria:** Complete requirements analysis with stakeholder validation
- **Failure Handling:** Request additional requirements gathering session with stakeholders

### Sub-Workflow 2: Technical Stack Analysis
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]analyze-technical-stack.md`
- **Input Requirements:**
  - Primary: Project codebase or technical context
  - From Previous: Requirements analysis for technical constraints and preferences
- **Output Produced:** `technical-stack-analysis-YYYYMMDD-NNN.md`
- **Description:** Evaluates current and recommended technical architecture, dependencies, and capabilities
- **Success Criteria:** Complete technical assessment with architecture recommendations
- **Failure Handling:** Escalate to technical lead for additional technical context

### Sub-Workflow 3: Functional Specification Creation
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]bootstrap-functional-spec-from-code.md`
- **Input Requirements:**
  - Primary: Project codebase and technical stack analysis
  - From Previous: Business requirements and technical constraints
- **Output Produced:** `functional-specification-YYYYMMDD-NNN.md`
- **Description:** Creates comprehensive functional specification bridging business requirements and technical implementation
- **Success Criteria:** Complete functional spec approved by business and technical stakeholders
- **Failure Handling:** Iterate with stakeholders to resolve functional gaps

### Sub-Workflow 4: Test Plan Generation
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]generate-test-plan.md`
- **Input Requirements:**
  - Primary: Functional specification from Sub-Workflow 3
  - From Previous: Requirements analysis and technical constraints
- **Output Produced:** `test-plan-YYYYMMDD-NNN.md`
- **Description:** Generates comprehensive test strategy and detailed test cases based on functional requirements
- **Success Criteria:** Complete test plan with test cases, data requirements, and execution schedule
- **Failure Handling:** Review functional specification for testability gaps

## Data Flow and Dependencies

```
Business Requirements → Technical Stack Analysis
        ↓                        ↓
        └──→ Functional Specification ←──┘
                      ↓
                 Test Plan
```

## Orchestrator Execution Steps

### Step 1: Initialize Pipeline
1. Load and execute `[id:prompts_dir]analyze-business-requirements.md`
2. Wait for completion and validate output
3. Store requirements analysis results
4. User approval checkpoint: "Proceed with technical analysis?"

### Step 2: Technical Assessment
1. Load and execute `[id:prompts_dir]analyze-technical-stack.md`
2. Pass requirements context as input
3. Wait for completion and validate output
4. Store technical analysis results
5. User approval checkpoint: "Proceed with functional specification?"

### Step 3: Functional Specification
1. Load and execute `[id:prompts_dir]bootstrap-functional-spec-from-code.md`
2. Pass both requirements and technical analysis as context
3. Wait for completion and validate output
4. Store functional specification
5. User approval checkpoint: "Proceed with test planning?"

### Step 4: Test Planning
1. Load and execute `[id:prompts_dir]generate-test-plan.md`
2. Pass functional specification and requirements as context
3. Wait for completion and validate output
4. Store test plan

### Step 5: Consolidation
1. Generate consolidated project assessment report
2. Cross-reference all outputs for consistency
3. Highlight any gaps or conflicts between phases
4. Provide executive summary with recommendations

## Quality Gates
- Each sub-workflow must complete successfully before proceeding
- User approval required between major phases
- Consistency validation between outputs
- Stakeholder sign-off on final consolidated assessment

## Error Handling
- **Sub-workflow Failure:** Log error, provide context to user, offer retry or manual intervention
- **Validation Failure:** Highlight inconsistencies, request clarification, iterate affected sub-workflows
- **User Rejection:** Allow selective re-execution of specific sub-workflows

## Success Metrics
- Complete requirements traceability from business needs to test cases
- Stakeholder approval on all deliverables
- Technical feasibility confirmed
- Test coverage aligned with business priorities

## Follow-up Actions
- Schedule stakeholder review sessions
- Create implementation roadmap based on findings
- Establish change management process for requirements evolution
- Set up progress tracking for implementation phase
