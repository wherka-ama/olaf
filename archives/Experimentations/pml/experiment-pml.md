# Prompt Markup Language (PML)

This project experiments with **Prompt Markup Language (PML)**, a structured, XML-inspired format designed for authoring, maintaining, and versioning AI prompt files. PML enables clear definition of prompt metadata, context, inputs, outputs, and workflow, supporting robust prompt engineering and automation across the OLAF platform.


- All PML files are located in `[id:prompts_dir]` (`olaf-core-knowldege/prompts`).
- A loonnnng  `pml.xsd` for schema details and validation.

### Outcomes
Using PML seems providing some benefits:
- better and more reproducible prompt engineering for modles such as Gemini 2.5 PRO and Claude Sonnet 3.7
- it is consuming for more tokens that makdown equivalent. so not a good idea for Solution based on Bring Your Own Model (BYOM)
- XML is not easy to read and write. so not a good idea for simple prompts.
- Meta-prompting helps as lot hre , but require high level models with large context window to succeed ( so use Gemini 2.5 PRO was out best choice for that 

### Decision Record
We found that PML is not a good idea for simple prompts and small projects. It is more adapted for large projects with complex prompts and workflows.
Also it relies on the hypothesis that models are trained mostly with XML structured prompts. Which we could not confirm. Anthropic being one supplier that sort of confirms this.

So we will not use PML for OLAF in teh future but keep i in certain prompts for now.

PML prompt files ending with the suffix `-pml.md` are PML structured prompts.




