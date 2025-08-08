# Generic Prompt: Generate Developer-Focused Functional Specification from DFD Analysis

## Objective
Transform any existing DFD analysis into a precise, developer-implementable functional specification. Use the DFD documentation as the primary source, then examine the actual codebase only to replace vague terms with exact values and confirm technical details.

## Primary Input Sources (In Order)
1. **DFD Analysis File** (e.g., `[project_name]_analysis.md`) - Primary source for system understanding
2. **DFD Executive Summary** (if available) - Business context and value proposition
3. **DFD Level 1 and Level 2 task files** (e.g., `DFD_level1_tasks.md`, `DFD_level2_tasks.md`) - Process decomposition details
4. **Actual codebase** - Only for confirming exact values, versions, and patterns

**Note:** Look for files with "analysis" in the name as the primary DFD documentation source.

## DFD Analysis Translation Instructions

### Step 1: Extract Business Requirements from DFD Context
**From Context Diagram:**
- Identify all external entities and their exact roles
- Map each data flow to specific functional requirements
- Define system boundary precisely based on DFD scope

**Required Output Format:**
```
### Business Context (from DFD Analysis)
**System Purpose:** [Extract exact purpose from DFD documentation]
**External Entities:** [List all entities from Context Diagram with roles]
**Primary Data Flows:** [List all flows from Context Diagram]
**System Boundary:** [Define what is inside vs outside the system]
```

### Step 2: Convert Level 1 Processes to Functional Requirements
**From Level 1 DFD:**
- Each process → One functional requirement (FR-N)
- Process inputs → Interface requirements
- Process outputs → Output specifications
- Process purpose → Functional behavior

**Required Mapping:**
```
P[N]: [Process Name] → FR-[N]: [Functional Requirement Name]
```

**Template for each process:**
- Exact inputs (from DFD data flows)
- Exact outputs (from DFD data flows)
- Precise processing rules (from process description)

### Step 3: Use Level 2 DFD for Implementation Details
**From Level 2 Decomposition (if available):**
- Sub-processes → Specific technical requirements
- Internal data flows → Data transformation specifications
- Internal data stores → Storage requirements

**Extract Implementation Specifications:**
- Sub-process names become exact technical functions
- Internal data flows become precise data transformations
- Data store interactions become specific storage requirements

### Step 4: Replace Vague Terms with Codebase Facts
**Only after DFD analysis, examine codebase to replace:**
- "multiple [items]" → Count exact number from actual implementation
- "various [types]" → List exact types from codebase
- "appropriate [values]" → Find actual values in code
- "reasonable [limits]" → Extract actual limits from implementation

## Precision Requirements

### Eliminate Vague Language
**Prohibited Words:** "etc.", "various", "multiple", "some", "many", "appropriate", "suitable", "around", "approximately"

**Replacement Rules:**
- "supports various technologies" → "supports exactly [N] technologies: [complete list]"
- "handles multiple formats" → "processes exactly [N] file formats: [.ext1, .ext2, ...]"
- "reasonable timeout" → "maximum [N] seconds timeout"
- "good performance" → "completes analysis within [N] seconds for repositories up to [size]"

### Exact Specifications Required
- **Version numbers:** From requirements.txt (Flask==2.1.2, not Flask 2.x)
- **File patterns:** From actual extractor code (@EnableOAuth2, not "OAuth patterns")
- **API endpoints:** From flask_code2DFD.py (exact paths and methods)
- **Error codes:** From actual error handling code (specific exit codes)
- **Performance metrics:** From actual implementation (thread counts, memory limits)

## Document Structure Requirements

### 1. Executive Summary (from DFD Analysis)
**Source:** Main DFD Analysis File (`[project_name]_analysis.md`) and Context Diagram section
**Required Content:**
- System purpose (exact text from DFD analysis documentation)
- External entity definitions (all entities from Context Diagram section)
- Primary data flows (mapped from Context Diagram section)
- Business value proposition (from analysis overview or executive summary section)

