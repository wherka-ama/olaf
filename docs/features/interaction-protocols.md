# Interaction Protocols

Our interaction model is governed by distinct protocols.

We did that to assist users that are fearful of AI agents and to provide a safe environment for them to interact with AI agents.

## Protocol Types

1. **"Act"**: In which case the Model, hence the Agent, is encouraged to carry out the action without any confirmation
2. **"Propose-Act"**: The agent states the action it will do, may ask for an answer, and executes it in the same step
3. **"Propose-Confirm-Act"**: This is encouraged for any action that modifies, creates, or deletes files. The agent must propose the action, ask for confirmation, and wait for user approval before proceeding

## Configuration

Protocols are set per pre-recorded Workflow and prompt. Some prompts benefit from a "Propose-Act" protocol while others benefit from a "Act" protocol. It can be modified of set in the query-competency-index.md.

## Important Notes

The way the protocol reacts strongly depends on the model used. Some models may not be able to handle the "Propose-Act" protocol. Some models may not be able to handle the "Propose-Confirm-Act" protocol.

## Future Directions

We encourage further exploration and refinement of these protocols to enhance user experience and safety. We experimented with multiperson interactions to better understand collaborative workflows and how these protocols can be adapted for group settings.
These prove useful for some users as each persona can be configured with a specific role. We found it to work very well with the roo-code agent as it supports such personas and profiles.