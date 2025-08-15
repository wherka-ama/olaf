# OLAF Conversational Examples

**Version**: All demos were conducted using OLAF 1.3.0

## General Comments

**Data Collection Method**: Examples captured from agent viewport using "copy all" and saved as markdown files.

**Prerequisites**: Some examples require specific data in the `id:findings_dir` folder:
- **CVE verifier**: Needs `cve-verifier` folder with `blackduck.csv` file (Excel format saved as CSV)
- **Unit test augmentation**: Requires tracking tasklist or progress files
- **Research/report and DFD prompts**: Need similar supporting files

**Test Codebases Used**:
- **Public repos**: code2dfd (for DFD and rebuild spec), roo-code (for complexity reduction)
- **Internal repos**: rot (for multiple respect tests), jal-dapi-ext (for CVE verifier)

**Recommendations**:
- Use small, realistic codebases for testing
- Small enough to see complete results (DFD, rebuild spec)
- Realistic enough to demonstrate tool capabilities (avoid "hello world" examples)

**Model Performance**:
- **Primary model**: Sonnet4 (most examples use this)
- **Alternative models**: Sonnet3.5 and Gemini 2.5 Pro work adequately
- **GPT models**: Latest GPT5 has internal routing that may vary results; Windsurf allows model selection control

**Display Notes**:
- Reports don't show exact agent viewport details
- Tool call specifics (file reading) are abbreviated
- Real usernames obfuscated (visible in saved conversations)

## OLAF Examples

### Core Framework Examples
- **[Initialization Process](using-reinit-command-conversation.md)** - Shows OLAF tag usage and session reinitialization
- **[Sonnet4 vs GPT4.1 Comparison](using-with-sonnet4-conversation.md)** - Demonstrates initialization sequence respect differences
- **[GPT4.1 Usage](using-with-gpt41-conversation.md)** - Research workflow with different model behavior
- **[Framework Explanation](vibe-prompting-olaf-conversation.md)** - Concise explanation of initialization and protocols

### Prompt Engineering Examples
- **[Create Prompt Workflow](create-prompt-conversation.md)** - Shows prompt creation, testing, and template compliance
- **[Execute Old Prompt](show-how-executing-old-prompt-conversation.md)** - Demonstrates DFD workflow execution on code2dfd

### Competency and Process Examples
- **[List Competencies](list-competencies-conversation.md)** - Shows competency index usage and team process queries
- **[AI Usage Evaluation](evaluating-ai-adequate-usage-conversation.md)** - Demonstrates AI vs IDE decision framework
- **[People Register Usage](getting-contact-from-people-register-conversation.md)** - Shows expert contact identification

### Advanced Workflow Examples
- **[CVE Analysis](cve-exposure-conversation.md)** - Complete CVE descriptor creation workflow with Sonnet4
- **[ADS Process Interaction](interact-with-ads-conversation.md)** - Vague prompt usage for project-specific processes
