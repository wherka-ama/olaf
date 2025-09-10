# Cyclomatic Complexity Analysis - Roo-Code

**Analysis Date**: 20250910-1218 CEDT  
**Repository**: C:\Users\ppaccaud\coderepos\olaf-test-onboarding\Roo-Code  
**Analysis Type**: Foundation Phase - Task 4
**Script Integration**: ✅ Enhanced with automated complexity analysis
**Files analyzed**: 1164  
**Functions/methods analyzed**: 4133

## Overview

Cyclomatic Complexity (CC) measures the number of linearly independent paths through a program's source code.
It directly corresponds to the number of test cases needed to achieve complete branch coverage.

## Executive Summary
Based on automated script analysis, Roo-Code demonstrates **moderate complexity** with an average cyclomatic complexity of **4.93**. However, the repository contains **34 extremely high complexity functions** (CC > 50), with the most complex function reaching **641 complexity points** in `webviewMessageHandler.ts`. This indicates significant refactoring opportunities for maintainability improvement.

## Summary Statistics

- **Average Complexity**: 4.93
- **Maximum Complexity**: 641
- **Functions with CC > 10**: 341 (8.3%)

## Complexity Distribution

| Complexity Range | Function Count | Percentage |
|------------------|---------------|-----------|
| Low (1-5) | 3356 | 81.2% |
| Moderate (6-10) | 436 | 10.5% |
| High (11-20) | 208 | 5.0% |
| Very High (21-50) | 99 | 2.4% |
| Extremely High (50+) | 34 | 0.8% |

## Most Complex Functions

The following functions have the highest cyclomatic complexity (ordered from most to least complex):

| File | Function | Line | Line Count | Complexity | Density |
|------|----------|------|-----------|------------|---------|
| src\core\webview\webviewMessageHandler.ts | switch | 426 | 2576 | 641 | 0.249 |
| src\api\providers\openai-native.ts | handleStreamResponse | 651 | 445 | 276 | 0.62 |
| src\core\webview\ClineProvider.ts | getStateToPostToWebview | 1693 | 228 | 180 | 0.789 |
| apps\vscode-e2e\src\suite\tools\search-files.test.ts | suite | 11 | 924 | 174 | 0.188 |
| apps\vscode-e2e\src\suite\tools\read-file.test.ts | suite | 12 | 767 | 161 | 0.21 |
| apps\vscode-e2e\src\suite\tools\use-mcp-tool.test.ts | skip | 12 | 917 | 161 | 0.176 |
| src\core\assistant-message\presentAssistantMessage.ts | presentAssistantMessage | 58 | 556 | 150 | 0.27 |
| webview-ui\src\components\ui\hooks\useSelectedModel.ts | switch | 129 | 265 | 149 | 0.562 |
| src\shared\ExtensionMessage.ts | File_Level | 1 | 460 | 138 | 0.3 |
| webview-ui\src\utils\command-validation.ts | File_Level | 1 | 760 | 113 | 0.149 |
| webview-ui\src\components\chat\ChatRow.tsx | switch | 956 | 598 | 103 | 0.172 |
| src\core\task\Task.ts | while | 1708 | 629 | 102 | 0.162 |
| apps\vscode-e2e\src\suite\tools\apply-diff.test.ts | suite | 11 | 740 | 95 | 0.128 |
| webview-ui\src\components\settings\ModelInfoView.tsx | File_Level | 1 | 217 | 94 | 0.433 |
| apps\vscode-e2e\src\suite\tools\search-and-replace.test.ts | suite | 11 | 621 | 93 | 0.15 |
| apps\vscode-e2e\src\suite\tools\insert-content.test.ts | suite | 11 | 618 | 92 | 0.149 |
| webview-ui\src\components\chat\ChatRow.tsx | if | 354 | 601 | 91 | 0.151 |
| src\services\code-index\config-manager.ts | doesConfigChangeRequireRestart | 257 | 99 | 87 | 0.879 |
| apps\vscode-e2e\src\suite\tools\execute-command.test.ts | suite | 11 | 548 | 72 | 0.131 |
| src\core\task\Task.ts | attemptApiRequest | 2489 | 292 | 70 | 0.24 |

## Functions Exceeding Threshold (CC > 10)

The following functions exceed the complexity threshold and should be prioritized for refactoring:

