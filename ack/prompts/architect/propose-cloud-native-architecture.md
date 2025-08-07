---
name: propose-cloud-native-architecture
description: Analyze legacy application modules and design modern, scalable cloud-native architectures for Kubernetes-based environments.
tags: [cloud-architecture, kubernetes, modernization, microservices, infrastructure]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **spec_path**: string - Path to the technical specification of the legacy module
- **target_framework**: string - Target cloud-native framework (e.g., "Skube")
- **goals**: array[scalability,resilience,maintainability,cost_optimization] - (Optional) Primary modernization goals
- **constraints**: array[stateless,compliance,legacy_integration] - (Optional) Architectural constraints

## Process

1. **Legacy Analysis**:
   - Review technical specification
   - Identify core functionalities
   - Map dependencies and data flows
   - Document current limitations

2. **Cloud-Native Design**:
   - Decompose into microservices
   - Design containerization strategy
   - Plan state management
   - Design communication patterns
   - Select appropriate storage solutions

3. **Infrastructure Planning**:
   - Design Kubernetes resources
   - Plan networking and service mesh
   - Configure monitoring and logging
   - Design CI/CD pipeline

4. **Migration Strategy**:
   - Assess refactoring effort
   - Plan incremental migration
   - Design rollback procedures
   - Document risk mitigation

## Output/Result Format
Follow template structure: `[id:templates_dir]architect/cloud-native-architecture-template.md`

Structure with comprehensive sections:
- Executive summary and legacy analysis
- Cloud-native architecture design with microservices decomposition
- Infrastructure components and data architecture
- Security, observability, and CI/CD pipeline design
- Migration strategy with phases and risk assessment
- Success metrics and implementation roadmap

## Output to USER
1. **Architecture Proposal**:
   - High-level design overview
   - Component relationships
   - Technology stack recommendations

2. **Technical Details**:
   - Service specifications
   - API contracts
   - Data flow diagrams
   - Infrastructure requirements

3. **Migration Guide**:
   - Step-by-step migration plan
   - Risk assessment
   - Success metrics
   - Validation criteria

## Domain-Specific Rules
- Rule 1: Follow 12-factor app principles
- Rule 2: Design for failure
- Rule 3: Implement observability by design
- Rule 4: Prioritize security and compliance
- Rule 5: Optimize for cost and performance

## Required Actions
1. Analyze legacy architecture
2. Design cloud-native solution
3. Document technical specifications
4. Create migration strategy
5. Provide implementation guidance

## Architecture Components

### Service Design
```yaml
services:
  - name: user-service
    type: stateless
    language: [nodejs, python, go]
    storage: [postgres, redis]
    observability: [prometheus, jaeger, fluentd]
    scaling: horizontal-pod-autoscaler
    replicas: 3
```

### Infrastructure Template
```hcl
resource "kubernetes_deployment" "example" {
  metadata {
    name = "example-service"
    labels = {
      app = "example"
    }
  }
  spec {
    replicas = 3
    # Additional configuration...
  }
}
```

## Migration Checklist
- [ ] Containerize application
- [ ] Externalize configuration
- [ ] Implement health checks
- [ ] Set up monitoring
- [ ] Configure logging
- [ ] Implement CI/CD
- [ ] Test scaling
- [ ] Document operations

⚠️ **Critical Notes**
- Consider data migration strategy
- Plan for zero-downtime deployment
- Implement proper secret management
- Design for multi-region deployment
- Include disaster recovery plan
