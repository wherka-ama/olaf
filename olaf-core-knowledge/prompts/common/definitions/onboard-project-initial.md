---
description: Comprehensive project onboarding analysis workflow with 28 analysis areas across 10 phases
---

# Project Onboarding Analysis Workflow

This workflow orchestrates a comprehensive project onboarding analysis with 28 analysis areas organized across 10 phases. It creates separate documentation files for both human review and LLM consumption.

## Prerequisites
- Access to target repository/workspace for analysis
- Python tools available in `olaf-core-knowledge/tools/` directory
- Write access to `olaf-data-store/product/context/{repository-name}/` directory

## Initial Session Setup

### 1. Check for Existing Task List
- Look for `olaf-onboarding-tasklist.md` in `olaf-data-store/product/` folder
- If task list exists:
  - Read the task list to determine next pending task/chapter
  - Display current progress and next task to user
  - Ask user if they want to continue from where they left off or restart
  - If continuing, skip to the next pending task
  - If restarting, proceed to step 3

### 2. Fresh Start Setup (No Task List)
- Check which output files already exist in `olaf-data-store/product/context/{repository-name}/`
- Present list of existing files to user
- Allow user to specify which existing analyses they are willing to redo/overwrite
- Create initial `olaf-onboarding-tasklist.md` in `olaf-data-store/product/` folder with all 28 tasks and their status

## Task List Management

The `olaf-onboarding-tasklist.md` file must contain:
- **Task ID** (1-28)
- **Task Name** (e.g., "Workspace Content Analysis")
- **Status** (PENDING, IN_PROGRESS, COMPLETED, SKIPPED)
- **Output File** (target markdown file name)
- **Python Script** (script name if applicable)
- **Dependencies** (list of task IDs that must be completed first)
- **Timestamp** (when status was last updated)

## Execution Phases

### PHASE 1: FOUNDATION (Must Execute First)
1. **Workspace Content Analysis** → `analyze-workspace-content-structure.md`
2. **Repository Application Classification** → `classify-repo-application-types.md`
3. **Programming Language Analysis** → `analyze-repo-language-distribution.md`
4. **Repository Size Metrics** → `measure-repo-size-metrics.md`

### PHASE 2: TECHNOLOGY UNDERSTANDING
5. **Technology Stolaf-core-knowledge Analysis** → `identify-repo-technology-stolaf-core-knowledge.md`

### PHASE 3: TESTING AND QUALITY (Parallel Execution Possible)
6. **Unit Testing Framework Analysis** → `analyze-unit-testing-frameworks.md`
7. **Integration Testing Analysis** → `analyze-integration-testing-setup.md`
8. **Comprehensive Code Coverage Analysis** → `analyze-code-coverage-measurement.md`
9. **Performance Testing Analysis** → `analyze-performance-testing-strategy.md`

### PHASE 4: BUILD AND DEPLOYMENT
10. **Local Build Process** → `document-local-build-process.md`
11. **CI/CD Pipeline Analysis** → `analyze-cicd-pipeline-setup.md`
12. **Deployment Strategy Analysis** → `analyze-deployment-strategy-methods.md`
24. **Infrastructure as Code Analysis** → `analyze-infrastructure-code-patterns.md`

### PHASE 5: ARCHITECTURE AND DATA (Parallel Execution Possible)
13. **Database Architecture Analysis** → `analyze-database-architecture-design.md`
16. **API Design and Documentation** → `analyze-api-design-documentation.md`
21. **Architecture Pattern Analysis** → `analyze-architecture-pattern-consistency.md`

### PHASE 6: SECURITY AND GOVERNANCE
14. **Authentication and Authorization** → `analyze-auth-implementation-patterns.md`
28. **Security Pattern Analysis** → `analyze-security-pattern-implementation.md`
26. **Data Governance Analysis** → `analyze-data-governance-patterns.md`

### PHASE 7: STANDARDS AND QUALITY
15. **Code Style and Formatting** → `analyze-code-style-conventions.md`
19. **Complexity Analysis** → `analyze-cyclomatic-complexity-metrics.md`
20. **Dependency Analysis** → `analyze-dependency-management-risks.md`
23. **Licensing and Legal Analysis** → `analyze-licensing-legal-compliance.md`

### PHASE 8: DOCUMENTATION AND PRACTICES
17. **Documentation Analysis** → `analyze-documentation-coverage-quality.md`
25. **Specification-Driven Development** → `analyze-spec-driven-development.md`
22. **Error Handling and Monitoring** → `analyze-error-handling-monitoring.md`

### PHASE 9: RISK ANALYSIS (Requires Historical Data)
18. **Hotspot Analysis** → `identify-code-hotspot-patterns.md`
19. **Critical Contributors Analysis** → `analyze-critical-contributor-impact.md`

### PHASE 10: SYNTHESIS (Final Phase)
27. **Business Domain Synthesis** → `synthesize-business-domain-context.md`

## Execution Logic

### Task Selection
- Skip analyses where output files exist and user chose not to redo them (mark as SKIPPED)
- Execute only tasks marked as PENDING that have all dependencies COMPLETED
- Update task status to IN_PROGRESS before starting, COMPLETED after finishing

### Dependency Validation
- Before executing any task, verify all dependency tasks are COMPLETED
- If dependencies are not met, mark task as PENDING and move to next eligible task
- Follow the 10-phase execution order defined above

### After Each Task Execution
- Update the task list with COMPLETED status and timestamp
- Mark the next eligible task(s) as ready to execute
- Save the updated task list before proceeding

## Python Script Integration

Available Python scripts for analysis tasks (only these 5 exist):
- `workspace_content_analyzer.py`
- `language_distribution_analyzer.py`
- `repo_size_metrics_calculator.py`
- `complexity_analyzer.py`
- `hotspot_analyzer.py`

## Output Requirements

### File Storage Location
All final analysis files must be stored in:
- Path: `olaf-data-store/product/context/{repository-name}/`
- Files must use kebab-case naming for clarity

### Output Format
- Concise yet comprehensive documentation (language and framework agnostic)
- Structured format suitable for LLM processing
- Human-readable summaries and findings
- Actionable insights and recommendations
- Clear file naming for easy identification and automation

## Session Interruption Handling
- If workflow is interrupted, task list preserves state
- Next session can resume from exact point where it left off
- Dependencies are preserved and checked before execution

## Success Criteria
- [ ] Complete coverage of all 28 analysis areas
- [ ] Consistent kebab-case file naming and structure
- [ ] Language and framework agnostic approach
- [ ] Automated generation and updates with Python script assistance
- [ ] Usable by both humans and LLMs for development tasks
- [ ] Actionable insights for project improvement and onboarding
- [ ] Proper file organization in designated storage locations
- [ ] Multi-session workflow support with persistent task list management
- [ ] Resumable execution across multiple sessions without losing context
- [ ] Dependency-aware task execution following proper order and prerequisites

## Error Handling
- **Missing Repository Access**: Verify repository path and permissions
- **Python Script Not Found**: Continue with manual analysis, note missing script
- **Task List Corruption**: Recreate task list from current state
- **Dependency Validation Failure**: Skip task and mark dependencies as required
- **File Write Errors**: Check permissions and disk space
- **Session Interruption**: Save current state and allow resumption

## Next Steps
After completion, the generated documentation can be used for:
- Developer onboarding and knowledge transfer
- Technical debt assessment and prioritization
- Architecture review and improvement planning
- Security audit and compliance verification
- Project risk assessment and mitigation planning
