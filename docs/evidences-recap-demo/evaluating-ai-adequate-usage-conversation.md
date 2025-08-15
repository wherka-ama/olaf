 invoke use-competency.prompt.md in .github/prompts/ by typing /use-competency

pppaccau_amadeus: Follow instructions in [use-competency.prompt.md](file:///c%3A/Users/ppaccaud/coderepos/demo-2025-08-14/generic-demo/.github/prompts/use-competency.prompt.md).
should I use AI

GitHub Copilot: I will follow the instructions in [use-competency.prompt.md] and consult the full <olaf-query-competency-index> to determine the relevant competency for your question: "should I use AI".

I will now search the <olaf-query-competency-index> for tasks, workflows, or prompts related to evaluating or deciding on the use of AI, and then execute the relevant protocol as defined.

Proceeding to identify the matching competency and protocol. Your question matches the competency: [["should i use ai", "use ai for", "ai or ide", "ai vs ide"], "other-users/should-i-use-ai.md", "Act"].

**Protocol:** Act  
**Workflow:** should-i-use-ai.md

I will now analyze your task using the LLM vs IDE categorization guide and provide a recommendation.

Since your input is "should I use AI" (no specific task described), here is the general guidance:

🧠 **Recommendation: Use AI/LLM**  
**Task Category**: Decision Support / Task Analysis

**Why AI**: Deciding whether to use AI or IDE tools requires reasoning about the nature of your task, context, and goals. AI excels at analyzing ambiguous or open-ended questions and can help you determine the best tool for your needs. For specific tasks, refer to the LLM vs IDE categorization guide to decide.

If you have a specific task in mind, please describe it in one sentence for a tailored recommendation.

pppaccau_amadeus: should i use it to rename a symbol through my code base

GitHub Copilot: 🔧 **Recommendation: Use IDE Tools**

**Task Category**: Basic Code Manipulation

**Specific Actions**:
- IDE Feature: Use the "Rename Symbol" or "Refactor → Rename" feature in your IDE (e.g., F2 in VS Code, Shift+F6 in JetBrains IDEs)
- Keyboard Shortcut: F2 (VS Code), Shift+F6 (IntelliJ/Eclipse)
- CLI Alternative: Use language-specific refactoring tools (e.g., `pylint`, `clang-rename`)
- External Tool: Not typically needed

**Why IDE**: Renaming symbols is a mechanical, pattern-based operation that IDEs handle efficiently and safely across your codebase.