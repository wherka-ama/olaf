---
name: create-mcp-client
description: Generate a complete, production-ready Model Context Protocol (MCP) client application.
tags: [mcp, client, protocol, agent, integration]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **language**: `python`|`typescript` - The programming language for the client implementation.
- **llm_provider**: `anthropic`|`openai`|`gemini` - The LLM provider to use for chat completions.
- **project_name**: string - Name for the client project directory (alphanumeric + hyphens/underscores).
- **features**: array<`tool_use`|`streaming`|`error_handling`|`logging`> - Optional features to include.

## Process

1. **Environment Setup**
   - Generate shell commands to:
     - Create project directory: `mkdir -p [project_name]`
     - Initialize project:
       - Python: `uv init`, `uv venv`, `uv add mcp [llm_provider_sdk] python-dotenv structlog`
       - TypeScript: `npm init -y`, `npm install @modelcontextprotocol/sdk [llm_provider_sdk] dotenv pino`
     - Create `.env` and `.gitignore` files
     - Set up basic project structure

2. **Core Client Implementation**
   - Generate `MCPClient` class with:
     - Async context manager pattern
     - Connection management
     - Session handling
     - Tool registration and invocation
     - Error handling and recovery
     - Logging configuration

3. **Feature Implementation**
   - Tool Use: Dynamic tool discovery and execution
   - Streaming: Support for streaming responses
   - Error Handling: Comprehensive error types and recovery
   - Logging: Structured logging with different levels

4. **Example Usage**
   - Basic client initialization
   - Tool registration example
   - Sample interaction flow
   - Error handling demonstration

## Output Format

```markdown
# MCP Client Implementation: [project_name]

## Setup Instructions

```bash
# Environment setup
[generated shell commands]
```

## Project Structure

```
[project_name]/
├── src/
│   ├── client.[py|ts]     # Main client implementation
│   ├── tools/            # Custom tools
│   └── utils/            # Utility functions
├── tests/                # Test files
├── .env                  # Environment variables
└── README.md             # Project documentation
```

## Usage Example

```[language]
[generated example code]
```

## Configuration

Update `.env` with your credentials:

```env
# For OpenAI
OPENAI_API_KEY=your_api_key_here

# For Anthropic
ANTHROPIC_API_KEY=your_api_key_here

# For Gemini
GEMINI_API_KEY=your_api_key_here
```

## Running the Client

```bash
# Python
uv run src/client.py

# TypeScript
npx ts-node src/client.ts
```
```

## Best Practices
- Always validate tool schemas at runtime
- Implement proper error boundaries
- Use structured logging for observability
- Handle token limits and rate limiting
- Include comprehensive type definitions
- Write unit tests for core functionality

## Security Considerations
- Never commit API keys to version control
- Validate all inputs and outputs
- Implement proper error messages
- Follow the principle of least privilege
- Use environment variables for configuration

## Troubleshooting
1. Check API key permissions
2. Verify network connectivity
3. Review server logs
4. Check API rate limits
5. Validate request/response formats

## Additional Resources
- [MCP Documentation](https://modelcontextprotocol.io)
- [Example Implementations](https://github.com/modelcontextprotocol/examples)
- [API Reference](https://modelcontextprotocol.io/api)
```

## Validation Rules
1. Code must be production-ready with proper error handling
2. All external dependencies must be explicitly declared
3. Include comprehensive type hints/TypeScript types
4. Follow language-specific style guides (PEP 8 for Python, ESLint for TypeScript)
5. Include input validation and sanitization

## Example Prompts

```
Create a Python MCP client with OpenAI integration and tool use support
```

```
Generate a TypeScript MCP client for Anthropic with streaming and error handling
```
