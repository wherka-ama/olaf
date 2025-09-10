# Project Onboarding Analysis Requirements

## Workflow Entry Instructions
**IMPORTANT:** When using this file to create a workflow, the prompt must:

### **Initial Session Setup:**
1. **Check for existing task list:** Look for `olaf-onboarding-tasklist.md` in `olaf-data-store/product/` folder
2. **If task list exists:**
   - Read the task list to determine the next pending task/chapter to execute
   - Display current progress and next task to user
   - Ask user if they want to continue from where they left off or restart
   - If continuing, skip to the next pending task
   - If restarting, proceed to step 3

3. **If no task list exists (fresh start):**
   - Check which output files already exist in target storage location (`olaf-data-store/product/context/{repository-name}/`)
   - Present the list of existing files to the user
   - Allow the user to specify which existing analyses they are willing to redo/overwrite
   - Create initial `olaf-onboarding-tasklist.md` in `olaf-data-store/product/` folder with all 28 tasks and their status

### **Task List Management:**
4. **Task list format:** `olaf-onboarding-tasklist.md` must contain:
   - **Task ID** (1-28)
   - **Task Name** (e.g., "Workspace Content Analysis")  
   - **Status** (PENDING, IN_PROGRESS, COMPLETED, SKIPPED)
   - **Output File** (target markdown file name)
   - **Python Script** (script name if applicable)
   - **Dependencies** (list of task IDs that must be completed first)
   - **Timestamp** (when status was last updated)

5. **After each task execution:**
   - Update the task list with COMPLETED status and timestamp
   - Mark the next eligible task(s) as ready to execute
   - Save the updated task list before proceeding

6. **Session interruption handling:**
   - If workflow is interrupted, task list preserves state
   - Next session can resume from exact point where it left off
   - Dependencies are preserved and checked before execution

### **Execution Logic:**
7. **Task selection:**
   - Skip analyses where output files exist and user chose not to redo them (mark as SKIPPED)
   - Execute only tasks marked as PENDING that have all dependencies COMPLETED
   - Update task status to IN_PROGRESS before starting, COMPLETED after finishing

8. **Dependency validation:**
   - Before executing any task, verify all dependency tasks are COMPLETED
   - If dependencies are not met, mark task as PENDING and move to next eligible task
   - Follow the 10-phase execution order defined in this document

## Sample Task List Format
The `olaf-onboarding-tasklist.md` file should follow this structure:

```markdown
# Project Onboarding Task List
**Repository:** {repository-name}  
**Created:** {timestamp}  
**Last Updated:** {timestamp}

## Task Status Summary
- **Total Tasks:** 28
- **Completed:** X
- **In Progress:** X  
- **Pending:** X
- **Skipped:** X

## Task Details

### PHASE 1: FOUNDATION
| ID | Task Name | Status | Output File | Script | Dependencies | Updated |
|----|-----------|--------|-------------|--------|--------------|---------|
| 1 | Workspace Content Analysis | COMPLETED | analyze-workspace-content-structure.md | workspace_content_analyzer.py | None | 2025-09-09 14:30 |
| 2 | Repository Application Classification | IN_PROGRESS | classify-repo-application-types.md | - | 1 | 2025-09-09 15:15 |
| 3 | Programming Language Analysis | PENDING | analyze-repo-language-distribution.md | language_distribution_analyzer.py | 1 | - |
| 4 | Repository Size Metrics | PENDING | measure-repo-size-metrics.md | repo_size_metrics_calculator.py | 1 | - |
| 5 | Technology Stack Analysis | PENDING | identify-repo-technology-stack.md | - | 2,3 | - |

### PHASE 2: TESTING STRATEGY  
| ID | Task Name | Status | Output File | Script | Dependencies | Updated |
|----|-----------|--------|-------------|--------|--------------|---------|
| 6 | Unit Testing Framework Analysis | PENDING | analyze-unit-testing-frameworks.md | - | 3,5 | - |
| 7 | Integration Testing Analysis | SKIPPED | analyze-integration-testing-setup.md | - | 2,5 | 2025-09-09 14:00 |

[Continue for all 28 tasks organized across 10 phases...]

## Next Actions
**Next Eligible Tasks:** 3, 4 (waiting for task 2 to complete)  
**Blocked Tasks:** 5 (waiting for tasks 2,3)
```

