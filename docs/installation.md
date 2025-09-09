# Installation Guide

## How to install
To use OLAF, you need to copy the `/ack` and `/ads` folders side by side with your project.

- **/ack for Assistant Core Knowledge**: this is the folder that contains all the artifacts that are used by the AI to perform their tasks. It is the core of OLAF.
- **/ads for Assistant Data Store**: this is the folder that contains all the artifacts that are produced or used by OLAF to perform its tasks.

Note: If you are working with a version control system (e.g.; GitLab, GitHub, etc.), you can (should) include this into your project.

## Step-by-Step Getting Started

1. **Copy the `/ack` and `/ads` folders alongside a repository of code and/or documentation**:
	* DO NOT change these folders' structure until you understand the OLAF principles
2. **Use windsurf (preferred) or may be GitHub Copilot in Agent Mode**
	*  You can adapt OLAF to other AI agents you use. For most agents, the key files you need to configure are `.windsurf/rules/team.md` and `.windsurf/prompts/xxx.md` files. Be careful with the prompts as different agents may not use the same preamble format as Windsurf.
	* Be careful as OLAF may consume your credits at a faster rate than any human can. Especialy if you use the "Propose-Confirm-Act" protocol and use an model for with the agent provide charge premium-requests.
3. **Read the `.windsurf/rules/team.md` and `.windsurf/prompts/xxx.md` and the `/.windsurf/rules/memory-map.md` files**:
	* Open and read these files to understand the context and memory map of your project
	* We recommend to keep them as is for the time being. Don't feel too smart with those until you understand the OLAF principles.
4. **Explore the competencies**:
	* Choose a competency and explore its structure - prompt, and potentially template and script
	* Use a competency to perform a simple task, such as research-and-report
5. **Find the output of the competencies and move it to the right place if needed**:
	* After using a competency, find the output and move it to the right place in your project, or delete it if it is not needed
	* in this incarnation, we tried to locate all outputs in /olaf-data-store/findings/ or a a subfolder of it, but this is not guaranteed
6. **Ask the AI to create a new changelog**:
	* Use the `create-changelog-entry` command to ask the AI to create a new changelog for your project
  * note that the AI will react differently depending on the context you went through. This is an important aspect of current generative AI.
7. **Ask the AI to create a new job**:
	* Use the `create-job` command to ask the AI to create a new job for your project
	* Describe the job using your wording - try to be clear and concise but with enough details
8. **You're ready to go!**:
	* From here, you should be able to manage your way with the rest of the competencies
	* You may want to create a new competency using the `learn-competency` or explore other features of OLAF
