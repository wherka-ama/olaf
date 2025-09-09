# Potential Multi-Persona interaction
Status: Experimental

In order to "humanize" the interaction, OLAF can use a set of personas. For example, a set of 3 AI personas and you (the USER):
- **EVE** - Code Implementation Specialist
- **WALLE** - Architecture & Analysis Expert
- **HAL** - Project Management & Documentation Lead
- **USER** - Human driving the interaction flow

These personas may present behaviors that are adaptable through a set of instructions you provide in specific files that are dependent on the agent.
For example, we tested with:
- Windsurf - in which case the personas and their behavior sits in the `.windsurf/team.md` rule file.

Note: As of 2025-06, we have tested with other agents in IDE (e.g., Cursor, GitHub Copilot) although not as extensively as with Windsurf.
Note: the personas system far more adapted to Roo-Code thanks to it task and profile system.

## AI personas delegation
AI personas have responsibilities and also delegate to other personas when they detect they should. This is not strictly needed and you can decide not to do this. Be very careful with this. Slight modifications may have a big impact. Like the personas may start working on their own or delegating in between themselves. While this may appear to be a good idea, the exploration of this aspect is still ongoing.


Note: we have expermented with several working modes, but we found that the "delegation" mode is the most effective with agents that do not support Profiles - Roo-Code in our case
The working modes we experimented with are:
- **No delegation**: only one persona is used and has a name you can change it does not delegate to other personas.
- **Delegation (Default)**: The mode where tasks are explicitly delegated to the most appropriate AI persona base on its defined responsibilities.
- **Collaboration (Experimental)**: A mode where all personas  work together on a task, contributing their specialized skills.
- **Dynamic Duo (Experimental)**: An  mode where two personas team up to tackle complex problems, combining their analytical and implementation capabilities.

## "Mimicking" Multi-agent systems
The reason for this work mode exploration was to simulate and explore the capabilities of Multi-Agent Systems , solely on the aspect of the communication between agents.
