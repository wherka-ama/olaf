# Competencies Overview

## Available Competencies

Here is a list of the competencies that may be used on this vanilla incarnation of OLAF, grouped by category:

**Code Analysis**
- Review Code
- Review GitHub PR - needs the GitHub MCP server
- Analyze Architecture
- Analyze Technical Stack
- Analyze Test Stack
- Evolve Code Iteratively
- Improve Cyclomatic Complexity - a complete workflow is provided
- Review Modified Files - those files in the git modified stage

**Documentation & Specification**
- Research and Report - create plan for research then act on each chapter
- Create Decision Record - when you document a technical decision for the project - can be embedded in the core principles file
- Document API Specification
- Generate Tech Spec from Code
- Generate initial Technical Specification from code
- Bootstrap Functional Spec from Code
- Write Academic Paper
- Create Prompt (meta-prompting)
- Generate API Definition
- Prepare Conversation Handover - when you end a session and want to provide a summary of the conversation for the next session
- Store Conversation Record - when you end a session and want to store the conversation for later analysis

**Requirements Analysis**
- Generate Questionnaire

**Project Management**
- Review Progress based on changelog and jobs registry
- Create Changelog Entry in the registry
- Archive Changelog Entries from the registry to an archive registry
- Create Job - a job is a micro-project, including its task plan
- Work on Job - start or restart a job
- Create Person Record - a person record is a record of a person, including its role and responsibilities
- Generate Changelog entries from commits 

**Software Development**
- Generate Test Plan
- Generate API Test Suite

## Specific: Complex phase chained prompts
**Compound Onboarding Competency**: A comprehensive workflow to analyze and understand a new project, composed of several sub-competencies for a thorough evaluation:
- Project onboarding and analysis
- Improvement implementations
- New asset creation

**Improve cyclomatic complexity and halstead metrics**: For repositories this chain of prompts is used to:
- Find the hotspots (files changed regularly and that present high cyclomatic complexity and halstead metrics)
- Create strategy and request for USER to review it and approve it
- On approval, iteratively improve them
