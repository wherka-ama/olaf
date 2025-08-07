---
name: generate-mcp-client
description: Generate a complete, runnable Model Context Protocol (MCP) client application.
tags: [mcp, client, generation, api, agent, workflow]
---

## Time Retrieval
Get current time in YYYYMMDD-HHmm format using terminal:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **language**: `python`|`typescript` - The programming language for the client.
- **llm_provider**: `anthropic`|`openai` - The LLM provider to use for chat completions.
- **project_name**: string - The name for the client project directory.

## Process

1.  **Analyze Request**:
    - Validate that `language` and `llm_provider` are supported.
    - Confirm a `project_name` has been provided.

2.  **Environment Setup Commands**:
    - Generate and display the shell commands to perform the following:
        - Create a directory named `[project_name]`.
        - Change into the new directory.
        - **If `language` is `python`**:
            - Run `uv init`.
            - Run `uv venv`.
            - Run `uv add mcp [llm_provider_sdk] python-dotenv` (e.g., `uv add mcp anthropic python-dotenv`).
            - Provide activation instructions for the virtual environment.
        - **If `language` is `typescript`**:
            - Run `npm init -y`.
            - Run `npm install @modelcontextprotocol/sdk [llm_provider_sdk] dotenv` (e.g., `npm install @modelcontextprotocol/sdk @anthropic-ai/sdk dotenv`).
            - Run `npm install -D @types/node typescript`.
        - Create a `.env` file and a `.gitignore` file that includes `.env`.

3.  **Client Code Generation**:
    - Create the main client file (`client.py` or `index.ts`).
    - Generate the full, runnable code for an `MCPClient` class based on the tutorials and best practices. The class must include:
        - **Initialization**: Sets up `AsyncExitStack` (or equivalent) and the client for the specified `[llm_provider]`.
        - **`connect_to_server(server_script_path)`**: A method to connect to a stdio MCP server, initialize the session, and list available tools.
        - **`process_query(query)`**: The core logic that sends the user query and available tools to the LLM, processes the response, and calls `session.call_tool` if the LLM requests a tool use.
        - **`chat_loop()`**: An interactive loop for the user to input queries.
        - **Main Entry Point**: Logic to parse command-line arguments for the server script path, create a client instance, and run the chat loop.

## Output to USER
- Display the generated code for the main client file (`client.py` or `index.ts`) in a markdown block.
- Display the shell commands for setting up the environment.
- Provide clear instructions on how to:
    1.  Save the API key in the `.env` file.
    2.  Run the setup commands.
    3.  Run the client, including an example command: `uv run client.py <path_to_server_script>` or `npx ts-node index.ts <path_to_server_script>`.

## Domain-Specific Rules
- Rule 1: The generated code must be complete and runnable without modification.
- Rule 2: All necessary imports and dependencies must be included.
- Rule 3: API keys must be loaded from the `.env` file and never hardcoded.

⚠️ **Critical Notes**
- Remind the USER to replace `<your key here>` in the `.env` file with their actual API key.
- The client expects the path to an MCP server script as a command-line argument.
