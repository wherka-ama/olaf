# Prompt Engineering Best Practices

This guide provides specific prompt engineering techniques for optimal results in your applications.

## Core Principles

### 1. Use Imperative Language
Always use commanding, action-oriented language for clarity and consistency:

**Effective patterns:**
- "You WILL" - for required actions
- "You MUST" - for critical requirements  
- "You NEVER" - for prohibited actions
- "MANDATORY" - for non-negotiable requirements
- "CRITICAL" - for extremely important instructions

<Accordion title="Example: Task Instructions">
  **Less effective:**
  ```text
  Please analyze the code and make improvements
  ```

  **More effective:**
  ```text
  You WILL analyze the code structure and identify three specific improvement opportunities. You MUST provide concrete examples for each recommendation.
  ```
</Accordion>

### 2. Be Explicit with Instructions and Success Criteria

Always define what constitutes successful completion:


<Accordion title="Example: Creating an analytics dashboard">
  **Less effective:**

  ```text
  Create an analytics dashboard
  ```

  **More effective:**

  ```text
  You WILL create an analytics dashboard that includes:
  - Real-time data visualization
  - Interactive filtering capabilities
  - Export functionality
  - Mobile-responsive design
  
  Success criteria: Dashboard loads in under 3 seconds and displays data correctly on all screen sizes.
  ```
</Accordion>

### 3. Add Context to Improve Performance

Always explain WHY instructions matter:

<Accordion title="Example: Formatting preferences">
  **Less effective:**

  ```text
  NEVER use ellipses
  ```

  **More effective:**

  ```text
  You MUST avoid ellipses because your response will be read aloud by a text-to-speech engine, and ellipses cannot be properly pronounced by TTS systems.
  ```
</Accordion>

### 4. Structure with XML-Style Markup

Use XML-style tags for complex prompts to improve organization:

```text
<!-- <validation_phase> -->
You WILL first validate all input parameters
<!-- </validation_phase> -->

<!-- <execution_phase> -->  
You WILL then execute the core logic
<!-- </execution_phase> -->

<!-- <output_phase> -->
You WILL generate outputs in the specified format
<!-- </output_phase> -->
```

### 5. Include Validation and Error Handling

Always anticipate and address potential issues:

```text
## Error Handling
You WILL handle these scenarios:
- **Missing Parameters**: Request specific missing items from user
- **Invalid Input**: Provide clear error message and correction guidance
- **Tool Failures**: Offer alternative approaches or manual steps
- **Validation Failures**: Stop process and request user guidance
```

## Advanced Techniques

### Control Response Format with Precision

1. **Tell the model what to do instead of what not to do**

   * Instead of: "Do not use markdown in your response"
   * Try: "You WILL format your response using plain text with clear paragraph breaks"

2. **Use XML format indicators for structured outputs**

   * Try: "You WILL write prose sections in `<prose>` tags and code examples in `<code>` tags"

3. **Match your prompt style to the desired output**

   Removing markdown from your prompt can reduce the volume of markdown in the output.
   Using XML when possible for process oriented prompts.
   Ask for JSON and provide clear structure if you expect structured data.

### Leverage Thinking & Reflection Capabilities

For complex tasks, build in reflection steps:

```text
You WILL follow this process:
1. Analyze the requirements thoroughly
2. Reflect on potential approaches and their trade-offs  
3. Select the optimal approach with clear rationale
4. Execute the solution
5. Validate results against success criteria
```

### Optimize Tool Usage and Workflows

**For parallel operations:**
```text
You WILL invoke multiple independent tools simultaneously when possible: [tool_1], [tool_2], [tool_3]. You MUST NOT execute these sequentially unless dependencies require it.
```

**For file management:**
```text
You WILL clean up temporary files created during execution. You MUST remove any helper files, scripts, or intermediate outputs that are not part of the final deliverable.
```

### Enhance Code Generation Quality

For development tasks, include quality requirements:

```text
You WILL implement a high-quality, production-ready solution that:
- Works correctly for all valid inputs, not just test cases
- Follows established design patterns and best practices
- Includes appropriate error handling and validation
- Is maintainable and well-documented
- Avoids hard-coded values or test-specific implementations

CRITICAL: If requirements are unclear or infeasible, you MUST request clarification rather than making assumptions.
```

## Prompt Engineering Workflow

### 1. Design Phase
- Define clear objectives and success criteria
- Identify required inputs and expected outputs
- Plan user interaction points and decision flows

### 2. Implementation Phase  
- Use imperative language consistently
- Structure with clear phases and validation steps
- Include comprehensive error handling

### 3. Testing Phase
- Test with realistic scenarios
- Validate edge cases and error conditions  
- Iterate based on results

### 4. Validation Phase
- Ensure consistent execution across different inputs
- Verify outputs meet quality standards
- Document any limitations or assumptions

## Quality Standards

### Successful Prompts Achieve:
- **Clear Execution**: No ambiguity about required actions
- **Consistent Results**: Similar inputs produce similar quality outputs  
- **Complete Coverage**: All necessary aspects are addressed
- **Error Resilience**: Graceful handling of edge cases
- **User-Friendly**: Clear communication and interaction patterns

### Common Pitfalls to Avoid:
- Vague success criteria ("make it good" → specify measurable outcomes)
- Missing context (explain why instructions matter)
- Conflicting requirements (review for contradictions)
- Overly complex logic (break into clear phases)
- No validation steps (always include result verification)

## Template Structure

Every prompt should include:
1. **Clear Objectives**: What needs to be accomplished
2. **Input Validation**: Required parameters and prerequisites  
3. **Process Steps**: Logical execution flow with decision points
4. **Output Specification**: Format and quality requirements
5. **Error Handling**: Specific scenarios and responses
6. **Success Criteria**: Measurable completion requirements

⚠️ **Critical Requirements**
- MANDATORY: Test all prompts before deployment
- NEVER deploy prompts without validation scenarios
- ALWAYS include user interaction protocols
- ALWAYS provide rollback capabilities for destructive operations
- ALWAYS document assumptions and limitations clearly
