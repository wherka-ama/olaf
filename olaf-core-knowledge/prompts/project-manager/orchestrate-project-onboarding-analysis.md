---
name: orchestrate-project-onboarding-analysis
description: Comprehensive project analysis orchestrator for onboarding new team members or understanding existing projects
tags: [orchestrator, onboarding, analysis, documentation, project-setup]
---

# Project Onboarding Analysis Orchestrator

## Workflow Type
Master/Orchestrator - Coordinates comprehensive project analysis through multiple specialized sub-workflows

## Workflow Overview
Orchestrates systematic project analysis for onboarding purposes by executing specialized analysis workflows, checking for existing documentation to avoid duplication, and synthesizing results into comprehensive project overview documentation.

## Prerequisites
- Access to target repository path
- Write permissions to product documentation directory
- All referenced analysis prompts available in prompts directory

## Input Requirements
- **Primary Input:** Absolute path to repository to be analyzed
- **Configuration Input:** Target documentation output directory path
- **Input Format:** Repository path (string), optional existing document verification

## Output Specifications
- **Orchestrator Log:** `project-onboarding-orchestrator-log-YYYYMMDD-NNN.json`
- **Final Consolidated Output:** `product-overview.md`
- **Sub-workflow Outputs:** Repository setup, technical stack, architecture, test stack, API specification documents
- **Output Location:** `[id:product_docs_dir]repo_name]/`

## Sub-Workflow Chain

### Sub-Workflow 1: Document Verification and Initialization
- **Type:** Sequential
- **Process:** Built-in initialization logic
- **Input Requirements:**
  - Primary: Repository path from user
  - Configuration: Expected document list
- **Output Produced:** `document-verification-status.json`
- **Description:** Identifies repository, creates output directory structure, checks for existing analysis documents
- **Success Criteria:** Repository identified, output directory established, existing documents catalogued
- **Failure Handling:** Prompt user for valid repository path if invalid

### Sub-Workflow 2: Repository Setup Analysis (Conditional)
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]nalyze-repository-setup.md`
- **Input Requirements:**
  - Primary: Repository path
  - Condition: Only execute if `repository-setup-analysis.md` missing
- **Output Produced:** `repository-setup-analysis.md`
- **Description:** Analyzes project structure, build configuration, dependencies, and development setup
- **Success Criteria:** Repository setup documented with clear development environment requirements
- **Failure Handling:** Log error and continue with remaining workflows

### Sub-Workflow 3: Technical Stack Analysis (Conditional)
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]nalyze-technical-stack.md`
- **Input Requirements:**
  - Primary: Repository path
  - Condition: Only execute if `technical-stack.md` missing
- **Output Produced:** `technical-stack.md`
- **Description:** Identifies and documents technologies, frameworks, libraries, and platforms used
- **Success Criteria:** Complete technical stack inventory with version information
- **Failure Handling:** Log error and continue with remaining workflows

### Sub-Workflow 4: Architecture Analysis (Conditional)
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]nalyze-architecture.md`
- **Input Requirements:**
  - Primary: Repository path
  - Condition: Only execute if `architecture.md` missing
- **Output Produced:** `architecture.md`
- **Description:** Documents system architecture, component relationships, and design patterns
- **Success Criteria:** Architecture clearly documented with component interaction diagrams
- **Failure Handling:** Log error and continue with remaining workflows

### Sub-Workflow 5: Test Stack Analysis (Conditional)
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]nalyze-test-stack.md`
- **Input Requirements:**
  - Primary: Repository path
  - Condition: Only execute if `test-stack.md` missing
- **Output Produced:** `test-stack.md`
- **Description:** Analyzes testing frameworks, test coverage, and testing strategies
- **Success Criteria:** Testing approach and tools comprehensively documented
- **Failure Handling:** Log error and continue with remaining workflows

### Sub-Workflow 6: API Specification Analysis (Conditional)
- **Type:** Sequential
- **Prompt/Workflow:** `[id:prompts_dir]ocument-api-specification.md`
- **Input Requirements:**
  - Primary: Repository path
  - Condition: Only execute if `api-specification.md` missing
- **Output Produced:** `api-specification.md`
- **Description:** Documents API endpoints, data models, and integration points
- **Success Criteria:** API interfaces clearly documented with examples
- **Failure Handling:** Log error and continue with remaining workflows

### Sub-Workflow 7: Product Overview Synthesis
- **Type:** Sequential
- **Process:** Built-in synthesis logic
- **Input Requirements:**
  - Primary: All previous sub-workflow outputs
  - Additional: Project README and high-level documentation
- **Output Produced:** `product-overview.md`
- **Description:** Synthesizes all analysis into comprehensive project overview for onboarding
- **Success Criteria:** Complete product overview covering purpose, functionality, users, and metrics
- **Failure Handling:** Generate overview from available documents if some sub-workflows failed

## Data Flow Management
- **Conditional Execution:** Each analysis sub-workflow only executes if corresponding output document missing
- **Output Consolidation:** Final synthesis combines all available analysis documents
- **Error Resilience:** Missing sub-workflow outputs don't prevent final overview generation

## Orchestrator Execution Steps

### Step 1: Initialization and Verification
1. Request repository path from user
2. Define output directory: `[id:product_docs_dir]repo_name]`
3. Check for existing analysis documents
4. Report status to user and request confirmation to proceed

### Step 2: Conditional Sub-Workflow Execution
1. Execute each analysis sub-workflow only if corresponding document missing
2. Track completion status and any errors
3. Validate each sub-workflow output

### Step 3: Final Synthesis
1. Collect all available analysis documents
2. Analyze project README and high-level documentation
3. Generate comprehensive product overview
4. Report completion status to user

## Quality Gates
- Repository path validation before execution
- Sub-workflow output validation before proceeding
- Final output completeness verification

## Error Recovery
- **Sub-workflow Failure:** Log error, continue with remaining workflows
- **Repository Access Error:** Prompt user for correct path
- **Output Directory Error:** Create directory structure as needed

## Success Metrics
- Number of analysis documents generated
- Completeness of final product overview
- Time to complete full analysis
- User satisfaction with onboarding documentation quality
