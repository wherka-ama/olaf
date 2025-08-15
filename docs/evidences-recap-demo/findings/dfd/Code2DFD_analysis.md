# Code2DFD - Data Flow Diagrams

## Application Overview
- **Purpose:** Automatically extract dataflow diagrams (DFDs) that are enriched with security-relevant annotations from the source code of microservice applications
- **Type:** Command-line tool and RESTful API service
- **Technologies:** Python 3.x, Flask, PlantUML, PyDriller, PyYAML, lxml, Git
- **Architecture:** Framework-based analysis tool with pluggable technology-specific extractors

## Application Domain
Code2DFD is a **static analysis tool** specifically designed for:
- Automatic extraction of Data Flow Diagrams from microservice applications
- Security-enriched DFD generation with annotations
- Multi-technology support through pluggable extractors (26+ technologies)
- Academic research tool published in Journal of Systems and Software

## Codebase Structure Analysis

### Root Directory
- `code2DFD.py` - Main CLI entry point
- `flask_code2DFD.py` - RESTful API entry point (Flask server on port 5001)
- `microservice_dfds_metamodel.py` - Data model definitions
- `requirements.txt` - Python dependencies
- `plantuml.jar` - PlantUML rendering engine
- `config/config.ini` - Configuration files and repository examples

### Core Framework (`core/`)
- **DFD Extraction Engine** (`dfd_extraction.py`) - Main analysis orchestrator
- **Data Models** (`DFD.py`) - Service, InformationFlow, ExternalEntity classes
- **File Parsing** (`parse_files.py`) - Generic file analysis capabilities
- **Technology Switch** (`technology_switch.py`) - Router for technology-specific extractors

### Technology-Specific Extractors (`technology_specific_extractors/`)
**Infrastructure & Communication Technologies:**
- Docker, Docker Compose, Kafka, RabbitMQ, Nginx
- Eureka, Consul, Zookeeper (service discovery)
- Spring Gateway, Zuul (API gateways)
- RestTemplate, Feign Client (service communication)

**Security Technologies:**
- Spring OAuth, Spring Encryption, SSL/TLS
- HTTP Security, Authentication scopes
- Plaintext credentials detection

**Data & Monitoring:**
- Database connections, Elasticsearch
- Prometheus, Grafana, Kibana (monitoring)
- Hystrix, Circuit breakers (resilience)
- Local logging, Logstash

**Build & Configuration:**
- Maven, Gradle (build tools)
- Spring Config, Environment variables

### Output Generators (`output_generators/`)
- **PlantUML** - UML diagram generation
- **JSON** - Machine-readable DFD format
- **Plaintext** - Human-readable results
- **Visualizer** - PNG rendering (requires internet for PlantUML server)

## Key Technologies and Patterns Identified

### Programming Languages & Frameworks
- **Python 3.x** - Primary implementation language
- **Flask** - Web API framework
- **PyDriller** - Git repository analysis library

### Communication Protocols
- **HTTP/REST** - API endpoints and microservice communication
- **Message Queues** - RabbitMQ, Kafka for async communication
- **Docker Compose** - Container orchestration and service definition

### Data Storage
- **File System** - Local storage for cloned repositories and analysis outputs
- **JSON Files** - Machine-readable DFD export format
- **Configuration Files** - INI format for tool configuration

### External Dependencies
- **Git Repositories** - Source of analysis (GitHub, local repos)
- **PlantUML Server** - External service for PNG diagram rendering
- **Internet Connection** - Required for repository cloning and PNG generation

## Security Mechanisms
- **Credentials Detection** - Identifies plaintext credentials in code
- **Authentication Analysis** - Spring Security, OAuth configurations
- **Encryption Detection** - SSL/TLS, Spring Encryption configurations
- **Security Scope Analysis** - HTTP security and authorization patterns

## Context Diagram

### External Entities:
1. **CLI User** - Triggers analysis via command line interface
2. **API Client** - Calls REST API endpoints for programmatic access
3. **Git Hosting (GitHub/Local)** - Source repositories for analysis
4. **File System** - Local storage for repositories and outputs
5. **PlantUML Server** - External service for PNG diagram rendering

### System Interactions:
- CLI User → System: Configuration files, command-line parameters
- API Client → System: HTTP requests with repository URLs and optional commit hashes
- System → Git Hosting: Repository cloning and checkout operations
- System → File System: Read repository files, write analysis outputs
- System → PlantUML Server: Send UML markup, receive PNG diagrams

### ASCII Context Diagram:
```
[CLI User] ──config/params──▶ [Code2DFD System] ◀──HTTP requests──── [API Client]
                                       │
                              clone/checkout│
                                       ▼
                               [Git Repositories]
                                       │
                              analysis outputs│
                                       ▼
                                [File System]
                                       │
                              UML markup│
                                       ▼
                             [PlantUML Server] ──PNG──▶ [File System]
```

## Context Diagram

### External Entities:
1. **CLI User** - Person/system triggering analysis via command line interface using `code2DFD.py`
2. **API Client** - External application/service calling REST API endpoints for programmatic access via `/dfd` endpoint
3. **Git Repository** - Remote or local Git repositories (GitHub, GitLab, local repos) containing microservice source code to analyze
4. **File System** - Local file system for storing cloned repositories, configuration files, and analysis outputs
5. **PlantUML Server** - External web service for converting UML markup to PNG diagrams (optional, requires internet)

### System Interactions:
- **CLI User → System:** Configuration file paths, repository URLs, commit hashes, command-line parameters
- **API Client → System:** HTTP GET requests with `url` and optional `commit` parameters
- **System → Git Repository:** Git clone, checkout, and file reading operations via PyDriller
- **System → File System:** Read configuration files, write analysis outputs (JSON, UML, PNG, plaintext)
- **System → PlantUML Server:** Send UML markup text, receive rendered PNG diagrams

### Data Flows:
- **Input:** Repository URLs, configuration parameters, commit specifications
- **Output:** DFD diagrams (UML, PNG), JSON architecture files, plaintext results, traceability data
- **Bidirectional:** File system operations (read repository files, write outputs)

### ASCII Context Diagram:
```
                    [CLI User]
                        │
                   config/params
                        │
                        ▼
[API Client] ──HTTP──▶ [Code2DFD System] ◀──clone/checkout─── [Git Repository]
                        │                                          
                analysis│outputs                                   
                        │                                          
                        ▼                                          
                   [File System]                                   
                        │                                          
                  UML markup│                                      
                        │                                          
                        ▼                                          
               [PlantUML Server] ──PNG──▶ [File System]            
```

## Analysis Findings - Step 2 Complete

**Step 2 Status:** ✅ Complete
**Context Diagram:** Complete with 5 external entities
**System Boundary:** Code2DFD application (CLI + API + analysis engine)
**Key External Dependencies:** Git repositories, PlantUML server, local file system
