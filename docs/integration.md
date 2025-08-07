# Integration with Agents

## Core Files
One essential file is:
- `ack/memory-map.md`, which provides the LLM with key context pointers (files or structure) - or in .windsurf/rules/memory-map.md

This file should be loaded by the LLM at the start of each interaction. This is why we rely on the agent's capabilities to do so (e.g., `.windsurf/team.md` for Windsurf).

Additionally, the instructions file references other important files that are essential for the interaction (i.e. `ack/core-principles.md` and `ack/query-competency-index.md`).

The contents of these files are loaded into the context windows of the LLM when the interaction begins. Therefore, it is crucial to keep the information concise and provide clear context.

## Helpers prompts
Most Agents allows to provide a set of "helpers" prompts that are used to list and use the competencies. 
We provide:
- `.windsurf/prompts/list-competencies.md` : a prompt that lists all the competencies available in the index file.
- `.windsurf/prompts/use-competency.md` : a prompt that uses a competency based on a user's request.

## Models tested

As of 2025-06-27: we don't have a model that works perfectly with OLAF.

Context management done by the agent is significantly interfering with the interaction, hence we strongly encourage testing the competencies, and even improving them for a duo: Agent + Model.

**Good results**:
- Claude Sonnet 4 and 4 Thinking

**Satisfactory results**:
- Anthropic Sonnet 3.7
- Gemini 2.5 PRO (preview)

**Limited results**:
- OpenAI GPT 4.1 or 4o min. those models require "baby-sitting" most most prompts.

**Not tested**:
- OpenAI 0x models (Too expensive or not available)
- DeepSeek Rx (Not available)
