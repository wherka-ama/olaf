---
name: propose-cloud-native-architecture
description: Chapter-based cloud-native architecture proposal with legacy analysis, design, and migration planning across multiple sessions
tags: [cloud-architecture, kubernetes, modernization, microservices, infrastructure, chapter-based]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **spec_path**: string - (Required) Path to the technical specification of the legacy module
- **project_name**: string - (Required) Name of the project for report naming
- **target_framework**: string - (Optional) Target cloud-native framework (e.g., "Skube")
- **chapter**: string - (Optional) Specific chapter to execute (legacy-analysis, design, migration-planning, final-proposal)

## Chapter-Based Workflow

### Chapter 1: Legacy Analysis
**Prerequisites**: None
**Objective**: Analyze existing legacy system and identify modernization opportunities

**Process**:
1. **Verify Prerequisites**: No previous chapters required
2. **Initialize Report File**: Create `[id:findings_dir]cloud-native-architecture-for-<project_name>-YYYYMMDD-NNN.md`
3. **Legacy System Analysis**:
   - Review technical specification document
   - Identify core functionalities and business logic
   - Map current technology stack and dependencies
   - Document data flows and integration points
   - Identify current limitations and pain points
   - Assess scalability and performance bottlenecks
4. **Save Chapter Results**: Write legacy analysis findings to report file under "# Chapter 1: Legacy Analysis"
5. **Chapter Status**: "Chapter 1 Done - Start new session and enter 'propose cna' to continue with Chapter 2"

### Chapter 2: Cloud-Native Design
**Prerequisites**: Chapter 1 must be completed and saved
**Objective**: Design cloud-native architecture based on legacy analysis

**Process**:
1. **Verify Prerequisites**: Check that Chapter 1 exists in the report file
2. **Load Previous Results**: Read legacy analysis findings from Chapter 1
3. **Architecture Design**:
   - Decompose monolith into microservices based on business domains
   - Design containerization strategy for each service
   - Plan state management (stateless vs stateful services)
   - Design inter-service communication patterns (REST, gRPC, messaging)
   - Select appropriate storage solutions for each service
   - Design API contracts and data models
   - Plan service discovery and load balancing
4. **Save Chapter Results**: Append design findings to report file under "# Chapter 2: Cloud-Native Design"
5. **Chapter Status**: "Chapter 2 Done - Start new session and enter 'propose cna' to continue with Chapter 3"

### Chapter 3: Migration Planning
**Prerequisites**: Chapters 1 and 2 must be completed and saved
**Objective**: Create detailed migration strategy and implementation plan

**Process**:
1. **Verify Prerequisites**: Check that Chapters 1 and 2 exist in the report file
2. **Load Previous Results**: Read legacy analysis and design findings
3. **Migration Strategy**:
   - Assess refactoring effort for each component
   - Plan incremental migration phases (strangler fig pattern)
   - Design data migration strategy
   - Plan rollback procedures and risk mitigation
   - Identify dependencies and migration order
   - Estimate effort and timeline for each phase
4. **Save Chapter Results**: Append migration planning to report file under "# Chapter 3: Migration Planning"
5. **Chapter Status**: "Chapter 3 Done - Start new session and enter 'propose cna' to continue with Chapter 4"

### Chapter 4: Final Proposal
**Prerequisites**: Chapters 1, 2, and 3 must be completed and saved
**Objective**: Generate comprehensive cloud-native architecture proposal

**Process**:
1. **Verify Prerequisites**: Check that Chapters 1, 2, and 3 exist in the report file
2. **Load Previous Results**: Read all previous chapter findings
3. **Proposal Generation**:
   - Create executive summary with key recommendations
   - Compile detailed architecture specifications
   - Generate Kubernetes resource definitions
   - Document infrastructure requirements
   - Create implementation roadmap with milestones
   - Include risk assessment and mitigation strategies
4. **Save Chapter Results**: Append final proposal to file under "# Chapter 4: Final Proposal"
5. **Use Template**: Follow the structure defined in `[id:templates_dir]architect/cloud-native-architecture-template.md`
6. **Chapter Status**: "Chapter 4 Done - Cloud-native architecture proposal complete. Report available at: [id:findings_dir]cloud-native-architecture-for-<project_name>-YYYYMMDD-NNN.md"

## Execution Logic

**Chapter Detection**:
1. Check if report file exists for the project
2. If file exists, determine last completed chapter
3. Execute next chapter in sequence
4. If no file exists, start with Chapter 1

**Chapter Verification**:
- Before starting any chapter (except Chapter 1), verify previous chapters are completed
- Read the report file and check for chapter completion markers
- If prerequisites not met, inform user and stop execution

## Output Format

**Report File Structure**:
```markdown
# Cloud-Native Architecture Proposal for <project_name>
**Generated**: YYYYMMDD-HHmm CEDT
**Status**: [In Progress/Complete]

## Executive Summary
[Populated in Chapter 4]

# Chapter 1: Legacy Analysis
[Legacy system analysis findings]
**Status**: Complete

# Chapter 2: Cloud-Native Design
[Architecture design findings]
**Status**: Complete

# Chapter 3: Migration Planning
[Migration strategy and planning]
**Status**: Complete

# Chapter 4: Final Proposal
[Complete architecture proposal]
**Status**: Complete
```

## Session Management
- Each chapter should be executed in a separate session
- User must start new session between chapters
- Use command "propose cna" to continue workflow
- System will automatically detect and execute next chapter
## Domain-Specific Rules
- Rule 1: Always verify chapter prerequisites before execution
- Rule 2: Save results after each chapter completion
- Rule 3: Provide clear status messages for session management
- Rule 4: Never skip chapters or execute out of order
- Rule 5: Always load previous chapter results before proceeding
- Rule 6: Focus on discoverable elements from technical specifications
- Rule 7: Follow cloud-native best practices (12-factor app, stateless design)
- Rule 8: Design for observability and failure resilience
  metadata {
    name = "example-service"
    labels = {
      app = "example"
    }
  }
  spec {
    replicas = 3
    # Additional configuration...
  }
}
```

## Migration Checklist
- [ ] Containerize application
- [ ] Externalize configuration
- [ ] Implement health checks
- [ ] Set up monitoring
- [ ] Configure logging
- [ ] Implement CI/CD
- [ ] Test scaling
- [ ] Document operations

⚠️ **Critical Notes**
- Consider data migration strategy
- Plan for zero-downtime deployment
- Implement proper secret management
- Design for multi-region deployment
- Include disaster recovery plan