## Overview
This document outlines the comprehensive requirements for onboarding a project through automated analysis. The goal is to create separate documentation files that capture essential aspects of the codebase for both human review and LLM consumption. All analysis should be language-agnostic and framework-independent to ensure broad applicability.

## File Naming Convention
All generated files will follow kebab-case convention with maximum 4 words each:
- Format: `verb-entity-complement-detail.md`
- Example: `analyze-repo-structure-overview.md`

## File Storage Location
All final analysis files must be stored in:

- Path: `olaf-data-store/product/context/{repository-name}/`
- Files must use kebab-style naming for clarity and LLM/human understanding

## Python Script Assistance
Where applicable, Python scripts can assist with analysis tasks. Available tools are located in:
- `olaf-core-knowledge/tools/`

Scripts can help with metrics calculation, file discovery, complexity analysis, and other automated assessments.

## Analysis Areas Organized by Theme

### **THEME A: FOUNDATIONAL ANALYSIS** 
*Core understanding of workspace structure and technology stack*

### 1. Workspace Content Analysis
**Target File:** `analyze-workspace-content-structure.md`
- Document workspace content (excluding old/legacy folders if any)
- Identify relationships between repositories within workspace
- Determine if repositories are monorepos
- Map inter-repository dependencies
- **Python Script Support:** Directory traversal, dependency graph generation
- **Script Name:** `workspace_content_analyzer.py`

### 2. Repository Application Classification
**Target File:** `classify-repo-application-types.md`
**Dependencies:** Uses workspace structure from #1
- For each repository, identify:
  - Application purpose and functionality
  - Direct relationships with other repositories
  - Classification by type (Front-end, Backend, Database, API, Full-stack, Microservice, Library/SDK, Configuration/Infrastructure)
- **Python Script Support:** Pattern recognition for application types, configuration file analysis

### 3. Programming Language Analysis
**Target File:** `analyze-repo-language-distribution.md`
**Dependencies:** Uses repository structure from #1
- Identify languages in each repository (language-agnostic approach)
- Rank languages by prevalence (most to least)
- Support multiple languages per repository
- Identify mixed-language patterns and polyglot architectures
- **Python Script Support:** File extension analysis, LOC counting by language
- **Script Name:** `language_distribution_analyzer.py`

### 4. Repository Size Metrics
**Target File:** `measure-repo-size-metrics.md`
**Dependencies:** Uses repository structure from #1
- Calculate repository sizes using file count, LOC, binary file sizes, Git repository size
- **Python Script Support:** Automated metrics collection, statistical analysis
- **Script Name:** `repo_size_metrics_calculator.py`

### 5. Technology Stack Analysis
**Target File:** `identify-repo-technology-stack.md`
**Dependencies:** Uses language analysis from #3, application types from #2
- Document frameworks and technologies used (framework-agnostic)
- Categorize by application layer (Frontend, Middleware, Backend, Database, Infrastructure)
- **Python Script Support:** Configuration file parsing, dependency manifest analysis

### **THEME B: TESTING STRATEGY ANALYSIS**
*Understanding testing approaches and coverage*

### 6. Unit Testing Framework Analysis
**Target File:** `analyze-unit-testing-frameworks.md`
**Dependencies:** Uses language analysis from #3, technology stack from #5
- For each repository identify unit testing framework and version, execution commands, examples, mocking strategies
- **Python Script Support:** Test file discovery, framework detection, command extraction

### 7. Integration Testing Analysis
**Target File:** `analyze-integration-testing-setup.md`
**Dependencies:** Uses technology stack from #5, application types from #2
- Integration testing frameworks, execution procedures, mocking approaches, environment configuration
- **Python Script Support:** Integration test pattern recognition, environment configuration analysis

### 8. Comprehensive Code Coverage Analysis
**Target File:** `analyze-code-coverage-measurement.md`
**Dependencies:** Uses unit testing from #6, integration testing from #7
- Coverage calculation methods, metrics, thresholds, uncovered critical paths identification
- **Python Script Support:** Coverage report parsing, threshold analysis, critical path identification

### 9. Performance Testing Analysis
**Target File:** `analyze-performance-testing-strategy.md`
**Dependencies:** Uses technology stack from #5, application types from #2
- Performance testing frameworks, load testing configurations, benchmarks
- **Python Script Support:** Performance metrics extraction, benchmark analysis

### **THEME C: BUILD AND DEPLOYMENT PIPELINE**
*Understanding build, deployment, and infrastructure*

