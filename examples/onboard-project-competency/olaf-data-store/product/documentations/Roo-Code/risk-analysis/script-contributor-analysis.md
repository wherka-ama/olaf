# Critical Contributors Analysis

Analysis performed on: 20250910-1423  
Repository: C:\Users\ppaccaud\coderepos\olaf-test-onboarding\Roo-Code  
Period analyzed: 12 months (since 2024-09-15)

## Executive Summary

This analysis identified contributor concentration risks by analyzing:
- **Commit Distribution**: How commits are distributed among contributors
- **Bus Factor**: Minimum contributors needed for 50% of development work
- **File Ownership**: Code ownership patterns and concentration risks
- **Risk Assessment**: Overall project sustainability assessment

## Contributor Statistics

- **Total Commits**: 5,146
- **Human Commits**: 4,536 (88.1%)
- **Automated Commits**: 610 (11.9%)
- **Unique Human Contributors**: 270
- **Bus Factor**: 3

## Top Human Contributors

| Rank | Contributor | Commits | Percentage | Email | Risk Level |
|------|-------------|---------|------------|-------|------------|
| 1 | Matt Rubens | 1792 | 39.5% | mrubens@users.noreply.github.com | CRITICAL |
| 2 | Chris Estreich | 434 | 9.6% | cestreich@gmail.com | LOW |
| 3 | Saoud Rizwan | 426 | 9.4% | 7799382+saoudrizwan@users.noreply.github.com | LOW |
| 4 | cte | 149 | 3.3% | cestreich@gmail.com | LOW |
| 5 | Daniel | 144 | 3.2% | 57051444+daniel-lxs@users.noreply.github.com | LOW |
| 6 | Hannes Rudolph | 117 | 2.6% | 49103247+hannesrudolph@users.noreply.github.com | LOW |
| 7 | R00-B0T | 110 | 2.4% | 110429663+R00-B0T@users.noreply.github.com | LOW |
| 8 | sam hoang | 87 | 1.9% | samhv.ict@gmail.com | LOW |
| 9 | Eric Wheeler | 65 | 1.4% | roo-code@z.ewheeler.org | LOW |
| 10 | KJ7LNW | 54 | 1.2% | 93454819+KJ7LNW@users.noreply.github.com | LOW |
| 11 | aheizi | 47 | 1.0% | aheiz@outlook.com | LOW |
| 12 | Sam Hoang Van | 40 | 0.9% | samhv.ict@gmail.com | LOW |
| 13 | Canyon Robins | 38 | 0.8% | canrobins13@gmail.com | LOW |
| 14 | ColemanRoo | 36 | 0.8% | michael.coleman@roo.vet | LOW |
| 15 | John Richmond | 33 | 0.7% | 5629+jr@users.noreply.github.com | LOW |


## Bus Factor Analysis

**Bus Factor: 3** - Minimum contributors representing 50% of commits

### Critical Contributors (50% of commits)
1. **Matt Rubens**: 1792 commits (39.5%)
2. **Chris Estreich**: 434 commits (9.6%)
3. **Saoud Rizwan**: 426 commits (9.4%)


## Automated Contributors

| Bot/Service | Commits | Purpose |
|-------------|---------|---------|
| github-actions[bot] | 264 | CI/CD |
| renovate[bot] | 150 | Dependencies |
| roomote[bot] | 117 | Automation |
| Daniel Riccio | 51 | Automation |
| Wojciech Kordalski | 13 | Automation |
| Roomote Bot | 7 | Automation |
| Franciszek Piszcz | 2 | Automation |
| Mark Percival | 2 | Automation |
| PaperBoardOfficial | 1 | Automation |
| cursor[bot] | 1 | Automation |


## File Ownership Analysis

Analyzed 50 files for ownership concentration:

