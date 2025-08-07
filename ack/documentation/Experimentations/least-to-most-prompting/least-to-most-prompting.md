# Least-to-Most Prompting Strategy

## Overview

The "Least-to-Most" prompting strategy is a technique that involves breaking down complex tasks into smaller, manageable sub-problems. This approach is inspired by concepts from resources like [learnprompting.org](https://learnprompting.org/docs/intermediate/least_to_most) and the Cognition AI paper advocating against monolithic multi-agent systems (https://cognition.ai/blog/dont-build-multi-agents). The core idea is to sequentially solve sub-problems, using the output from one step as the input for the next, creating a coherent chain of reasoning.

This method allows for the application of smaller, more focused prompts, with results collected throughout a single or sequenced agent session.

## Implementation Example: Code Complexity Reduction

An example of this strategy can be found within this repository in the `/ack/prompts/reduce-code-complexity/` directory. It features an orchestrator with corresponding sub-flows and prompts designed to implement the least-to-most prompting technique.

This workflow has been successfully applied to reduce code complexity in a public JavaScript/TypeScript project.

Scripts have been tested for this specific implementation, but additional scripts and prompts are also provided for other languages. However, these have not been tested and are generated outputs - users should expect potential bugs and issues if using thoses. We may never fix those. 