### 10. Local Build Process
**Target File:** `document-local-build-process.md`
**Dependencies:** Uses technology stack from #5, language analysis from #3
- Local build procedures, dependencies, setup requirements
- **Python Script Support:** Build script discovery, dependency analysis

### 11. CI/CD Pipeline Analysis
**Target File:** `analyze-cicd-pipeline-setup.md`
**Dependencies:** Uses build process from #10, testing frameworks from #6-9
- CI/CD platform identification, pipeline configuration, automation processes
- **Python Script Support:** Pipeline configuration parsing, workflow analysis

### 12. Deployment Strategy Analysis
**Target File:** `analyze-deployment-strategy-methods.md`
**Dependencies:** Uses CI/CD analysis from #11, technology stack from #5
- Deployment technologies, environments, container orchestration, deployment patterns
- **Python Script Support:** Deployment configuration analysis, container scanning

### 24. Infrastructure as Code Analysis
**Target File:** `analyze-infrastructure-code-patterns.md`
**Dependencies:** Uses deployment strategy from #12, CI/CD from #11
- IaC tool usage, infrastructure versioning, GitOps patterns, environment provisioning
- **Python Script Support:** IaC file discovery, GitOps pattern detection

### **THEME D: SECURITY AND COMPLIANCE**
*Security implementation and compliance patterns*

### 14. Authentication and Authorization
**Target File:** `analyze-auth-implementation-patterns.md`
**Dependencies:** Uses technology stack from #5, application types from #2
- Authentication mechanisms, authorization frameworks, security configuration
- **Python Script Support:** Security configuration scanning, vulnerability pattern detection

### 28. Security Pattern Analysis
**Target File:** `analyze-security-pattern-implementation.md`
**Dependencies:** Uses auth analysis from #14, technology stack from #5, API design from #16
- Input validation, injection prevention, cryptographic implementations, secrets management
- **Python Script Support:** Security pattern detection, vulnerability pattern scanning, crypto usage analysis

### 23. Licensing and Legal Analysis
**Target File:** `analyze-licensing-legal-compliance.md`
**Dependencies:** Uses dependency analysis from #20
- Software license compliance, third-party obligations, open source compatibility
- **Python Script Support:** License file discovery, dependency license analysis

### **THEME E: DATA AND API ARCHITECTURE**
*Data handling and API design patterns*

### 13. Database Architecture Analysis
**Target File:** `analyze-database-architecture-design.md`
**Dependencies:** Uses technology stack from #5, application types from #2
- Database technologies, schema design patterns, migration strategies
- **Python Script Support:** Schema analysis, migration script discovery

### 16. API Design and Documentation
**Target File:** `analyze-api-design-documentation.md`
**Dependencies:** Uses application types from #2, technology stack from #5
- API design patterns, documentation quality, versioning strategies
- **Python Script Support:** API endpoint discovery, documentation coverage analysis

### 26. Data Governance Analysis
**Target File:** `analyze-data-governance-patterns.md`
**Dependencies:** Uses database architecture from #13, security patterns from #28
- Data validation patterns, schema constraints, PII handling, data retention logic
- **Python Script Support:** Data validation pattern detection, schema analysis, PII pattern identification

### **THEME F: CODE QUALITY AND STANDARDS**
*Code quality, style, and architectural patterns*

### 15. Code Style and Formatting
**Target File:** `analyze-code-style-conventions.md`
**Dependencies:** Uses language analysis from #3
- Naming conventions per language, formatting tools, style guide compliance
- **Python Script Support:** Style configuration discovery, consistency analysis

### 19. Complexity Analysis
**Target File:** `analyze-cyclomatic-complexity-metrics.md`
**Dependencies:** Uses language analysis from #3, repository size from #4
- Cyclomatic complexity calculation, high-complexity areas, maintainability index
- **Python Script Support:** Complexity metrics calculation, threshold analysis
- **Script Name:** `complexity_analyzer.py`

### 20. Dependency Analysis
**Target File:** `analyze-dependency-management-risks.md`
**Dependencies:** Uses technology stack from #5, build process from #10
- External dependency inventory, security vulnerabilities, license compliance
- **Python Script Support:** Dependency tree analysis, vulnerability scanning

### 21. Architecture Pattern Analysis
**Target File:** `analyze-architecture-pattern-consistency.md`
**Dependencies:** Uses application types from #2, technology stack from #5, API design from #16
- Architectural patterns, pattern consistency, microservices vs monolith assessment
- **Python Script Support:** Pattern detection, architectural metrics