### 2. Functional Requirements (from Level 1 DFD)
**Source:** Level 1 DFD section in analysis file or separate `DFD_level1_tasks.md`
**Template for each process in Level 1 DFD:**
```
### FR-[N]: [Process Name from Level 1 DFD]
**Source Process:** [Level 1 Process ID and name]
**Requirement:** The system SHALL [exact function from DFD process description]

**Inputs (from DFD):** 
- [List exact data flows entering this process]

**Outputs (from DFD):**
- [List exact data flows leaving this process]

**Implementation Requirements (from codebase confirmation):**
- [Specific libraries/frameworks with exact versions]
- [Exact algorithms/methods from code]
- [Performance constraints from code]

**Level 2 Decomposition (if applicable):**
- [Sub-processes from Level 2 DFD with exact specifications]
```

### 3. Data Store Specifications (from DFD Data Stores)
**For each data store identified in DFD:**
- D[N]: [Data Store Name] → Exact storage requirements and format specifications

### 4. External Interface Specifications (from Context Diagram)
**For each external entity:**
- [External Entity Name] → Interface specifications and interaction protocols

### 5. Non-Functional Requirements (from DFD Analysis)
**Performance, Security, and Quality requirements derived from:**
- Process complexity (from Level 1/Level 2 decomposition)
- Data flow volume (from data flow analysis)
- External dependencies (from Context Diagram)

## Implementation Translation Rules

### Generic DFD Process → Functional Requirement Mapping
**For any Level 1 DFD:**
1. **P[N]: [Process Name]** → **FR-[N]: [Functional Requirement Name]**

**Standard Process Types and Their Mappings:**
- Input/Output Processing → Interface and validation requirements
- Data Transformation → Processing and algorithm requirements
- External Communication → Integration and protocol requirements
- Storage Management → Data persistence and retrieval requirements
- Business Logic → Core functional behavior requirements
- Security/Authentication → Security and access control requirements
- Configuration Management → Parameter and settings requirements

### Data Flow → Interface Specification Mapping
**For any DFD data flows:**
- **Input data flows** → Input validation and format requirements
- **Output data flows** → Output format and delivery requirements
- **Bidirectional flows** → Request-response interface specifications
- **Data store flows** → Data persistence and retrieval specifications

### Codebase Confirmation Requirements (Generic)
**Use code ONLY to replace these common vague terms:**
- "various [items]" → Count/list exact items from implementation
- "multiple [formats]" → List exact formats from code
- "appropriate [timeouts]" → Find actual timeout values
- "reasonable [performance]" → Extract actual performance limits
- "[security] patterns" → List exact patterns from security modules
- "supported [file types]" → Extract file extensions from code
- "[technology] frameworks" → List exact frameworks from dependencies

## Quality Assurance Checklist (Generic)

### DFD Traceability Validation
- [ ] Every Level 1 process mapped to a functional requirement
- [ ] Every data flow mapped to an interface specification
- [ ] Every data store mapped to storage requirements
- [ ] Every external entity mapped to interface requirements
- [ ] All Level 2 sub-processes included in implementation details

### Precision Validation
- [ ] No "etc." or "various" - all lists complete and exact
- [ ] No approximations - all measurements precise
- [ ] No subjective terms - all criteria measurable
- [ ] All version numbers exact (from dependency files)
- [ ] All patterns specific (from actual implementation code)

### Developer Usability Check
- [ ] Requirements implementable without clarification
- [ ] All technical specifications include exact tools/versions
- [ ] Performance requirements measurable and testable
- [ ] Error conditions and responses specified
- [ ] Interface specifications complete with data formats

## Final Output Requirements (Generic)

### Document Structure (Adaptable to Any System)
1. **System Overview** (from Context Diagram analysis)
2. **Functional Requirements FR-1 through FR-N** (from Level 1 processes)
3. **Implementation Details** (from Level 2 decomposition where available)
4. **Interface Specifications** (from external entity interactions)
5. **Data Storage Requirements** (from data store analysis)
6. **Performance Specifications** (from codebase analysis)
7. **Security Requirements** (from security-related processes)

### Universal Precision Standards
- Every requirement traceable to specific DFD element
- Every specification confirmed by actual codebase examination
- Zero ambiguous language regardless of system type
- Complete enumerations (no partial lists)
- Measurable acceptance criteria for all requirements
- Exact technical implementation details

### Application Instructions
1. **Input:** Any DFD analysis (Context + Level 1 + optional Level 2)
2. **Process:** Follow the 4-step translation process
3. **Validate:** Check against quality assurance checklist
4. **Output:** Developer-implementable functional specification