### High Ownership Concentration Files
| File | Primary Owner | Ownership % |
|------|---------------|-------------|
| apps/vscode-e2e/src/suite/test-utils.ts | Chris Estreich | 100.0% |
| apps/vscode-e2e/src/suite/tools/execute-command.test.ts | Chris Estreich | 100.0% |
| apps/vscode-e2e/src/suite/tools/insert-content.test.ts | Chris Estreich | 100.0% |
| apps/vscode-e2e/src/suite/tools/read-file.test.ts | Chris Estreich | 100.0% |
| apps/vscode-e2e/src/suite/tools/search-and-replace.test.ts | Chris Estreich | 100.0% |
| apps/vscode-e2e/src/suite/tools/search-files.test.ts | Chris Estreich | 100.0% |
| apps/vscode-e2e/src/suite/tools/write-to-file.test.ts | Chris Estreich | 100.0% |
| apps/vscode-e2e/src/types/global.d.ts | Chris Estreich | 100.0% |
| apps/web-evals/next-env.d.ts | Chris Estreich | 100.0% |
| apps/web-evals/next.config.ts | Chris Estreich | 100.0% |


## Risk Assessment

**Overall Risk Level: MEDIUM**

### Risk Factors
- Bus Factor: 3
- Single-owner files: 10

### Recommendations
1. Regular knowledge sharing sessions
2. Documentation improvement
3. Contributor development program
4. Address single-owner files with high ownership concentration

### Files Requiring Attention
- **apps/vscode-e2e/src/suite/markdown-lists.test.ts**: 97.0% owned by roomote[bot]
- **apps/vscode-e2e/src/suite/modes.test.ts**: 82.8% owned by Chris Estreich
- **apps/vscode-e2e/src/suite/task.test.ts**: 88.9% owned by Chris Estreich
- **apps/vscode-e2e/src/suite/test-utils.ts**: 100.0% owned by Chris Estreich
- **apps/vscode-e2e/src/suite/tools/apply-diff.test.ts**: 99.9% owned by Chris Estreich
- **apps/vscode-e2e/src/suite/tools/execute-command.test.ts**: 100.0% owned by Chris Estreich
- **apps/vscode-e2e/src/suite/tools/insert-content.test.ts**: 100.0% owned by Chris Estreich
- **apps/vscode-e2e/src/suite/tools/read-file.test.ts**: 100.0% owned by Chris Estreich
- **apps/vscode-e2e/src/suite/tools/search-and-replace.test.ts**: 100.0% owned by Chris Estreich
- **apps/vscode-e2e/src/suite/tools/search-files.test.ts**: 100.0% owned by Chris Estreich


## Commit Pattern Analysis

### Activity Patterns for Top Contributors

**Matt Rubens**:
- Total commits: 1792
- First commit: 2024-11-03
- Last commit: 2025-09-10
- Average commits per month: 149.3

**Chris Estreich**:
- Total commits: 434
- First commit: 2025-01-30
- Last commit: 2025-09-06
- Average commits per month: 36.2

**Saoud Rizwan**:
- Total commits: 426
- First commit: 2024-09-15
- Last commit: 2025-02-14
- Average commits per month: 35.5

**cte**:
- Total commits: 149
- First commit: 2025-01-30
- Last commit: 2025-03-17
- Average commits per month: 12.4

**Daniel**:
- Total commits: 205
- First commit: 2025-01-02
- Last commit: 2025-09-09
- Average commits per month: 17.1


## Recommendations for Risk Mitigation

### Immediate Actions (0-30 days)
1. **Knowledge Documentation**: Document critical knowledge from top contributors
2. **Cross-training**: Implement knowledge sharing sessions
3. **Code Review Distribution**: Distribute review responsibilities

### Medium-term Actions (1-3 months)
1. **Mentorship Program**: Pair experienced contributors with newcomers
2. **Documentation Standards**: Establish comprehensive documentation practices
3. **Succession Planning**: Identify and train backup contributors

### Long-term Strategy (3-12 months)
1. **Contributor Development**: Establish contributor growth pipeline
2. **Knowledge Management**: Implement systematic knowledge capture
3. **Risk Monitoring**: Regular bus factor and risk assessments

## Methodology

This analysis uses the following approach:
1. **Commit Analysis**: Examines commit history over 12 months
2. **Bot Detection**: Identifies automated contributors using pattern matching
3. **Bus Factor Calculation**: Determines minimum contributors for 50% of work
4. **File Ownership**: Analyzes code ownership using git blame
5. **Risk Assessment**: Combines metrics to assess overall project risk

---
*Generated by OLAF Contributor Analyzer*