### **THEME G: OPERATIONAL EXCELLENCE**
*Monitoring, error handling, and operational practices*

### 22. Error Handling and Monitoring
**Target File:** `analyze-error-handling-monitoring.md`
**Dependencies:** Uses technology stack from #5, application types from #2
- Error handling strategies, logging frameworks, monitoring setup
- **Python Script Support:** Log configuration analysis, monitoring setup detection

### **THEME H: DEVELOPMENT PRACTICES**
*Development methodologies and specification practices*

### 25. Specification-Driven Development Analysis
**Target File:** `analyze-spec-driven-development.md`
**Dependencies:** Uses testing frameworks from #6-7, documentation from #17
- BDD/Gherkin specification analysis, specification as code practices
- **Python Script Support:** Spec file discovery, BDD framework detection

### **THEME I: DOCUMENTATION AND KNOWLEDGE**
*Documentation quality and knowledge management*

### 17. Comprehensive Documentation Analysis
**Target File:** `analyze-documentation-coverage-quality.md`
**Dependencies:** Uses workspace structure from #1, application types from #2
- Documentation inventory, coverage assessment, quality evaluation
- **Python Script Support:** Documentation file discovery, link validation, freshness analysis

### **THEME J: RISK AND MAINTENANCE ANALYSIS**
*Risk assessment and maintenance considerations*

### 18. Hotspot Analysis
**Target File:** `identify-code-hotspot-patterns.md`
**Dependencies:** Uses repository structure from #1, complexity analysis from #19
- Files modified frequently, modification patterns, architectural debt areas
- **Python Script Support:** Git history analysis, change frequency calculation
- **Script Name:** `hotspot_analyzer.py`

### 19. Critical Contributors Analysis
**Target File:** `analyze-critical-contributor-impact.md`
**Dependencies:** Uses hotspot analysis from #18
- Contributors with highest impact, contribution patterns, bus factor analysis
- **Python Script Support:** Git blame analysis, contribution metrics calculation

### **THEME K: SYNTHESIS AND BUSINESS CONTEXT**
*High-level synthesis and business understanding*

### 27. Business Domain Synthesis
**Target File:** `synthesize-business-domain-context.md`
**Dependencies:** Uses application types from #2, API design from #16, spec-driven development from #25, documentation from #17
- Business logic patterns, feature mapping, workflow inference, domain terminology
- **Python Script Support:** Pattern synthesis, domain terminology extraction, business logic mapping

## Execution Order and Key Dependencies

