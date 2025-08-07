# Best Practices

## Best Practices
1. **Maintain Clear Documentation**: Ensure that all prompts are written in a clear, concise, and consistent manner using markdown format. Note that some models may have been trained using other formats, such as XML, and may respond better to prompts in those formats.
2. **Document Prompt Authorship**: To give credit to the original authors, it is recommended to include comments in prompt files indicating who wrote the prompt and when. This can be done using HTML comments, which will not be visible in the rendered output. For example:
   ```markdown
   <!--
   Author: John Doe
   Date: 2025-06-24
   -->
   ```
3. **Version Control all Configurations**: Use version control to track all changes to configurations, including those made in and by OLAF. This will help ensure that changes are properly recorded and can be easily reverted if needed. In our experience, using OLAF to build itself resulted in a significant increase in the number of changes and fixes that could be made in a day, and we found it necessary to create a competency to assist in committing changes based on the changelog-register with clearer commit messages.
4. **Use Standardized Templates for Consistency**: Use standardized templates for the output of competencies to ensure consistency and easier maintenance. While the output of competencies can be defined in the prompt, using templates helps to ensure that the output is consistent and follows a standard format.
5. **Follow Persona-Specific Workflows**: Follow persona-specific workflows to maintain an engaging interaction with AI personas. While competencies are designed to be agnostic of the personas, following persona-specific workflows helps to ensure that the interaction is productive and efficient.

## Critical Notes
- **This is a work in progress** and we are still exploring the best way to use OLAF. You need to **read carefully and understand what the AI answers**. Avoid just entering the 'YES/DO it/Correct/OK' without really reading. This is not a Genius, THIS is an Assistant.
- Models may fail to answer (resource limit, latency, etc.). Most agents gracefully handle this but you may need to retry. Don't blame your OLAF assistant.