| File | Function | Line | Line Count | Complexity | Density |
|------|----------|------|-----------|------------|---------|
| src\core\webview\webviewMessageHandler.ts | switch | 426 | 2576 | 641 | 0.249 |
| src\api\providers\openai-native.ts | handleStreamResponse | 651 | 445 | 276 | 0.62 |
| src\core\webview\ClineProvider.ts | getStateToPostToWebview | 1693 | 228 | 180 | 0.789 |
| apps\vscode-e2e\src\suite\tools\search-files.test.ts | suite | 11 | 924 | 174 | 0.188 |
| apps\vscode-e2e\src\suite\tools\read-file.test.ts | suite | 12 | 767 | 161 | 0.21 |
| apps\vscode-e2e\src\suite\tools\use-mcp-tool.test.ts | skip | 12 | 917 | 161 | 0.176 |
| src\core\assistant-message\presentAssistantMessage.ts | presentAssistantMessage | 58 | 556 | 150 | 0.27 |
| webview-ui\src\components\ui\hooks\useSelectedModel.ts | switch | 129 | 265 | 149 | 0.562 |
| src\shared\ExtensionMessage.ts | File_Level | 1 | 460 | 138 | 0.3 |
| webview-ui\src\utils\command-validation.ts | File_Level | 1 | 760 | 113 | 0.149 |
| webview-ui\src\components\chat\ChatRow.tsx | switch | 956 | 598 | 103 | 0.172 |
| src\core\task\Task.ts | while | 1708 | 629 | 102 | 0.162 |
| apps\vscode-e2e\src\suite\tools\apply-diff.test.ts | suite | 11 | 740 | 95 | 0.128 |
| webview-ui\src\components\settings\ModelInfoView.tsx | File_Level | 1 | 217 | 94 | 0.433 |
| apps\vscode-e2e\src\suite\tools\search-and-replace.test.ts | suite | 11 | 621 | 93 | 0.15 |
| apps\vscode-e2e\src\suite\tools\insert-content.test.ts | suite | 11 | 618 | 92 | 0.149 |
| webview-ui\src\components\chat\ChatRow.tsx | if | 354 | 601 | 91 | 0.151 |
| src\services\code-index\config-manager.ts | doesConfigChangeRequireRestart | 257 | 99 | 87 | 0.879 |
| apps\vscode-e2e\src\suite\tools\execute-command.test.ts | suite | 11 | 548 | 72 | 0.131 |
| src\core\task\Task.ts | attemptApiRequest | 2489 | 292 | 70 | 0.24 |
| src\api\providers\bedrock.ts | await | 426 | 157 | 66 | 0.42 |
| src\api\providers\openai-native.ts | processEvent | 1100 | 82 | 66 | 0.805 |
| apps\vscode-e2e\src\suite\tools\list-files.test.ts | suite | 11 | 566 | 65 | 0.115 |
| src\core\tools\multiApplyDiffTool.ts | for | 400 | 251 | 65 | 0.259 |
| apps\vscode-e2e\src\suite\tools\write-to-file.test.ts | suite | 11 | 438 | 63 | 0.144 |
| src\shared\WebviewMessage.ts | File_Level | 1 | 341 | 62 | 0.182 |
| webview-ui\src\components\chat\TaskHeader.tsx | File_Level | 1 | 292 | 62 | 0.212 |
| src\core\task\Task.ts | resumeTaskFromHistory | 1220 | 259 | 59 | 0.228 |
| src\core\environment\getEnvironmentDetails.ts | getEnvironmentDetails | 24 | 254 | 57 | 0.224 |
| src\core\tools\applyDiffTool.ts | if | 39 | 211 | 57 | 0.27 |
| src\services\code-index\config-manager.ts | _loadAndSetConfiguration | 44 | 89 | 54 | 0.607 |
| webview-ui\src\components\chat\ChatView.tsx | if | 274 | 168 | 54 | 0.321 |
| apps\vscode-e2e\src\suite\markdown-lists.test.ts | suite | 8 | 161 | 53 | 0.329 |
| webview-ui\src\utils\validate.ts | validateModelsAndKeysProvided | 28 | 124 | 52 | 0.419 |
| webview-ui\src\utils\__tests__\command-validation.spec.ts | File_Level | 1 | 1433 | 50 | 0.035 |
| src\core\tools\writeToFileTool.ts | if | 103 | 210 | 46 | 0.219 |
| apps\web-roo-code\src\app\evals\evals.tsx | Evals | 12 | 138 | 45 | 0.326 |
| src\core\tools\readFileTool.ts | if | 268 | 167 | 45 | 0.269 |
| src\extension.ts | activate | 62 | 294 | 44 | 0.15 |
| src\core\assistant-message\parseAssistantMessageV2.ts | parseAssistantMessageV2 | 40 | 242 | 43 | 0.178 |
| src\services\tree-sitter\languageParser.ts | loadRequiredLanguageParsers | 78 | 154 | 43 | 0.279 |
| src\shared\getApiMetrics.ts | getApiMetrics | 29 | 77 | 42 | 0.545 |
| webview-ui\src\components\chat\ChatView.tsx | switch | 772 | 50 | 42 | 0.84 |
| src\api\providers\openai.ts | if | 102 | 154 | 41 | 0.266 |
| src\integrations\diagnostics\index.ts | if | 90 | 151 | 41 | 0.272 |
| src\utils\xml-matcher.ts | _update | 44 | 49 | 41 | 0.837 |
| src\integrations\misc\open-file.ts | openFile | 13 | 141 | 40 | 0.284 |
| src\api\index.ts | buildApiHandler | 90 | 83 | 39 | 0.47 |
| src\api\transform\bedrock-converse-format.ts | convertToBedrockConverseMessages | 28 | 167 | 39 | 0.234 |
| src\core\diff\strategies\multi-file-search-replace.ts | for | 491 | 205 | 39 | 0.19 |
| src\core\diff\strategies\multi-search-replace.ts | for | 408 | 193 | 39 | 0.202 |
| src\core\tools\browserActionTool.ts | if | 39 | 144 | 38 | 0.264 |
| src\services\code-index\embedders\ollama.ts | validateConfiguration | 144 | 139 | 38 | 0.273 |
| src\api\providers\openai-native.ts | normalizeUsage | 68 | 60 | 37 | 0.617 |
| src\core\diff\strategies\multi-file-search-replace.ts | validateMarkerSequencing | 245 | 144 | 37 | 0.257 |
| src\core\diff\strategies\multi-search-replace.ts | validateMarkerSequencing | 193 | 143 | 37 | 0.259 |
| src\services\code-index\config-manager.ts | loadConfiguration | 137 | 65 | 37 | 0.569 |
| apps\web-roo-code\src\components\enterprise\contact-form.tsx | ContactForm | 34 | 258 | 36 | 0.14 |
| src\core\tools\readFileTool.ts | for | 446 | 176 | 36 | 0.205 |
| src\services\mcp\McpHub.ts | if | 661 | 148 | 36 | 0.243 |
| webview-ui\src\components\settings\SettingsView.tsx | if | 298 | 76 | 35 | 0.461 |
| src\api\providers\native-ollama.ts | convertToOllamaMessages | 11 | 118 | 34 | 0.288 |
| src\services\code-index\processors\parser.ts | parseContent | 95 | 136 | 34 | 0.25 |
| src\api\providers\anthropic.ts | switch | 53 | 89 | 33 | 0.371 |
| src\core\mentions\index.ts | for | 153 | 84 | 33 | 0.393 |
| src\api\providers\claude-code.ts | createMessage | 25 | 151 | 32 | 0.212 |
| src\api\transform\openai-format.ts | for | 9 | 135 | 32 | 0.237 |
| src\api\transform\vscode-lm-format.ts | for | 36 | 108 | 32 | 0.296 |
| webview-ui\src\components\common\CodeAccordian.tsx | File_Level | 1 | 96 | 32 | 0.333 |
| webview-ui\src\components\marketplace\MarketplaceListView.tsx | MarketplaceListView | 22 | 273 | 32 | 0.117 |
| apps\web-roo-code\src\components\homepage\animated-background.tsx | AnimatedBackground | 5 | 276 | 31 | 0.112 |
| src\services\code-index\config-manager.ts | isConfigured | 206 | 34 | 31 | 0.912 |
| src\services\code-index\service-factory.ts | createEmbedder | 35 | 53 | 31 | 0.585 |
| webview-ui\src\context\ExtensionStateContext.tsx | switch | 296 | 85 | 31 | 0.365 |
| apps\web-evals\src\app\runs\new\new-run.tsx | NewRun | 58 | 320 | 30 | 0.094 |
| src\api\providers\fetchers\litellm.ts | getLiteLLMModels | 16 | 84 | 30 | 0.357 |
| src\core\assistant-message\AssistantMessageParser.ts | processChunk | 54 | 181 | 30 | 0.166 |
| webview-ui\src\components\chat\TodoListDisplay.tsx | TodoListDisplay | 3 | 352 | 30 | 0.085 |
| src\api\providers\openai-native.ts | completePrompt | 1271 | 84 | 29 | 0.345 |
| src\core\tools\multiApplyDiffTool.ts | if | 276 | 120 | 29 | 0.242 |
| src\services\code-index\orchestrator.ts | startIndexing | 97 | 140 | 29 | 0.207 |
| src\shared\ProfileValidator.ts | getModelIdFromProfile | 56 | 45 | 29 | 0.644 |
| webview-ui\src\components\mcp\McpToolRow.tsx | File_Level | 1 | 143 | 29 | 0.203 |
| src\api\transform\cache-strategy\multi-point-strategy.ts | if | 106 | 136 | 28 | 0.206 |
| src\core\assistant-message\parseAssistantMessage.ts | parseAssistantMessage | 7 | 160 | 28 | 0.175 |
| src\core\config\CustomModesManager.ts | exportModeWithRules | 714 | 123 | 28 | 0.228 |
| src\services\code-index\processors\file-watcher.ts | for | 268 | 77 | 28 | 0.364 |
| src\shared\mcp.ts | File_Level | 1 | 83 | 28 | 0.337 |
| webview-ui\src\components\marketplace\MarketplaceViewStateManager.ts | handleMessage | 348 | 138 | 28 | 0.203 |
| src\api\providers\fetchers\unbound.ts | if | 17 | 30 | 27 | 0.9 |
| src\api\providers\openai-native.ts | if | 480 | 102 | 27 | 0.265 |
| src\core\task\Task.ts | getSystemPrompt | 2342 | 79 | 27 | 0.342 |
| webview-ui\src\components\chat\ChatRow.tsx | switch | 212 | 113 | 26 | 0.23 |
| webview-ui\src\components\chat\ChatTextArea.tsx | if | 340 | 40 | 26 | 0.65 |
| src\core\tools\readFileTool.ts | if | 128 | 56 | 25 | 0.446 |
| webview-ui\src\components\marketplace\MarketplaceView.tsx | MarketplaceView | 18 | 148 | 25 | 0.169 |
| src\core\webview\ClineProvider.ts | resolveWebviewView | 688 | 128 | 24 | 0.188 |
| src\integrations\misc\image-handler.ts | openImage | 7 | 85 | 24 | 0.282 |
| src\integrations\misc\read-lines.ts | readLines | 24 | 93 | 24 | 0.258 |
| src\integrations\terminal\TerminalProcess.ts | run | 47 | 212 | 24 | 0.113 |
| src\services\code-index\embedders\__tests__\openai-compatible.spec.ts | File_Level | 1 | 1054 | 24 | 0.023 |
| src\services\code-index\interfaces\config.ts | File_Level | 1 | 42 | 24 | 0.571 |
| src\shared\modes.ts | for | 201 | 66 | 24 | 0.364 |
| webview-ui\src\components\chat\ChatTextArea.tsx | if | 124 | 69 | 24 | 0.348 |
| webview-ui\src\components\chat\ChatView.tsx | if | 585 | 56 | 24 | 0.429 |
| webview-ui\src\components\history\useTaskSearch.ts | switch | 62 | 16 | 24 | 1.5 |
| src\api\providers\anthropic.ts | await | 148 | 76 | 23 | 0.303 |
| src\api\providers\bedrock.ts | completePrompt | 636 | 83 | 23 | 0.277 |
| src\integrations\misc\extract-text.ts | applyRunLengthEncoding | 277 | 53 | 23 | 0.434 |
| src\services\code-index\embedders\ollama.ts | createEmbeddings | 38 | 101 | 23 | 0.228 |
| webview-ui\src\components\chat\ChatView.tsx | if | 1129 | 50 | 23 | 0.46 |
| webview-ui\src\components\marketplace\MarketplaceViewStateManager.ts | filterItems | 306 | 41 | 23 | 0.561 |
| src\api\transform\mistral-format.ts | convertToMistralMessages | 13 | 80 | 22 | 0.275 |
| src\integrations\terminal\ExecaTerminalProcess.ts | run | 35 | 117 | 22 | 0.188 |
| src\integrations\terminal\TerminalRegistry.ts | initialize | 26 | 103 | 22 | 0.214 |
| src\services\tree-sitter\index.ts | processCaptures | 268 | 101 | 22 | 0.218 |
| webview-ui\src\components\chat\CodeIndexPopover.tsx | if | 310 | 49 | 22 | 0.449 |
| webview-ui\src\components\chat\ContextMenu.tsx | switch | 72 | 136 | 22 | 0.162 |
| src\api\providers\bedrock.ts | constructor | 172 | 82 | 21 | 0.256 |
| src\api\providers\mistral.ts | await | 59 | 35 | 21 | 0.6 |
| src\api\providers\qwen-code.ts | createMessage | 204 | 82 | 21 | 0.256 |
| src\api\transform\r1-format.ts | convertToR1Format | 18 | 81 | 21 | 0.259 |
| src\core\config\CustomModesManager.ts | checkRulesDirectoryHasContent | 620 | 87 | 21 | 0.241 |
| src\core\config\ProviderSettingsManager.ts | if | 623 | 97 | 21 | 0.216 |
| src\core\context\context-management\context-error-handling.ts | checkIsOpenRouterContextWindowError | 12 | 24 | 21 | 0.875 |
| src\core\tools\executeCommandTool.ts | if | 35 | 95 | 21 | 0.221 |
| src\services\code-index\processors\scanner.ts | while | 363 | 96 | 21 | 0.219 |
| src\services\glob\list-files.ts | scanDirectory | 411 | 90 | 21 | 0.233 |
| src\shared\tools.ts | File_Level | 1 | 299 | 21 | 0.07 |
| src\utils\safeWriteJson.ts | safeWriteJson | 21 | 159 | 21 | 0.132 |
| webview-ui\src\components\chat\ChatView.tsx | switch | 908 | 20 | 21 | 1.05 |
| webview-ui\src\components\modes\ModesView.tsx | if | 446 | 40 | 21 | 0.525 |
| webview-ui\src\utils\validate.ts | validateModelId | 259 | 54 | 21 | 0.389 |
| apps\web-roo-code\src\app\evals\plot.tsx | for | 79 | 36 | 20 | 0.556 |
| src\api\providers\bedrock.ts | getModel | 936 | 73 | 20 | 0.274 |
| src\core\tools\multiApplyDiffTool.ts | if | 108 | 92 | 20 | 0.217 |
| src\services\code-index\processors\parser.ts | for | 301 | 70 | 20 | 0.286 |
| src\services\code-index\vector-store\qdrant-client.ts | initialize | 149 | 67 | 20 | 0.299 |
| webview-ui\src\components\chat\hooks\usePromptHistory.ts | if | 135 | 33 | 20 | 0.606 |
| webview-ui\src\components\ui\hooks\useOpenRouterModelProviders.ts | getOpenRouterProvidersForModel | 46 | 51 | 20 | 0.392 |
| src\api\providers\anthropic-vertex.ts | await | 101 | 62 | 19 | 0.306 |
| src\api\providers\cerebras.ts | completePrompt | 280 | 49 | 19 | 0.388 |
| src\api\providers\vscode-lm.ts | internalCountTokens | 204 | 67 | 19 | 0.284 |
| src\api\transform\cache-strategy\base-strategy.ts | estimateTokenCount | 100 | 44 | 19 | 0.432 |
| src\core\config\ProviderSettingsManager.ts | initialize | 87 | 82 | 19 | 0.232 |
| src\core\prompts\tools\read-file.ts | getReadFileDescription | 3 | 83 | 19 | 0.229 |
| src\core\task\Task.ts | dispose | 1506 | 83 | 19 | 0.229 |
| src\core\tools\executeCommandTool.ts | if | 310 | 54 | 19 | 0.352 |
| src\core\tools\switchModeTool.ts | if | 20 | 57 | 19 | 0.333 |
| src\extension\api.ts | outputChannelLog | 305 | 30 | 19 | 0.633 |
| src\integrations\editor\DiffViewProvider.ts | update | 113 | 76 | 19 | 0.25 |
| src\services\code-index\vector-store\qdrant-client.ts | deletePointsByMultipleFilePaths | 447 | 63 | 19 | 0.302 |
| src\services\mcp\McpHub.ts | fetchToolsList | 905 | 56 | 19 | 0.339 |
| src\utils\outputChannelLogger.ts | createOutputChannelLogger | 9 | 32 | 19 | 0.594 |
| webview-ui\src\components\common\MermaidButton.tsx | MermaidButton | 23 | 224 | 19 | 0.085 |
| webview-ui\src\components\settings\ApiOptions.tsx | if | 210 | 24 | 19 | 0.792 |
| src\api\providers\cerebras.ts | if | 159 | 26 | 18 | 0.692 |
| src\api\transform\gemini-format.ts | convertAnthropicContentToGemini | 4 | 68 | 18 | 0.265 |
| src\core\task\Task.ts | if | 1062 | 102 | 18 | 0.176 |
| src\core\tools\accessMcpResourceTool.ts | if | 18 | 71 | 18 | 0.254 |
| src\core\tools\newTaskTool.ts | if | 26 | 113 | 18 | 0.159 |
| src\services\code-index\embedders\__tests__\openai.spec.ts | File_Level | 1 | 541 | 18 | 0.033 |
| src\services\code-index\processors\file-watcher.ts | if | 359 | 58 | 18 | 0.31 |
| src\services\code-index\shared\validation-helpers.ts | sanitizeErrorMessage | 9 | 36 | 18 | 0.5 |
| src\services\ripgrep\index.ts | if | 167 | 44 | 18 | 0.409 |
| webview-ui\src\components\chat\ChatView.tsx | if | 1264 | 45 | 18 | 0.4 |
| webview-ui\src\utils\sourceMapInitializer.ts | initializeSourceMaps | 16 | 95 | 18 | 0.189 |
| scripts\find-missing-translations.js | checkAreaTranslations | 109 | 103 | 17 | 0.165 |
| src\api\providers\bedrock.ts | parseArn | 804 | 73 | 17 | 0.233 |
| src\api\providers\cerebras.ts | while | 207 | 41 | 17 | 0.415 |
| src\api\providers\lite-llm.ts | if | 48 | 58 | 17 | 0.293 |
| src\api\providers\openai-native.ts | formatFullConversation | 377 | 46 | 17 | 0.37 |
| src\core\tools\askFollowupQuestionTool.ts | if | 18 | 67 | 17 | 0.254 |
| src\core\tools\attemptCompletionTool.ts | if | 58 | 79 | 17 | 0.215 |
| src\core\tools\readFileTool.ts | getReadFileToolDescription | 26 | 31 | 17 | 0.548 |
| src\core\tools\simpleReadFileTool.ts | if | 130 | 71 | 17 | 0.239 |
| src\integrations\misc\export-markdown.ts | formatContentBlockToMarkdown | 44 | 35 | 17 | 0.486 |
| src\integrations\misc\extract-text-from-xlsx.ts | formatCellValue | 5 | 37 | 17 | 0.459 |
| src\services\mcp\McpHub.ts | notifyWebviewOfServerChanges | 1281 | 63 | 17 | 0.27 |
| src\services\tree-sitter\__tests__\fixtures\sample-ruby.ts | File_Level | 1 | 577 | 17 | 0.029 |
| webview-ui\src\components\chat\ChatTextArea.tsx | if | 387 | 68 | 17 | 0.25 |
| apps\web-evals\src\components\home\run.tsx | Run | 33 | 117 | 16 | 0.137 |
| src\api\providers\bedrock.ts | formatErrorMessage | 1294 | 30 | 16 | 0.533 |
| src\api\providers\fetchers\huggingface.ts | getHuggingFaceModels | 125 | 84 | 16 | 0.19 |
| src\api\providers\fetchers\io-intelligence.ts | getIOIntelligenceModels | 101 | 75 | 16 | 0.213 |
| src\api\providers\openai.ts | constructor | 37 | 45 | 16 | 0.356 |
| src\api\providers\xai.ts | await | 71 | 39 | 16 | 0.41 |
| src\core\context\context-management\context-error-handling.ts | checkIsCerebrasContextWindowError | 98 | 17 | 16 | 0.941 |
| src\core\mentions\index.ts | for | 292 | 43 | 16 | 0.372 |
| src\core\task\Task.ts | if | 805 | 48 | 16 | 0.333 |
| src\core\task\Task.ts | persistGpt5Metadata | 2830 | 30 | 16 | 0.533 |
| src\core\tools\generateImageTool.ts | if | 163 | 92 | 16 | 0.174 |
| src\integrations\misc\extract-text.ts | while | 452 | 38 | 16 | 0.421 |
| src\integrations\terminal\ExecaTerminalProcess.ts | abort | 159 | 60 | 16 | 0.267 |
| src\integrations\theme\getTheme.ts | getTheme | 35 | 57 | 16 | 0.281 |
| src\services\browser\BrowserSession.ts | connectToRemoteBrowser | 107 | 57 | 16 | 0.281 |
| src\services\code-index\state-manager.ts | reportFileQueueProgress | 81 | 30 | 16 | 0.533 |
| src\services\mcp\McpHub.ts | deleteServer | 1491 | 67 | 16 | 0.239 |
| src\services\tree-sitter\markdownParser.ts | parseMarkdown | 38 | 147 | 16 | 0.109 |
| src\utils\git.ts | getGitRepositoryInfo | 30 | 61 | 16 | 0.262 |
| webview-ui\src\components\chat\ChatTextArea.tsx | if | 471 | 43 | 16 | 0.372 |
| webview-ui\src\components\chat\ChatView.tsx | switch | 672 | 32 | 16 | 0.5 |
| webview-ui\src\utils\command-parser.ts | extractPatternsFromCommand | 8 | 35 | 16 | 0.457 |
| webview-ui\src\utils\path-mentions.ts | convertToMentionPath | 25 | 56 | 16 | 0.286 |
| webview-ui\src\utils\validate.ts | getModelIdForProvider | 191 | 33 | 16 | 0.485 |
| apps\web-evals\src\app\runs\[id]\run.tsx | Run | 17 | 96 | 15 | 0.156 |
| src\api\providers\deepinfra.ts | processUsageMetrics | 128 | 19 | 15 | 0.789 |
| src\api\providers\gemini.ts | await | 98 | 35 | 15 | 0.429 |
| src\api\providers\gemini.ts | completePrompt | 212 | 44 | 15 | 0.341 |
| src\api\providers\openrouter.ts | await | 175 | 22 | 15 | 0.682 |
| src\core\checkpoints\index.ts | checkpointDiff | 279 | 49 | 15 | 0.306 |
| src\core\mentions\index.ts | openMention | 51 | 22 | 15 | 0.682 |
| src\core\tools\listCodeDefinitionNamesTool.ts | if | 33 | 45 | 15 | 0.333 |
| src\core\webview\ClineProvider.ts | createTaskWithHistoryItem | 817 | 124 | 15 | 0.121 |
| src\core\webview\ClineProvider.ts | remoteControlEnabled | 2237 | 44 | 15 | 0.341 |
| src\integrations\misc\__tests__\performance\processCarriageReturns.benchmark.ts | generateTestData | 25 | 71 | 15 | 0.211 |
| src\integrations\theme\getTheme.ts | for | 103 | 32 | 15 | 0.469 |
| src\services\code-index\embedders\openai-compatible.ts | for | 254 | 92 | 15 | 0.163 |
| src\services\code-index\interfaces\file-processor.ts | File_Level | 1 | 116 | 15 | 0.129 |
| src\services\code-index\orchestrator.ts | _startWatcher | 32 | 57 | 15 | 0.263 |
| src\services\marketplace\MarketplaceManager.ts | getMarketplaceItems | 37 | 54 | 15 | 0.278 |
| src\services\marketplace\MarketplaceManager.ts | checkProjectInstallations | 247 | 44 | 15 | 0.341 |
| src\shared\modes.ts | getModeSelection | 130 | 22 | 15 | 0.682 |
| webview-ui\src\components\common\MermaidBlock.tsx | MermaidBlock | 90 | 135 | 15 | 0.111 |
| webview-ui\src\components\marketplace\MarketplaceViewStateManager.ts | transition | 163 | 133 | 15 | 0.113 |
| webview-ui\src\components\settings\NotificationSettings.tsx | File_Level | 1 | 106 | 15 | 0.142 |
| apps\web-roo-code\src\components\homepage\code-example.tsx | CodeExample | 6 | 96 | 14 | 0.146 |
| apps\web-roo-code\src\components\ui\chart.tsx | getPayloadConfigFromPayload | 286 | 24 | 14 | 0.583 |
| src\api\providers\lite-llm.ts | if | 142 | 29 | 14 | 0.483 |
| src\api\providers\openai-native.ts | applyServiceTierPricing | 1203 | 15 | 14 | 0.933 |
| src\api\providers\vscode-lm.ts | await | 379 | 63 | 14 | 0.222 |
| src\api\transform\model-params.ts | if | 138 | 40 | 14 | 0.35 |
| src\api\transform\vscode-lm-format.ts | extractTextCountFromMessage | 164 | 32 | 14 | 0.438 |
| src\core\context\context-management\context-error-handling.ts | checkIsAnthropicContextWindowError | 58 | 39 | 14 | 0.359 |
| src\core\webview\ClineProvider.ts | handleModeSwitch | 1133 | 64 | 14 | 0.219 |
| src\integrations\misc\extract-text.ts | extractTextFromFile | 64 | 47 | 14 | 0.298 |
| src\integrations\misc\extract-text.ts | truncateOutput | 207 | 62 | 14 | 0.226 |
| src\services\checkpoints\ShadowCheckpointService.ts | getDiff | 280 | 33 | 14 | 0.424 |
| src\services\code-index\embedders\openai-compatible.ts | if | 214 | 17 | 14 | 0.824 |
| src\services\code-index\processors\scanner.ts | if | 299 | 38 | 14 | 0.368 |
| src\services\code-index\shared\validation-helpers.ts | extractStatusCode | 91 | 22 | 14 | 0.636 |
| src\services\glob\list-files.ts | execRipgrep | 649 | 79 | 14 | 0.177 |
| src\shared\cost.ts | File_Level | 1 | 57 | 14 | 0.246 |
| src\utils\git.ts | extractRepositoryName | 164 | 24 | 14 | 0.583 |
| src\utils\shell.ts | getWindowsShellFromVSCode | 188 | 38 | 14 | 0.368 |
| src\utils\tiktoken.ts | tiktoken | 9 | 38 | 14 | 0.368 |
| webview-ui\src\components\chat\ChatView.tsx | switch | 725 | 30 | 14 | 0.467 |
| webview-ui\src\components\chat\CodeIndexPopover.tsx | if | 212 | 27 | 14 | 0.519 |
| webview-ui\src\components\settings\providers\Mistral.tsx | File_Level | 1 | 69 | 14 | 0.203 |
| webview-ui\src\components\settings\providers\Vertex.tsx | File_Level | 1 | 122 | 14 | 0.115 |
| scripts\find-missing-i18n-key.js | findMissingI18nKeys | 114 | 48 | 13 | 0.271 |
| scripts\update-contributors.js | parseLinkHeader | 46 | 40 | 13 | 0.325 |
| src\api\providers\openai.ts | getOpenAiModels | 446 | 34 | 13 | 0.382 |
| src\api\providers\openrouter.ts | completePrompt | 248 | 36 | 13 | 0.361 |
| src\api\providers\requesty.ts | processUsageMetrics | 82 | 19 | 13 | 0.684 |
| src\core\diff\strategies\multi-file-search-replace.ts | getProgressStatus | 713 | 25 | 13 | 0.52 |
| src\core\diff\strategies\multi-search-replace.ts | getProgressStatus | 615 | 23 | 13 | 0.565 |
| src\core\mentions\processUserContentMentions.ts | if | 48 | 68 | 13 | 0.191 |
| src\core\task\Task.ts | if | 724 | 73 | 13 | 0.178 |
| src\core\task\Task.ts | condenseContext | 971 | 73 | 13 | 0.178 |
| src\core\webview\ClineProvider.ts | getRecentTasks | 2349 | 44 | 13 | 0.295 |
| src\core\webview\webviewMessageHandler.ts | if | 174 | 54 | 13 | 0.241 |
| src\integrations\terminal\__tests__\TerminalProcessExec.bash.spec.ts | createRealCommandStream | 60 | 71 | 13 | 0.183 |
| src\integrations\terminal\TerminalProcess.ts | getUnretrievedOutput | 279 | 45 | 13 | 0.289 |
| src\services\code-index\embedders\openai-compatible.ts | createEmbeddings | 85 | 77 | 13 | 0.169 |
| src\services\code-index\embedders\openai.ts | createEmbeddings | 41 | 77 | 13 | 0.169 |
| src\services\code-index\manager.ts | initialize | 118 | 49 | 13 | 0.265 |
| src\services\code-index\processors\file-watcher.ts | if | 210 | 39 | 13 | 0.333 |
| src\services\code-index\processors\scanner.ts | if | 162 | 74 | 13 | 0.176 |
| src\services\code-index\state-manager.ts | setSystemState | 33 | 24 | 13 | 0.542 |
| src\services\marketplace\MarketplaceManager.ts | checkGlobalInstallations | 295 | 41 | 13 | 0.317 |
| src\services\tree-sitter\queries\elixir.ts | File_Level | 1 | 70 | 13 | 0.186 |
| src\utils\storage.ts | promptForCustomStoragePath | 84 | 68 | 13 | 0.191 |
| webview-ui\src\components\chat\ChatView.tsx | if | 1207 | 29 | 13 | 0.448 |
| webview-ui\src\utils\sourceMapInitializer.ts | exposeSourceMapsForDebugging | 115 | 66 | 13 | 0.197 |
| webview-ui\src\vite-plugins\sourcemapPlugin.ts | sourcemapPlugin | 9 | 108 | 13 | 0.12 |
| scripts\find-missing-translations.js | Anonymous_Function_Line_19 | 19 | 17 | 12 | 0.706 |
| src\api\providers\bedrock.ts | getModelById | 898 | 37 | 12 | 0.324 |
| src\api\providers\chutes.ts | createMessage | 47 | 44 | 12 | 0.273 |
| src\api\providers\featherless.ts | createMessage | 47 | 44 | 12 | 0.273 |
| src\api\providers\fetchers\huggingface.ts | parseHuggingFaceModel | 95 | 23 | 12 | 0.522 |
| src\api\providers\fetchers\modelCache.ts | switch | 58 | 40 | 12 | 0.3 |
| src\api\providers\openai-native.ts | formatSingleStructuredMessage | 424 | 33 | 12 | 0.364 |
| src\api\providers\openai.ts | if | 317 | 69 | 12 | 0.174 |
| src\api\providers\vercel-ai-gateway.ts | await | 67 | 21 | 12 | 0.571 |
| src\core\prompts\sections\capabilities.ts | File_Level | 1 | 42 | 12 | 0.286 |
| src\core\tools\readFileTool.ts | if | 667 | 27 | 12 | 0.444 |
| src\core\tools\updateTodoListTool.ts | validateTodos | 133 | 12 | 12 | 1.0 |
| src\integrations\editor\DiffViewProvider.ts | if | 231 | 34 | 12 | 0.353 |
| src\integrations\editor\DiffViewProvider.ts | if | 684 | 29 | 12 | 0.414 |
| src\services\browser\__tests__\UrlContentFetcher.spec.ts | if | 69 | 9 | 12 | 1.333 |
| src\services\code-index\embedders\__tests__\openai-compatible-rate-limit.spec.ts | File_Level | 1 | 214 | 12 | 0.056 |
| src\services\code-index\embedders\openai.ts | for | 129 | 47 | 12 | 0.255 |
| src\services\code-index\service-factory.ts | createVectorStore | 116 | 35 | 12 | 0.343 |
| src\services\command\commands.ts | for | 152 | 48 | 12 | 0.25 |
| src\services\mcp\McpHub.ts | initializeMcpServers | 505 | 42 | 12 | 0.286 |
| src\services\mcp\McpHub.ts | refreshAllConnections | 1211 | 69 | 12 | 0.174 |
| src\services\mcp\McpHub.ts | if | 1362 | 30 | 12 | 0.4 |
| src\services\tree-sitter\queries\typescript.ts | File_Level | 1 | 123 | 12 | 0.098 |
| src\shared\modes.ts | getAllModesWithPrompts | 287 | 13 | 12 | 0.923 |
| src\utils\shell.ts | getShell | 334 | 37 | 12 | 0.324 |
| webview-ui\src\components\chat\AutoApproveMenu.tsx | switch | 56 | 32 | 12 | 0.375 |
| webview-ui\src\components\chat\BrowserSessionRow.tsx | switch | 439 | 61 | 12 | 0.197 |
| webview-ui\src\components\chat\ChatView.tsx | if | 1012 | 13 | 12 | 0.923 |
| webview-ui\src\components\chat\ChatView.tsx | if | 1614 | 39 | 12 | 0.308 |
| webview-ui\src\components\chat\CodeIndexPopover.tsx | if | 268 | 33 | 12 | 0.364 |
| webview-ui\src\components\chat\ContextMenu.tsx | switch | 211 | 24 | 12 | 0.5 |
| webview-ui\src\components\chat\McpExecution.tsx | if | 130 | 22 | 12 | 0.545 |
| webview-ui\src\components\settings\ImageGenerationSettings.tsx | File_Level | 1 | 129 | 12 | 0.093 |
| webview-ui\src\components\ui\standard-tooltip.tsx | File_Level | 1 | 70 | 12 | 0.171 |
| webview-ui\src\utils\sourceMapUtils.ts | applySourceMapsToComponentStack | 59 | 56 | 12 | 0.214 |
| apps\web-evals\src\actions\runs.ts | createRun | 25 | 71 | 11 | 0.155 |
| scripts\install-vsix.js | main | 25 | 65 | 11 | 0.169 |
| src\api\providers\bedrock.ts | getErrorType | 1247 | 43 | 11 | 0.256 |
| src\api\providers\fetchers\glama.ts | for | 14 | 24 | 11 | 0.458 |
| src\core\config\CustomModesManager.ts | deleteCustomMode | 509 | 44 | 11 | 0.25 |
| src\core\config\CustomModesManager.ts | deleteRulesFolder | 559 | 42 | 11 | 0.262 |
| src\core\context-tracking\FileContextTracker.ts | addFileToFileContextTracker | 143 | 58 | 11 | 0.19 |
| src\core\tools\executeCommandTool.ts | catch | 210 | 55 | 11 | 0.2 |
| src\core\tools\readFileTool.ts | for | 213 | 53 | 11 | 0.208 |
| src\core\tools\runSlashCommandTool.ts | if | 33 | 71 | 11 | 0.155 |
| src\core\tools\updateTodoListTool.ts | parseMarkdownChecklist | 103 | 25 | 11 | 0.44 |
| src\core\webview\ClineProvider.ts | dispose | 541 | 48 | 11 | 0.229 |
| src\core\webview\ClineProvider.ts | handleOpenRouterCallback | 1360 | 33 | 11 | 0.333 |
| src\core\webview\ClineProvider.ts | deleteTaskWithId | 1513 | 46 | 11 | 0.239 |
| src\integrations\editor\DiffViewProvider.ts | open | 48 | 64 | 11 | 0.172 |
| src\services\browser\BrowserSession.ts | navigateToUrl | 352 | 70 | 11 | 0.157 |
| src\services\browser\UrlContentFetcher.ts | urlToMarkdown | 88 | 55 | 11 | 0.2 |
| src\services\code-index\manager.ts | handleSettingsChange | 380 | 42 | 11 | 0.262 |
| src\services\tree-sitter\queries\css.ts | File_Level | 1 | 71 | 11 | 0.155 |
| src\services\tree-sitter\queries\elisp.ts | File_Level | 1 | 40 | 11 | 0.275 |
| src\shared\todo.ts | getLatestTodo | 2 | 22 | 11 | 0.5 |
| src\utils\git.ts | convertGitUrlToHttps | 97 | 32 | 11 | 0.344 |
| src\utils\logging\types.ts | File_Level | 1 | 117 | 11 | 0.094 |
| webview-ui\src\components\chat\BrowserSessionRow.tsx | if | 79 | 33 | 11 | 0.333 |
| webview-ui\src\components\chat\ChatTextArea.tsx | if | 818 | 43 | 11 | 0.256 |
| webview-ui\src\components\chat\ContextCondenseRow.tsx | File_Level | 1 | 81 | 11 | 0.136 |
| webview-ui\src\components\marketplace\useStateManager.ts | useStateManager | 4 | 47 | 11 | 0.234 |
| webview-ui\src\components\settings\providers\Glama.tsx | File_Level | 1 | 76 | 11 | 0.145 |
| webview-ui\src\components\settings\providers\VercelAiGateway.tsx | File_Level | 1 | 76 | 11 | 0.145 |
| webview-ui\src\components\ui\__tests__\select-dropdown.spec.tsx | File_Level | 1 | 273 | 11 | 0.04 |