### **PHASE 1: FOUNDATION (Must Execute First)**
1. **Workspace Content Analysis (#1)** → Provides structure for all subsequent analysis
2. **Repository Application Classification (#2)** → Uses #1, needed by most other analyses
3. **Programming Language Analysis (#3)** → Uses #1, fundamental for technology decisions
4. **Repository Size Metrics (#4)** → Uses #1, provides baseline metrics

### **PHASE 2: TECHNOLOGY UNDERSTANDING**
5. **Technology Stack Analysis (#5)** → Uses #2, #3 - Critical for understanding tech choices

### **PHASE 3: TESTING AND QUALITY (Parallel Execution Possible)**
6. **Unit Testing Framework Analysis (#6)** → Uses #3, #5
7. **Integration Testing Analysis (#7)** → Uses #2, #5
8. **Code Coverage Analysis (#8)** → Uses #6, #7
9. **Performance Testing Analysis (#9)** → Uses #2, #5

### **PHASE 4: BUILD AND DEPLOYMENT**
10. **Local Build Process (#10)** → Uses #3, #5
11. **CI/CD Pipeline Analysis (#11)** → Uses #6-#10
12. **Deployment Strategy Analysis (#12)** → Uses #11, #5
24. **Infrastructure as Code Analysis (#24)** → Uses #11, #12

### **PHASE 5: ARCHITECTURE AND DATA (Parallel Execution Possible)**
13. **Database Architecture Analysis (#13)** → Uses #2, #5
16. **API Design and Documentation (#16)** → Uses #2, #5
21. **Architecture Pattern Analysis (#21)** → Uses #2, #5, #16

### **PHASE 6: SECURITY AND GOVERNANCE**
14. **Authentication and Authorization (#14)** → Uses #2, #5
28. **Security Pattern Analysis (#28)** → Uses #14, #5, #16
26. **Data Governance Analysis (#26)** → Uses #13, #28

### **PHASE 7: STANDARDS AND QUALITY**
15. **Code Style and Formatting (#15)** → Uses #3
19. **Complexity Analysis (#19)** → Uses #3, #4
20. **Dependency Analysis (#20)** → Uses #5, #10
23. **Licensing and Legal Analysis (#23)** → Uses #20

### **PHASE 8: DOCUMENTATION AND PRACTICES**
17. **Documentation Analysis (#17)** → Uses #1, #2
25. **Specification-Driven Development (#25)** → Uses #6, #7, #17
22. **Error Handling and Monitoring (#22)** → Uses #2, #5

### **PHASE 9: RISK ANALYSIS (Requires Historical Data)**
18. **Hotspot Analysis (#18)** → Uses #1, #19
19. **Critical Contributors Analysis (#19)** → Uses #18

### **PHASE 10: SYNTHESIS (Final Phase)**
27. **Business Domain Synthesis (#27)** → Uses #2, #16, #25, #17

## Implementation Approach

### Workflow Orchestration
- **Multi-session support:** Create and maintain `olaf-onboarding-tasklist.md` for persistent state across sessions
- **Session resumption:** Check for existing task list and resume from last completed task
- **Task dependency management:** Validate dependencies before executing each task
- Create individual prompts for each analysis area (28 total analysis areas)
- Implement prompt workflow orchestration system with state persistence
- Ensure automated file generation with proper kebab-case naming
- Enable both human review and LLM consumption
- Integrate Python script assistance where applicable
- Store all outputs in designated `olaf-data-store/product/context/{repository-name}/` directories
- **Progress tracking:** Update task list after each completed analysis
- **Interruption handling:** Allow workflow to be safely interrupted and resumed

### Output Requirements
- Concise yet comprehensive documentation (language and framework agnostic)
- Structured format suitable for LLM processing
- Human-readable summaries and findings
- Actionable insights and recommendations
- Clear file naming for easy identification and automation
- Integration with existing tooling in `olaf-core-knowledge/tools/` and `olaf-core-knowldege/tools/`

### Python Script Integration
- Leverage existing tools in `olaf-core-knowledge/tools/` and `olaf-core-knowldege/tools/`
- Develop additional scripts as needed for specific analysis tasks
- Ensure scripts are language-agnostic where possible
- Provide automated metrics calculation and data extraction
- Enable consistent analysis across different project types

## Success Criteria
1. Complete coverage of all 28 analysis areas
2. Consistent kebab-case file naming and structure
3. Language and framework agnostic approach
4. Automated generation and updates with Python script assistance
5. Usable by both humans and LLMs for development tasks
6. Actionable insights for project improvement and onboarding
7. Proper file organization in designated storage locations
8. Integration with existing organizational tooling ecosystem
9. Comprehensive documentation gap identification and remediation guidance
10. Risk assessment and prioritization for technical debt and improvements
11. **Multi-session workflow support** with persistent task list management
12. **Resumable execution** across multiple sessions without losing context
13. **Dependency-aware task execution** following proper order and prerequisites

## Key Enhancements Added
- **Performance Testing Analysis** - Critical for production systems
- **Database Architecture Analysis** - Essential for data-driven applications  
- **API Design and Documentation** - Important for service integration
- **Dependency Analysis** - Security and maintenance considerations
- **Architecture Pattern Analysis** - Consistency and maintainability assessment
- **Error Handling and Monitoring** - Operational excellence evaluation
- **Enhanced Security Analysis** - Comprehensive authentication/authorization review
- **Bus Factor Analysis** - Knowledge management and risk assessment
- **Maintainability Index** - Code quality beyond complexity metrics
- **Licensing and Legal Analysis** - Open source compliance and legal obligations
- **Infrastructure as Code Analysis** - GitOps patterns and IaC tool usage
- **Specification-Driven Development** - BDD/Gherkin and living documentation analysis
- **Data Governance Analysis** - Code-based data validation, PII handling, and schema constraints
- **Business Domain Synthesis** - Derived business context from application patterns and APIs
- **Security Pattern Analysis** - Code-based security implementation patterns and vulnerability prevention

## Consolidations Made
- **Merged Documentation Analysis** - Combined sections #17 and #21 into comprehensive documentation analysis
- **Unified Coverage Analysis** - Integrated sections #8 and #20 into comprehensive code coverage analysis
- **Standardized File Paths** - Consistent storage location format across all sections

---
*Generated for comprehensive project onboarding automation workflow*
