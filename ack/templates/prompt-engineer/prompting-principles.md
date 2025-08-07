# Prompt engineering best practices

This guide provides specific prompt engineering techniques for most models to help you achieve optimal results in your applications.

## General principles

### Be explicit with your instructions


<Accordion title="Example: Creating an analytics dashboard">
  **Less effective:**

  ```text
  Create an analytics dashboard
  ```

  **More effective:**

  ```text
  Create an analytics dashboard. Include as many relevant features and interactions as possible. Go beyond the basics to create a fully-featured implementation.
  ```
</Accordion>

### Add context to improve performance

<Accordion title="Example: Formatting preferences">
  **Less effective:**

  ```text
  NEVER use ellipses
  ```

  **More effective:**

  ```text
  Your response will be read aloud by a text-to-speech engine, so never use ellipses since the text-to-speech engine will not know how to pronounce them.
  ```
</Accordion>


### Be vigilant with examples & details

## Guidance for specific situations

### Control the format of responses

1. **Tell the model what to do instead of what not to do**

   * Instead of: "Do not use markdown in your response"
   * Try: "Your response should be composed of smoothly flowing prose paragraphs."

2. **Use XML format indicators (if supported by the model)**

   * Try: "Write the prose sections of your response in \<smoothly\_flowing\_prose\_paragraphs> tags."

3. **Match your prompt style to the desired output**

   Removing markdown from your prompt can reduce the volume of markdown in the output.
   Using XML when possible for process oriented prompts.
   Ask for JSON and provide clear structure if you expect structured data.

### Leverage thinking & interleaved thinking capabilities
for complex tasks, use reflection: 

```text Example prompt
After receiving tool results, carefully reflect on their quality and determine optimal next steps before proceeding. Use your thinking to plan and iterate based on this new information, and then take the best next action.
```

### Optimize parallel tool calling

Be specific about calls that can be made by model. This prompt can be effective:

```text Sample prompt for agents
For maximum efficiency, whenever you need to perform multiple independent operations, invoke the following relevant tools <tool names> simultaneously rather than sequentially.
```

### Reduce file creation in agentic coding

If you'd prefer to minimize net new file creation, you can instruct the model to clean up after itself:

```text Sample prompt
If you create any temporary new files, scripts, or helper files for iteration, clean up these files by removing them at the end of the task.
```

### Enhance visual and frontend code generation

For frontend code generation improve frontend performance in specific areas by providing additional modifiers and details on what to focus on:

* "Include as many relevant features and interactions as possible"
* "Add thoughtful details like hover states, transitions, and micro-interactions"
* "Create an impressive demonstration showcasing web development capabilities"
* "Apply design principles: hierarchy, contrast, balance, and movement"

### Avoid focusing on passing tests and hard-coding

```text Sample prompt
Please write a high quality, general purpose solution. Implement a solution that works correctly for all valid inputs, not just the test cases. Do not hard-code values or create solutions that only work for specific test inputs. Instead, implement the actual logic that solves the problem generally.

Focus on understanding the problem requirements and implementing the correct algorithm. Tests are there to verify correctness, not to define the solution. Provide a principled implementation that follows best practices and software design principles.

If the task is unreasonable or infeasible, or if any of the tests are incorrect, please tell me. The solution should be robust, maintainable, and extendable.
```
