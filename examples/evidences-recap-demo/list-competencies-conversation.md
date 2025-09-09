I type /list-competency which invoked list-competencies.prompt.md from .github/prompts/

<human-user-name>: Follow instructions in [list-competencies.prompt.md](file:///c%3A/Users/ppaccaud/coderepos/demo-2025-08-14/generic-demo/.github/prompts/list-competencies.prompt.md).
contact

GitHub Copilot: To fulfill your request, I will:

1. Refer to <olaf-query-competency-index> for the list of competencies.
2. Read the full <olaf-interaction-protocols>.
3. Present a list of all relevant tasks and their prompts, including the protocol for each.
4. If you did not specify a particular task, I will ask clarifying questions to narrow down the options.

Proceeding to step 1: I will now read the `[id:query-competency-index]` file to retrieve the list of competencies. Here is a list of all relevant tasks (competencies) and their prompts, along with the protocol to use for each, as defined in the competency index:

1. Should I use AI — prompt: other-users/should-i-use-ai.md — Protocol: Act
2. Conversation handover — prompt: project-manager/prepare-conversation-handover.md — Protocol: Act
3. Store conversation — prompt: project-manager/store-conversation-record.md — Protocol: Act
4. Document decision (ADR) — prompt: project-manager/create-decision-record.md — Protocol: Act
5. Orchestrate refactoring — prompt: reduce-code-complexity/reduce-code-complexity-master-orchestrator.md — Protocol: Propose-Act
6. Progress/status update — prompt: project-manager/review-progress.md — Protocol: Act
7. Generate tasklist — prompt: project-manager/generate-tasklist.md — Protocol: Act
8. Changelog/add to changelog — prompt: project-manager/analyze-changelog-and-report.md — Protocol: Act
9. Archive changelog — prompt: project-manager/archive-changelog-entries.md — Protocol: Propose-Confirm-Act
10. Person record/add team member — prompt: project-manager/create-person-record.md — Protocol: Act
11. Generate commits from changelog — prompt: project-manager/generate-commits-from-changelog.md — Protocol: Act
12. Review code — prompt: developer/review-code.md — Protocol: Act
13. Review modified files — prompt: developer/review-modified-files.md — Protocol: Act
14. Review PR — prompt: developer/review-github-pr.md — Protocol: Act
15. Accessibility review — prompt: developer/review-code-accessibility.md — Protocol: Act
16. Codebase risk analysis — prompt: other-users/analyze-codebase-risk.md — Protocol: Act
17. Tech stack analysis — prompt: architect/analyze-technical-stack.md — Protocol: Act
18. Improve complexity/refactor — prompt: developer/improve-cyclomatic-complexity.md — Protocol: Act
19. Evolve code iteratively — prompt: developer/evolve-code-iteratively.md — Protocol: Act
20. Evolve unit tests — prompt: evolve-unit-tests/evolve-unit-tests-workflow.md — Protocol: Act
21. Augment unit tests — prompt: developer/augment-code-unit-test.md — Protocol: Act
22. Search and learn — prompt: researcher/search-and-learn.md — Protocol: Act
23. Autonomous research — prompt: researcher/autonomous-comprehensive-research.md — Protocol: Act
24. Research and report — prompt: business-analyst/research-and-report.md — Protocol: Propose-Confirm-Act
25. Tech spec from code — prompt: developer/generate-tech-spec-from-code.md — Protocol: Act
26. Bootstrap functional spec — prompt: business-analyst/bootstrap-functional-spec-from-code.md — Protocol: Act
27. User story review — prompt: business-analyst/review-user-story.md — Protocol: Act
28. Questionnaire/survey — prompt: business-analyst/generate-questionnaire.md — Protocol: Act
29. Write academic paper — prompt: technical-writer/write-academic-paper.md — Protocol: Act
30. Generate test plan — prompt: tester/generate-test-plan.md — Protocol: Act
31. CVE/security analysis — prompt: cve-verifier/cve-analysis-workflow.md — Protocol: Act
32. Create prompt — prompt: prompt-engineer/create-prompt.md — Protocol: Act
33. Convert/refactor prompt — prompt: prompt-engineer/convert-prompt-existing.md — Protocol: Act
34. Work on job — prompt: project-manager/work-on-job.md — Protocol: Act
35. Create job — prompt: project-manager/create-job.md — Protocol: Act
36. Business analyst pipeline — prompt: other-users/orchestrate-project-assessment-pipeline.md — Protocol: Propose-Act
37. Project onboarding — prompt: project-manager/orchestrate-project-onboarding-analysis.md — Protocol: Propose-Act
38. Find expert/contact — prompt: other-users/find-expert-contact.md — Protocol: Act
39. Troubleshoot logs — prompt: troubleshooting/orchestrate-log-troubleshooting-workflow.md — Protocol: Propose-Act
40. Log to source mapping — prompt: troubleshooting/troubleshoot-logs-to-sources.md — Protocol: Act
41. Fix code smells — prompt: developer/fix-code-smells.md — Protocol: Act
42. Test prompt — prompt: prompt-engineer/test-prompt.md — Protocol: Act

If you want to proceed with a specific task, please specify which one. If you are unsure, let me know your goal and I will help you narrow down the options.

<human-user-name>: using the people register  tell me who i should contact for genAI expertise

GitHub Copilot: I'll help you find who to contact for genAI expertise. Let me check the people register to identify the right expert. Based on the people register, for genAI expertise you should contact:

**Alex Morgan - Gen AI Associate Director**

**Contact Information:**
- Email: alex.morgan@example.com
- Microsoft Teams: @alexm

**Best to Contact For:**
- Strategy confirmation
- Budget alignment
- Gen AI related decisions and guidance

**Availability:**
- 9 AM to 6 PM

**Key Notes:**
- Has the title "Gen AI associate director" indicating specialized expertise in generative AI
- Known as "The boss" with senior leadership position and decision-making authority
- Has long-standing knowledge of ACME and technical expertise

Alex Morgan appears to be your primary contact for genAI expertise given their specific role as Gen AI associate director and their strategic oversight responsibilities.

<human-user-name>: Cam you tell me  what are teh defined process that i need to follow in teh team 

GitHub Copilot: I'll help you find the defined processes you need to follow in the team. Let me check the practices directory and other relevant documentation to identify the team processes. Let me read the key process documents to give you a comprehensive overview: Based on my review of the team documentation, here are the **defined processes you need to follow** in the team:

## **1. Agile Ceremonies (Working Together)**
- **Daily Stand-up**: 15 minutes daily, answer 3 questions (what I completed yesterday, what I'll work on today, any impediments)
- **Sprint Planning**: 1-2 hours at sprint start to plan deliverables
- **Sprint Review (Demo)**: 1 hour at sprint end to demonstrate completed work
- **Retrospective**: 45-60 minutes after Sprint Review to identify improvements

## **2. Git & Code Management Practices**
- Use **shallow clones** for large repositories (`git clone --depth 1`)
- Follow **trunk-based branching** with short-lived feature branches
- Use **conventional commit messages** with scope: `<type>(<scope>): <description>`
- Prefix branches with project names: `feat/project-a/add-login-button`
- Conduct **code reviews** before merging

## **3. Coding Standards**
- Follow **core principles**: DRY, KISS, YAGNI, SOLID
- Write **clear, descriptive names** for variables/functions
- Use **consistent formatting** and linters
- Focus **unit tests on complex logic** (not simple getters/setters)
- Use AI for test generation but **review and own every test**

## **4. Onboarding Requirements**
Complete these **mandatory trainings** in order:
1. Welcome at ACME
2. Security in the Building
3. IT Security
4. Change Management
5. Human and Resources Respect
6. Working with Remote Colleagues
7. Interfacing with Customers

## **5. Time & Attendance**
- **Weekly time reporting**: Submit by end of day Friday via Time-Activity-Report tool
- **Vacation planning**: Submit next 3 months' plans by last Thursday of each month
- **Special leave**: Get explicit manager approval for unplanned single-day leave

## **6. Hybrid Work Policy**
- **3 days on-site, 2 days home** per week
- **Monday is mandatory on-site** for all team members
- Coordinate your weekly schedule with team lead

## **7. On-Site Work (Zone 7a, 2nd Floor)**
- **Never work alone** - ensure another team member is present
- **Arrival**: 7:30 AM earliest, must be present by 9:30 AM
- **Departure**: No leaving before 4:30 PM, office closes at 8:00 PM
- **Clean desk policy**: Clear workspace completely at day's end
- **Health breaks**: 5-minute walk every hour, 20-5-20 eye rule

## **8. Business Requirements Process**
When expressing requirements to developers:
- Use **precise, quantifiable language**
- Provide **business context and user personas**
- Include **functional & non-functional requirements**
- Create **visual mockups/wireframes**
- Set **clear priorities** (MoSCoW method)
- Maintain **open communication channel**

These processes ensure effective collaboration, code quality, and project delivery while maintaining team health and compliance.

<human-user-name>: i just have interest in team proccess not technical practices

GitHub Copilot: Based on your interest in team processes (not technical practices), here are the **defined team processes** you need to follow:

## **1. Agile Ceremonies (Working Together)**
- **Daily Stand-up**: 15 minutes daily, answer 3 questions (what I completed yesterday, what I'll work on today, any impediments)
- **Sprint Planning**: 1-2 hours at sprint start to plan deliverables
- **Sprint Review (Demo)**: 1 hour at sprint end to demonstrate completed work
- **Retrospective**: 45-60 minutes after Sprint Review to identify improvements

## **2. Onboarding Requirements**
Complete these **mandatory trainings** in order:
1. Welcome at ACME
2. Security in the Building
3. IT Security
4. Change Management
5. Human and Resources Respect
6. Working with Remote Colleagues
7. Interfacing with Customers

## **3. Time & Attendance Management**
- **Weekly time reporting**: Submit by end of day Friday via Time-Activity-Report tool at https://time-reporting.examplecorp.com
- **Vacation planning**: Submit next 3 months' plans by last Thursday of each month
- **Special leave**: Get explicit manager approval for unplanned single-day leave

## **4. Hybrid Work Policy**
- **3 days on-site, 2 days home** per week
- **Monday is mandatory on-site** for all team members
- Coordinate your weekly schedule with team lead

## **5. On-Site Work Guidelines (Zone 7a, 2nd Floor)**
- **Never work alone** - ensure another team member is present for safety
- **Core hours**: Must be present 9:30 AM - 4:30 PM
- **Arrival window**: 7:30 AM earliest
- **Office closes**: 8:00 PM latest
- **Clean desk policy**: Clear workspace completely at day's end
- **Health breaks**: Take 5-minute walk every hour, follow 20-5-20 eye rule

## **6. Business Requirements Communication**
When working with developers:
- Use **precise, quantifiable language**
- Provide **business context and user personas**
- Set **clear priorities** (MoSCoW method)
- Maintain **open communication channel**
- Create **visual mockups/wireframes** when needed

These are the core team processes focused on collaboration, attendance, workspace management, and communication protocols.