## Recommendations

Based on the cyclomatic complexity analysis:

1. **Refactor High-Complexity Functions**: Functions with CC > 10 should be refactored into smaller, more focused units.
   - Consider extracting complex conditions into separate functions
   - Break large functions into smaller, more manageable pieces
   - Simplify nested conditionals with early returns or guard clauses

2. **Increase Test Coverage**: Functions with high complexity need more thorough testing.
   - Each decision point (if, loop, etc.) represents a path that should be tested
   - High-complexity functions may need specific focus in your test suite

3. **Code Review Focus**: Direct extra attention to high-complexity areas during code reviews.

4. **Documentation**: Ensure complex logic is well-documented to aid understanding.

## Complexity Risk Categories

| Complexity | Risk | Recommendation |
|------------|------|---------------|
| 1-5 | Low | Simple, well-structured code. Generally easy to maintain. |
| 6-10 | Moderate | Reasonably complex. May need minor refactoring. |
| 11-20 | High | Complex code. Should be refactored and well-tested. |
| 21-50 | Very High | Excessively complex. High priority for refactoring. |
| 50+ | Extremely High | Unmaintainable code. Critical priority for refactoring. |

## Notes on Accuracy

This analysis provides approximate cyclomatic complexity. For more accurate results, consider using language-specific static analysis tools.

---
*Generated by OLAF Complexity Analyzer*