**Universal Principle:** Start with DFD analysis as the foundation, use codebase only to confirm and specify exact values. The result must be implementable by developers without additional requirements gathering, regardless of the system domain.

## Content Analysis Instructions

### Codebase Examination Requirements
1. **Examine actual source code** to identify:
   - All imported libraries and their versions from requirements.txt
   - All file extensions processed in the codebase
   - All configuration parameters and their exact names
   - All error messages and exit codes used
   - All API endpoints and their exact paths

2. **Extract precise patterns** from technology extractors:
   - List every file pattern in every extractor
   - Document every annotation searched for
   - Record every configuration key detected
   - Catalog every supported framework by exact name

3. **Measure actual system behavior:**
   - Identify timeout values in the code
   - Find memory allocation patterns
   - Document thread pool sizes and limits
   - Record file size restrictions

### DFD Analysis Translation
**Convert DFD elements to functional requirements:**
- **External Entities** → Exact input/output interface specifications
- **Processes** → Precise functional requirements with implementation details
- **Data Stores** → Specific storage requirements and file formats
- **Data Flows** → Exact data transformation and validation rules

## Validation Requirements

### Completeness Checks
- [ ] Every technology extractor documented with exact patterns
- [ ] All configuration options specified with exact parameter names
- [ ] Complete API documentation with all endpoints and responses
- [ ] All error conditions documented with specific error codes
- [ ] Performance requirements include exact measurements

### Precision Validation
- [ ] No approximations or ranges (use exact values or specific limits)
- [ ] No subjective language (replace with measurable criteria)
- [ ] No incomplete lists (enumerate all items completely)
- [ ] No vague technical terms (specify exact implementation requirements)

### Developer Usability Check
- [ ] A developer can implement the system without asking clarifying questions
- [ ] All requirements are testable with specific pass/fail criteria
- [ ] Implementation guidance is complete and unambiguous
- [ ] Technical specifications include exact tools and versions

## Output Quality Standards

### Language Requirements
- **Use imperative statements:** "The system SHALL" not "The system should"
- **Specify exact quantities:** "Process exactly 28 technologies" not "Process multiple technologies"
- **Include complete enumerations:** List all supported items explicitly
- **Provide measurable criteria:** "Complete analysis within 300 seconds" not "Complete analysis quickly"

### Technical Accuracy Requirements
- **Version-specific dependencies:** Include exact version numbers from requirements.txt
- **Pattern-specific detection:** Include exact regex patterns and file content searches
- **Path-specific configurations:** Include exact file paths and directory structures
- **Code-specific implementations:** Reference actual classes, methods, and variables from the codebase

### Structure Requirements
- **Logical organization:** Group related requirements together
- **Cross-references:** Link related requirements explicitly
- **Hierarchical numbering:** Use consistent FR-N, NFR-N numbering
- **Complete coverage:** Address all aspects identified in DFD analysis

## Example Precision Transformations

### Vague → Precise Examples
- "Support various file formats" → "Support exactly 8 file formats: .java, .xml, .yml, .yaml, .properties, .json, .gradle, .txt"
- "Handle large repositories" → "Handle repositories up to 2GB with maximum 10,000 files"
- "Provide good performance" → "Complete analysis within 300 seconds for repositories containing up to 200 microservices"
- "Generate multiple outputs" → "Generate exactly 5 output formats: PNG (max 4096x4096px), PlantUML (.txt), JSON architecture, traceability mapping, plain text report"

### Implementation Examples
- "Parse configuration files" → "Parse YAML files using ruamel.yaml 1.0.0, INI files using Python configparser, XML files using lxml 5.3.0"
- "Detect security patterns" → "Detect OAuth using patterns @EnableOAuth2, oauth2, OAuth2RestTemplate; detect SSL using patterns keystore, truststore, ssl.enabled=true"

## Final Deliverable Requirements

The generated functional specification must enable a developer to:
1. **Implement the complete system** without additional requirements gathering
2. **Write comprehensive tests** using the provided acceptance criteria
3. **Validate system behavior** against specific measurable requirements
4. **Deploy the system** using exact dependency and configuration specifications
5. **Troubleshoot issues** using specific error codes and logging requirements

**Remember:** Every statement in the specification must be precise, measurable, and directly implementable. If you cannot specify exact values, examine the codebase to find the actual implementation details.
