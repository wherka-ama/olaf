---
name: autonomous-comprehensive-research
description: Conduct autonomous, comprehensive, iterative research with minimal user input and maximum technical depth
tags: [research, autonomous, comprehensive, iterative, technical, analysis]
---

## Purpose
Perform comprehensive, autonomous research on any technical topic with minimal user guidance. The prompt automatically deepens research iteratively, identifies knowledge gaps, explores technical specifications, and produces complete technical reports without requiring detailed user direction.

## Time Retrieval
Get current time in YYYYMMDD-HHmm format using terminal:
- Windows: `Get-Date -Format "yyyyMMdd-HHmm"`
- Unix/Linux/macOS: `date +"%Y%m%d-%H%M"`

Use terminal commands, not training data.

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **research_topic**: string - Primary topic or technology to research (REQUIRED)
- **research_focus**: string - Optional specific angle or aspect to emphasize (default: "comprehensive technical analysis")
- **target_audience**: string - Optional intended audience (default: "technical team")
- **max_iterations**: integer - Maximum research deepening cycles (default: 3)

## Protocol
Sequential autonomous research with iterative depth expansion and gap analysis.

## Process

### Phase 1: Autonomous Research Planning
1. **Topic Analysis**: Automatically analyze research topic to identify:
   - Core concepts and components
   - Technical specifications and standards
   - Key stakeholders and implementations
   - Related technologies and frameworks
   
2. **Research Strategy Generation**: Create comprehensive research plan including:
   - Primary research questions (automatically generated)
   - Technical depth areas to explore
   - Source diversification strategy (official docs, technical specs, implementations, analysis)
   - Knowledge gap identification methodology

3. **Scope Auto-Definition**: Automatically determine:
   - What is included in comprehensive coverage
   - Technical boundaries and related systems
   - Implementation considerations and patterns
   - Strategic implications and recommendations

### Phase 2: Iterative Research Execution
For each iteration cycle (up to max_iterations):

4. **Deep Technical Research**: Conduct systematic research across:
   - Official documentation and specifications
   - Technical architecture and implementation details
   - Code repositories and reference implementations
   - Industry analysis and expert perspectives
   - Performance characteristics and optimization patterns

5. **Knowledge Gap Analysis**: After each research cycle:
   - Identify areas requiring deeper investigation
   - Detect missing technical specifications
   - Find implementation details not yet covered
   - Recognize strategic considerations not explored

6. **Iterative Depth Expansion**: If gaps identified:
   - Automatically conduct additional targeted research
   - Explore deeper technical implementations
   - Investigate related frameworks and integrations
   - Analyze performance and scaling considerations

7. **Progressive Report Building**: Continuously build comprehensive report with:
   - Executive summary with key findings
   - Technical architecture deep dive
   - Implementation specifications and patterns
   - Strategic implications and recommendations
   - Integration considerations and next steps

### Phase 3: Comprehensive Report Finalization
8. **Content Synthesis**: Combine all research findings into cohesive analysis
9. **Technical Validation**: Ensure all technical details are accurate and complete
10. **Strategic Analysis**: Provide actionable insights and recommendations
11. **Final Report Generation**: Create publication-ready comprehensive report

## Output Format
Autonomous research generates structured deliverables:

### Research Plan (Auto-Generated)
- `[id:findings_dir]research/autonomous-research-plan-YYYYMMDD-SSS.md`
- Comprehensive research strategy with identified focus areas
- Automatically determined scope and technical boundaries

### Iterative Research Notes (Per Iteration)
- `[id:findings_dir]research/research-iteration-N-YYYYMMDD-SSS.md`
- Detailed findings from each research cycle
- Gap analysis and next iteration planning

### Final Comprehensive Report
- `[id:findings_dir]reports/comprehensive-research-report-YYYYMMDD-SSS.md`
- Complete technical analysis with all findings
- Executive summary, technical deep dive, strategic recommendations
- Implementation guidance and integration considerations

## Rules

### Autonomous Operation Rules
1. **Minimal User Input**: Require only research topic; auto-generate all other parameters
2. **Progressive Depth**: Each iteration must explore deeper technical details than previous
3. **Gap-Driven Research**: Automatically identify and research knowledge gaps without user prompting
4. **Source Diversification**: Must research multiple source types per iteration (specs, implementations, analysis)
5. **Technical Completeness**: Continue iterations until comprehensive technical coverage achieved

### Research Quality Standards
1. **Primary Source Priority**: Always prioritize official documentation and specifications
2. **Implementation Evidence**: Include actual code examples and reference implementations
3. **Architecture Analysis**: Provide detailed technical architecture breakdown
4. **Performance Considerations**: Include scaling, optimization, and performance analysis
5. **Strategic Context**: Connect technical details to business and strategic implications

### Iterative Expansion Rules
1. **Automatic Gap Detection**: Use structured analysis to identify missing information
2. **Depth Progression**: Each iteration explores more detailed technical aspects
3. **Related Technology Exploration**: Automatically research connected frameworks and standards
4. **Implementation Pattern Analysis**: Investigate deployment patterns and best practices
5. **Comparative Analysis**: Include comparison with alternative approaches when relevant

### Report Structure Standards
1. **Executive Summary**: High-level findings and strategic recommendations
2. **Technical Deep Dive**: Comprehensive architecture and implementation analysis
3. **Specification Details**: Complete technical specifications and standards
4. **Implementation Patterns**: Deployment strategies and integration approaches
5. **Strategic Implications**: Business impact and decision-making guidance
6. **Next Steps**: Actionable recommendations and implementation roadmap

## Output to USER
- Research plan created: [file path] with N focus areas identified
- Iteration X completed: [key findings summary] - [gap analysis results]
- Comprehensive report generated: [file path] with [number] technical sections
- Research completed with [iteration count] cycles and [total sources] analyzed
