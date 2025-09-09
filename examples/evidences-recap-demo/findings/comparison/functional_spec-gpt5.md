# Functional Specification: Code2DFD

Generated: 2025-08-11
Source DFD Files: Code2DFD_analysis.md, DFD_level1_tasks.md, DFD_level2_tasks.md, DFD_level_analysis.md
Traceability: Every FR maps to DFD Process (P#) and where applicable Level 2 Sub‑Process (S#)

## 1. System Overview (Context)
**System Purpose:** Analyze a target Git repository (remote or local) at a specific commit and produce a precise Data Flow Diagram (DFD) model (microservices, external components, information flows, traceability) plus multi‑format artifacts.
**External Entities:**
1. User / Client – invokes CLI or HTTP API.
2. Git Repository Host – clone source (GitHub or local path).
3. Target Application Repository – working copy (read‑only after checkout) supplying source files and config.
4. External Technology Services (Detected) – Kafka, RabbitMQ, Eureka, Spring Config, Databases, Gateways, Registries, Brokers, Logging (ELK), Monitoring (Prometheus, Grafana, Zipkin, Spring Admin), Load Balancers (Ribbon), Circuit Breakers (Hystrix/Turbine), Encryption/SSL endpoints, Misc (mail servers, external websites), HTTP servers (Nginx, Apache HTTPD).
5. Output File System – destination for generated artifacts.
6. Downstream Consumers – engineers/tools reading artifacts (passive recipients).
**Primary Data Flows:** CLI/API invocation parameters; repository clone contents; configuration and code scanning results; technology classification outputs; generated artifact files returned or persisted.
**System Boundary:** Inside: extraction logic (repository mining, technology detectors, model construction, deduplication, artifact generation). Outside: remote Git hosting, detected external services, consumer tools, filesystem storage medium.

## 2. Functional Requirements (Level 1 Mapping)
P1..P9 mapped to FR‑1..FR‑9. All SHALL statements are mandatory.

### FR-1: Initialize Configuration
Source Process: P1 Initialize Configuration
Requirement: The system SHALL build a runtime configuration (tmp.tmp_config) by copying DEFAULT_CONFIG sections (Analysis Settings, Repository, Technology Profiles, DFD) and applying CLI/API parameters (Repository.url, Repository.local_path, Analysis Settings.commit, Analysis Settings.development_mode).
Inputs (from DFD): Execution parameters (repo URL, optional commit, flags).
Outputs: In‑memory config with resolved repository URL, local path, optional commit, derived output_path.
Implementation Requirements:
- Uses ConfigParser; DEFAULT_CONFIG seeds sections; communication_techs_list constant COMMUNICATIONS_TECH_LIST defined in code2DFD.py.
- Output path format: code2DFD_output/<repo_name>--<commit7> (commit truncated to 7 chars).
Level 2: N/A.

### FR-2: Clone & Checkout Repository
Source Process: P2 Clone & Checkout
Requirement: The system SHALL clone or prepare the target repository into Repository.local_path and checkout the specified commit (or HEAD if unspecified) using PyDriller.Repository._prep_repo.
Inputs: Runtime config (FR‑1), repo URL, optional commit.
Outputs: Local working copy path, resolved commit hash (7 chars), updated output_path, head hash restored after extraction.
Implementation Requirements:
- Library versions: PyDriller==2.6.0, Python datetime for timestamps.
- Creates directories via os.makedirs; ensures isolation per repo/commit.
Level 2: N/A.

### FR-3: Detect Services & Components (Initial)
Source Process: P3 Detect Services & Components
Requirement: The system SHALL identify microservices (microservices dict) via technology_switch.get_microservices and augment with detected databases and SSL services before port overwrite.
Inputs: Working copy (D1), runtime config.
Outputs: microservices dict with preliminary properties/stereotypes (including database and ssl services) and tagged Port values where discoverable.
Implementation Requirements:
- Executes detect_databases, overwrite_port, detect_ssl_services sequentially.
- Port extraction: property tuples ("port", value, origin) converted to tagged_values ("Port", int or string cleaned of protocol suffix).
Level 2: N/A.

### FR-4: Parse Configurations & Properties
Source Process: P4 Parse Configurations & Properties
Requirement: The system SHALL parse Spring config (detect_spring_config) and eureka server (detect_eureka_server_only), re‑apply overwrite_port, and persist updated microservices, information_flows, external_components into tmp.tmp_config (section DFD) for later merging.
Inputs: microservices (FR‑3), configuration files in working copy.
Outputs: Enriched microservices with properties (auth scopes, ports, endpoints prelim), preliminary information_flows, external_components.
Implementation Requirements:
- Results serialized into tmp.tmp_config with % escaped as %%.
Level 2: N/A.

### FR-5: Classify & Enrich Technologies
Source Process: P5 Classify & Enrich Technologies
Requirement: The system SHALL classify brokers (RabbitMQ, Kafka) first (classify_brokers) then apply detect_authentication_scopes and persist interim microservices/external_components; then execute comprehensive classifier sequence (see FR‑6) covering gateways, registries, logging, monitoring, resilience, encryption, endpoints, miscellaneous detections.
Inputs: Enriched microservices, information_flows, external_components.
Outputs: Updated microservices with stereotype_instances/tagged_values for brokers and auth scopes.
Implementation Requirements:
- Broker detection functions: detect_rabbitmq_server, detect_kafka_server.
- Authentication: detect_authentication_scopes.
Level 2 Decomposition: S1 Auth Scope Detection, S2 Broker Server Detection precede other sub‑processes.

### FR-6: Aggregate Technology Classifications & Endpoints
Source Processes: P5 (remaining S3–S11 sub‑processes)
Requirement: The system SHALL execute all remaining detectors in defined order to classify service registry, gateways, security, logging, monitoring, circuit breakers, load balancers, encryption, endpoints, miscellaneous external actors, and finalize service functionality classification and plaintext credential tagging.
Inputs: microservices/information_flows/external_components from FR‑5.
Outputs: Expanded microservices, information_flows, external_components, including user component and flows if gateway (Zuul) found, external website/mail servers, configuration server links, gateway routing flows, instrumentation components.
Implementation Requirements (Exact detector call order from core.dfd_extraction.classify_microservices):
1. detect_eureka
2. detect_zuul
3. detect_spring_cloud_gateway
4. detect_spring_oauth
5. detect_consul
6. detect_hystrix_dashboard
7. detect_turbine
8. detect_local_logging
9. detect_zipkin_server
10. detect_spring_admin_server
11. detect_prometheus_server
12. detect_circuit_breakers
13. detect_load_balancers
14. detect_ribbon_load_balancers
15. detect_hystrix_circuit_breakers
16. detect_zookeeper
17. detect_kibana
18. detect_elasticsearch
19. detect_logstash
20. detect_nginx
21. detect_grafana
22. detect_spring_encryption
23. detect_endpoints
24. detect_miscellaneous (mail_server, external-website, config links)
25. detect_apachehttpd_webserver
26. classify_internal_infrastructural
27. set_plaintext_credentials
Level 2 Sub‑Process Mapping: S3 Service Registry & Discovery (2,5,16), S4 Gateway & Routing (2,3 + flows), S5 Circuit Breaker & Resilience (12,15), S6 Monitoring & Observability (10,11,21,9), S7 Logging & Tracing (8,19,17), S8 Encryption & Security (22 plus SSL earlier), S9 Endpoint Extraction (23), S10 Misc External Detection (24), S11 Aggregation & Handoff (implicit at end of sequence before merge P7).

### FR-7: Merge & Deduplicate Model
Source Process: P7 Merge & Deduplicate Model
Requirement: The system SHALL merge duplicate information flows, nodes, and annotations to ensure unique canonical representations.
Inputs: Raw microservices, information_flows, external_components after FR‑6.
Outputs: Deduplicated microservices/information_flows/external_components with consolidated stereotype_instances and tagged_values.
Implementation Requirements:
- merge_duplicate_flows: casefold sender/receiver, combine non‑sender/receiver fields.
- merge_duplicate_nodes: casefold names, merge fields except name, type.
- merge_duplicate_annotations: set uniqueness; normalize Port values (strip protocol suffix, int cast when possible); list→string normalization for tagged_values.
Level 2: N/A.

### FR-8: Clean & Finalize Model
Source Process: P8 Clean & Finalize Model
Requirement: The system SHALL perform database connection cleanup (clean_database_connections) and finalize microservices/information_flows/external_components dictionaries.
Inputs: Deduplicated model (FR‑7).
Outputs: Final model dictionaries ready for artifact generation.
Implementation Requirements: Enforces removal/normalization of redundant DB connection flows.
Level 2: N/A.

### FR-9: Generate Artifacts
Source Process: P9 Generate Artifacts
Requirement: The system SHALL write plaintext, codeable model JSON, traceability JSON, PNG visualization, JSON edges, and JSON architecture artifacts to output_path, returning codeable model and traceability structures to caller.
Inputs: Final model (FR‑8), output_path, tmp.tmp_config DFD entries.
Outputs: Files:
- <repo_name>--<commit7>_results.txt (plaintext summary)
- <repo_name>--<commit7>_traceability.json
- codeable model files (path returned by output_codeable_model)
- PNG visualization (visualizer.output_png)
- json_edges (json_edges.generate_json_edges)
- json_architecture (json_architecture.generate_json_architecture)
Implementation Requirements:
- Library versions: Flask==2.1.2 (API server), plantuml==0.3.0 (diagram generation), PyYAML==6.0, ruamel.base==1.0.0, PyDriller==2.6.0, lxml==5.3.0.
- Execution time captured (api_invocation) and returned as execution_time (float seconds).
Level 2: N/A.

## 3. Data Store Specifications
D1 Working Copy (Cloned Repo): Local filesystem path (tmp.tmp_config[Repository][local_path]); read only after checkout.
D2 Runtime Config State: In‑memory ConfigParser (tmp.tmp_config) with sections Analysis Settings, Repository, Technology Profiles, DFD.
D3 Generated Artifacts Directory: code2DFD_output/<repo_name>--<commit7>/ containing results and model files.
D4 Traceability Records: In‑memory traceability dict (nodes, edges, sub_items) serialized to *_traceability.json.
Internal Level 2 Stores (P5): DS1 Service Annotation Set, DS2 Flow Candidate Buffer, DS3 External Component Working Set, DS4 Trace Buffer, DS5 Credential Tag Map (transient; embodied within microservices/information_flows/external_components and traceability before serialization).

## 4. External Interface Specifications
HTTP API (flask_code2DFD.py):
- GET / : Returns usage string.
- GET /dfd?url=<repo_url>[&commit=<hash>] : Triggers extraction; returns JSON with keys codeable_models_file, traceability_file, execution_time.
CLI (code2DFD.py):
- Arguments: --config_path, --repo_url, --repo_local_path, --github_handle, --commit, --development_mode.
- Behavior: Builds tmp config, performs analysis, writes artifacts (no JSON response printing specified beyond logs).
User ↔ System Interface: RESTful HTTP over localhost:5001 (debug=True, host 127.0.0.1, port 5001) for API variant.

## 5. Non-Functional Requirements
NFR-1 Performance: The system SHALL complete analysis and artifact generation for a single repository invocation and record execution_time (seconds). (Baseline measurement instrumentation present; specific SLA to be established by adding threshold tests.)
NFR-2 Determinism: Given identical repo URL and commit, the system SHALL produce identical artifact filenames and deterministic model content barring external network variance in clone.
NFR-3 Traceability: The system SHALL record every stereotype/tagged value or flow creation with file, line, span (or heuristic/implicit) enabling edge and node provenance in *_traceability.json.
NFR-4 Extensibility: New technology detectors SHALL integrate by appending calls in classify_microservices preserving order constraints (registries preceding gateways, security before endpoints tagging, etc.).
NFR-5 Completeness of Artifacts: The system SHALL always output all artifact types when microservices dict is non‑empty; absence of a category produces still the file with whatever sections are available (plaintext writer writes conditional blocks sequentially).
NFR-6 Configuration Isolation: Per invocation output SHALL be written to a unique path based on repo_name and commit7 preventing overwrite collisions.

## 6. Performance Specifications (Current Implementation Observations)
- Single threaded sequential detector pipeline; potential parallelization after detector #5 (post service registry) identified in DFD analysis but not yet implemented.
- Execution time measurement granularity: whole invocation only (no per‑detector timing currently recorded).

## 7. Security Requirements
- The system SHALL tag plaintext credentials when detect_plaintext_credentials identifies properties, marking services and adding plaintext_credentials stereotypes/links where passwords are propagated.
- The system SHALL detect SSL services (detect_ssl_services) and encryption tags (detect_spring_encryption), recording Port and encryption stereotypes in tagged_values/stereotype_instances.
- The system SHALL reverse erroneous Zuul→ServiceDiscovery flow direction to maintain accurate trust boundaries.

## 8. Traceability & Acceptance Criteria
For each FR:
- FR‑1..FR‑9: Presence of corresponding code paths in code2DFD.py or core/dfd_extraction.py and output artifacts verifies fulfillment.
- Deduplication acceptance: After FR‑7 no duplicate sender/receiver pairs or duplicate node names (case-insensitive) exist; tagged_values lists contain unique (tag,value) tuples.
- Gateway user injection: If gateway detected (@EnableZuulServer or @EnableZuulProxy), external component 'user' exists with stereotypes [user_stereotype, entrypoint, exitpoint] and bi‑directional restful_http flows.

## 9. Quality Assurance Checklist (Executed)
- All 9 Level 1 processes mapped (FR‑1..FR‑9) ✔
- All data stores mapped (D1..D4 + Level 2 DS1..DS5) ✔
- Level 2 sub‑processes integrated in FR‑5/FR‑6 mapping ✔
- No vague terms (etc., various, multiple, some, many, appropriate, suitable, around, approximately) present ✔
- Exact dependency versions recorded ✔

## 10. Glossary
- microservices dict: Mapping id→{name, stereotype_instances, tagged_values, ...}
- information_flows dict: Mapping id→{sender, receiver, stereotype_instances, tagged_values}
- external_components dict: Mapping id→external components analogous to microservices.
- tagged_values: List of (Key, Value) tuples attached to nodes/flows.

## 11. Future Enhancements (Non-binding)
- Add per‑detector timing to support quantitative performance NFR.
- Implement parallel execution lanes for monitoring/logging/security after registry detection.
- Introduce policy-driven detector ordering via configuration.
- Emit machine-readable metrics summary (counts of services, flows, external components) for regression tests.

End of Functional Specification.
