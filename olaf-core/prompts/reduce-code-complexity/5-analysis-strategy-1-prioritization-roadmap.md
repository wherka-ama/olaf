---
name: 5-analysis-strategy-2-prioritization-roadmap
description: Analyze existing git history and complexity analysis outputs to create a prioritized refactoring roadmap focusing on reducing cyclomatic complexity and improving Halstead metrics
tags: [analysis-strategy, prioritization, roadmap-planning, complexity-reduction]
---

# Quality Improvement Prioritization Roadmap

## Objective
Analyze the outputs from git history analysis and complexity analysis (cyclomatic complexity and Halstead metrics) to create a prioritized refactoring roadmap. Focus on identifying and addressing typical high-complexity patterns such as complex switch cases, God classes, and other refactoring opportunities. Prioritize improvements from lowest to highest risk.



## Framework Validation
You MUST apply the <olaf-work-instructions> framework.
You MUST pay special attention to**:
- <olaf-general-role-and-behavior> - Expert domain approach
- <olaf-interaction-protocols> - Appropriate execution protocol
You MUST strictly apply <olaf-framework-validation>.

## Time Retrieval
You MUST get current time in YYYYMMDD-HHmm format using terminal commands:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **output_location**: string - Where to save error baseline results (defaults to [id:findings_dir]reduce-code-complexity/)

## Input Files Required
- **Primary Input:**  `4-quality-analysis-2-complexity-assessment.md`
    - **Secondary Inputs:** `cyclomatic-complexity.md`, `halstead-metrics.md`
    - **Input Format:** markdown compliance report
- **Output Files Required:**
    - **Primary Output:** `5-analysis-strategy-2-prioritization-roadmap.md`


## Analysis Process

### 1. Refactoring Opportunity Prioritization
Prioritize refactoring opportunities based on:
- **Risk Level** (Low → Medium → High)
- **Complexity Impact** (High reduction potential gets higher priority)
- **Change Frequency** (Hotspots get higher priority)
- **Business Impact** (Core functionality gets careful consideration)

## Refactoring Techniques to Consider

### Low Risk Improvements
- Extract small methods from long functions
- Replace magic numbers with named constants
- Simplify boolean expressions
- Remove dead code
- Rename variables and methods for clarity
- Extract constants for repeated string literals
- Simplify nested conditional statements
- Remove unused imports and dependencies
- Replace comments with self-documenting code
- Consolidate variable declarations
- Use early returns to reduce nesting
- Replace complex boolean conditions with well-named methods
- Extract configuration values to properties/config files
- Remove redundant else statements after returns
- Simplify arithmetic expressions
- Replace manual loops with built-in collection methods
- Extract inline validations to separate methods
- Use guard clauses to handle edge cases early

### Medium Risk Improvements
- Extract classes from God classes
- Replace complex conditionals with polymorphism
- Consolidate duplicate code
- Refactor switch statements to strategy pattern
- Replace inheritance with composition where appropriate
- Extract interfaces from concrete implementations
- Replace long parameter lists with parameter objects
- Break down large methods into smaller, focused methods
- Replace data classes with rich domain objects
- Implement null object pattern to eliminate null checks
- Replace feature envy with proper encapsulation
- Extract utility methods to appropriate helper classes
- Replace primitive obsession with value objects
- Implement command pattern for complex operations
- Replace callbacks with event-driven architecture
- Refactor exception handling to use specific exception types
- Extract business rules into separate rule classes
- Replace manual resource management with try-with-resources or using statements

### High Risk Improvements (Advanced Refactoring)
- Redesign core architectural patterns
- Replace monolithic structures with modular architecture
- Implement design patterns (Factory, Observer, Decorator)
- Refactor data access patterns and database interactions
- Replace tight coupling with dependency injection
- Implement CQRS (Command Query Responsibility Segregation)
- Refactor synchronous operations to asynchronous patterns
- Replace shared mutable state with immutable objects
- Implement microservices decomposition for large modules
- Refactor legacy API integrations
- Replace manual threading with concurrent collections
- Implement circuit breaker patterns for external dependencies

## Output Format
Follow template structure: `[id:templates_dir]reduce-code-complexity/prioritization-roadmap.md`

The output should be saved as `5-analysis-strategy-1-prioritization-roadmap.md` in the `[id:findings_dir]reduce-code-complexity/` directory, following the markdown structure defined in the template. Replace all placeholder values (enclosed in square brackets) with actual analysis results and prioritization decisions.

## Output to USER
- Confirmation: "Strategic prioritization and roadmap planning completed successfully"
- Location: "Results saved to [id:findings_dir]/reduce-code-complexity/5-analysis-strategy-2-prioritization-roadmap.md"
- Timestamp: Roadmap completion time
- Next phase: "Ready for analysis strategy Step 2: Implementation Strategy and Planning"
   - Provides iterative plan for refactoring
   - Establishes clear success metrics and progress validation framework
   - Balances complexity reduction benefits with implementation risks and resource constraints

## Domain-Specific Rules
- Rule 1: Prioritization matrix must balance multiple criteria with weighted scoring for objective decision-making
- Rule 2: Strategic roadmap must sequence activities to maximize early wins and minimize cumulative risk
- Rule 3: All phases must include measurable success criteria and progress validation checkpoints for effective monitoring

