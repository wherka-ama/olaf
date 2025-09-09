Here I don't use a prepared prompt to interact with ads. The issue is that I try to get my data with a vague one-shot prompt. I should have used a prepared prompt to get my data. Note that this kind of usage is very useful for processes specific to a project. It could be covered by RAG or an MCP server, but this is a demonstration of the framework's capabilities for agility and speed. The processes I chose are common but fake.



<human-user-name>: zhat are th defined process in this project

GitHub Copilot: I'll help you identify the defined processes in this project. Let me start by reading the session initialization files and then explore the project structure to find the defined processes. Now let me explore the specific process directories to understand the defined processes: Let me also check for more workflow-related files: Let me check some key workflow files: Based on my analysis of the project, here are the **defined processes** in this project:

## **I. Core Framework Processes**

### **1. Session Initialization Process** (Protocol hierarchy #1)
- Read `[id:memory_map]` - Project structure and file locations
- Read `[id:core_principles]` - Core behavioral rules  
- Read `[id:competency_index]` - Task competency mapping

### **2. Competency-Driven Workflow Process** (Protocol hierarchy #2-4)
- **Competency First**: Consult query-competency-index first
- **Direct Execution**: Apply matching competency using stated protocol
- **Request Triage**: Ask for clarification if no competency matches

### **3. Interaction Protocols**
- **"Act" Protocol**: Direct actions without asking
- **"Propose-Act" Protocol**: Ask for agreement before acting
- **"Propose-Confirm-Act" Protocol**: Propose → Review → Confirm → Act

## **II. Development & Code Quality Processes**

### **4. Unit Test Evolution Workflow** (9-phase process)
- **Phase 1**: Test Case Ideation (happy path, faulty path, edge cases)
- **Phase 2**: Document Existing Unit Tests
- **Phases 3-9**: Iterative test improvement and coverage expansion

### **5. Code Review Process**
- High-level overview and assessment
- Code quality, functional correctness, security review
- Best practice recommendations generation

### **6. Code Complexity Reduction Process**
- Orchestrated refactoring workflow
- Cyclomatic complexity improvement
- Implementation strategy with prioritization roadmap

## **III. Documentation & Analysis Processes**

### **7. DFD Generation Process** (4-phase, 12-step structured approach)
- **Phase A**: Initial Analysis (Steps 1-3)
- **Phase B**: Level 1 Analysis (Steps 4-7)  
- **Phase C**: Level 2 Analysis (Steps 8-9)
- **Phase D**: Final Documentation (Steps 10-12)

### **8. Business Requirements Analysis Process**
- Requirements document analysis
- Best practices consultation
- Issue identification and question generation

## **IV. Project Management Processes**

### **9. Project Onboarding Analysis Process**
- Comprehensive project analysis workflow
- Team assessment and resource allocation
- Knowledge transfer and documentation

### **10. Changelog Management Process**
- Changelog analysis and reporting
- Archive management with propose-confirm-act protocol
- Progress tracking and status updates

## **V. Research & Quality Assurance Processes**

### **11. Research Workflows**
- **Autonomous Research**: Free comprehensive research
- **Controlled Research**: Step-by-step supervised research
- **Search and Learn**: Targeted learning workflows

### **12. CVE Analysis Workflow**
- Security vulnerability analysis process
- CVE exposure assessment

## **VI. Team & Communication Processes**

### **13. Onboarding Process** (`[id:ads_dir]process/onboarding-in-team/`)
- Home office declarations
- Mandatory trainings
- Presence and time reporting procedures

### **14. Collaboration Practices** (`[id:practices_dir]`)
- Expressing business needs to developers
- Working together guidelines
- Git practices and coding standards

## **VII. Quality & Validation Processes**

### **15. Comprehensive Codebase Benchmark Process**
- System validation and workflow execution
- Quality assessment and regression detection
- Performance optimization recommendations

All processes follow the **OLAF framework** with standardized templates, file referencing conventions, and quality assurance mechanisms built into each workflow.

<human-user-name>: i am only intereed in VI

GitHub Copilot: Based on your interest in **VI. Team & Communication Processes**, here are the defined processes in that category:

## **VI. Team & Communication Processes**

### **13. Onboarding Process** 
Located in `[id:ads_dir]process/onboarding-in-team/` ### **14. Collaboration Practices**
Located in `[id:practices_dir]` ## **Summary: VI. Team & Communication Processes**

### **13. Onboarding Process** (`[id:ads_dir]process/onboarding-in-team/`)

**A. Home Office & Hybrid Work Policy**
- **3 days on-site, 2 days remote** weekly schedule
- **Monday mandatory on-site** for team collaboration
- Flexible scheduling for remaining on-site days

**B. Mandatory Training Requirements**
1. Welcome at ACME (company culture)
2. Security in the Building
3. IT Security
4. Change Management
5. Human and Resources Respect
6. Working with Remote Colleagues
7. Interfacing with Customers

**C. On-Site Work Guidelines (Zone 7a)**
- **Location**: 2nd floor, Zone 7a
- **Safety**: Never work alone - at least one team member present
- **Hours**: 7:30 AM earliest arrival, 9:30 AM - 4:30 PM core hours, 8:00 PM latest departure
- **Clean desk policy** and ergonomic guidelines

**D. Time Reporting & Leave Policy**
- Weekly time reporting using Time-Activity-Report tool (due Fridays)
- Monthly vacation planning (3 months ahead by last Thursday)
- Special leave requires manager approval

### **14. Collaboration Practices** (`[id:practices_dir]`)

**A. Agile Ceremonies**
- **Daily Stand-up**: 15 min max, 3 questions format
- **Sprint Planning**: 1-2 hours, team selects sprint commitment
- **Sprint Review/Demo**: 1 hour, stakeholder feedback
- **Retrospective**: 45-60 min improvement focus

**B. Business-Developer Communication**
- Clear, unambiguous requirements with quantifiable descriptions
- Context and "why" behind requirements
- Complete functional/non-functional requirements
- Visual aids and mockups
- Priority levels and collaborative feedback channels

**C. Git Practices for Monorepo**
- Shallow clones and sparse checkout for large repos
- Trunk-based branching with short-lived feature branches
- Conventional commit messages with project scope
- Project-prefixed branch naming conventions

These processes ensure effective team coordination, clear communication, and structured collaboration across hybrid work environments.