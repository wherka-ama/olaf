# Non-Functional Requirements (NFRs): [Project Name]

## 1. General Product NFRs

This section defines the global NFRs that apply across the entire product.

### Performance
| ID | Requirement | Metric | Target |
| :--- | :--- | :--- | :--- |
| PERF-GEN-01 | API Response Time | Milliseconds (ms) | 95% of API calls should complete in < 500ms. |
| PERF-GEN-02 | Page Load Time | Seconds (s) | Core application pages must load in < 2s. |

### Security
| ID | Requirement | Metric | Target |
| :--- | :--- | :--- | :--- |
| SEC-GEN-01 | Data Encryption | Standard | All data at rest and in transit must be encrypted using AES-256 or higher. |
| SEC-GEN-02 | Vulnerability Scan | OWASP ZAP Scan | No critical or high-severity vulnerabilities detected. |

### Reliability
| ID | Requirement | Metric | Target |
| :--- | :--- | :--- | :--- |
| REL-GEN-01 | System Uptime | Percentage (%) | 99.9% uptime per month. |
| REL-GEN-02 | Error Rate | Percentage (%) | Less than 0.1% of requests result in a 5xx error. |

### Scalability
| ID | Requirement | Metric | Target |
| :--- | :--- | :--- | :--- |
| SCAL-GEN-01 | Concurrent Users | Number of Users | System must support 1,000 concurrent users without performance degradation. |

---

## 2. Feature Set Specific NFRs

This section details NFRs that are specific to a particular feature set, inheriting all general NFRs unless overridden.

### Feature Set: [Name of Feature Set, e.g., Reporting]
| ID | Requirement | Metric | Target |
| :--- | :--- | :--- | :--- |
| NFR-REP-01 | Report Generation Time | Seconds (s) | 95% of standard reports must generate in < 30s. |
| NFR-REP-02 | Data Export Throughput | Megabytes per second (MB/s) | System must support data exports at a rate of 5 MB/s. |

### Feature Set: [Name of Feature Set, e.g., Real-time Dashboard]
| ID | Requirement | Metric | Target |
| :--- | :--- | :--- | :--- |
| NFR-DASH-01 | Data Refresh Latency | Seconds (s) | Dashboard data must refresh every 10 seconds. |