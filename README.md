## Production-Ready Memos Deployment on Amazon EKS
 ---
 Production-style deployment of the Memos application on Amazon EKS using Terraform, GitOps, ArgoCD, Traefik, GitHub Actions, and Kubernetes observability.
 
## Overview

This project demonstrates deploying a cloud-native application on AWS using Terraform, Kubernetes, ArgoCD, and GitHub Actions.

The infrastructure is provisioned using Terraform, which also installs core Kubernetes platform components using Helm. Application deployments are managed through GitOps using ArgoCD. PostgreSQL persistence is provided by Amazon RDS, secrets are synchronised from AWS Secrets Manager using External Secrets Operator, TLS is automated using cert-manager, and cluster/application metrics are collected by Prometheus and visualised through Grafana.

## Architecture
---
## Tech Stack

| Category | Technology |
|----------|------------|
| Cloud | AWS |
| Infrastructure as Code (IaC) | Terraform |
| Container Orchestration | Kubernetes (Amazon EKS) |
| GitOps | ArgoCD |
| CI/CD | GitHub Actions |
| Container Registry | Amazon ECR |
| Database | Amazon RDS PostgreSQL |
| Ingress | Traefik |
| DNS | Cloudflare + External DNS |
| Secrets Management | AWS Secrets Manager + External Secrets Operator |
| Monitoring & Observability | Prometheus + Grafana |

---
## Features

- Infrastructure as Code with Terraform
- Amazon EKS Kubernetes cluster
- Amazon RDS PostgreSQL database
- Amazon ECR container registry
- GitOps deployment with ArgoCD
- Automated CI/CD with GitHub Actions
- Traefik ingress controller
- Automatic TLS certificates with cert-manager
- AWS Secrets Manager integration
- Prometheus metrics
- Grafana dashboards
- Helm-based Kubernetes platform deployment
- Kubernetes observability
---
## Project Structure
```
eks-memos/
│
├── README.md
│
├── .github/
│   └── workflows/
│       ├── terraform-plan.yaml
│       ├── terraform-apply.yaml
│       ├── terraform-destroy.yaml
│       └── docker-build.yaml
│
├── app/
│   └── Dockerfile
│
├── k8s/
│   │
│   ├── root-application.yaml
│   │
│   ├── apps/
│   │   ├── memos-application.yaml
│   │   ├── monitoring-application.yaml
│   │   └── secrets-application.yaml
│   │
│   ├── bootstrap/
│   │   ├── apps-root.yaml
│   │   │
│   │   ├── argocd/
│   │   │   ├── argocd-self-managed.yaml
│   │   │   └── namespace.yaml
│   │   │
│   │   └── cert-manager/
│   │       └── cert-manager.yaml
│   │
│   ├── memos/
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   ├── ingress.yaml
│   │   └── serviceaccount.yaml
│   │
│   └── secrets/
│       ├── external-secrets.yaml
│       ├── secret-store.yaml
│       └── grafana-secret.yaml
│
└── terraform/
    │
    ├── main.tf
    ├── provider.tf
    ├── variables.tf
    ├── outputs.tf
    │
    ├── bootstrap/
    │   ├── main.tf
    │   ├── provider.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── modules/
        │
        ├── vpc/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        │
        ├── eks/
        │   ├── main.tf
        │   ├── helm.tf
        │   ├── pod-identity.tf
        │   ├── variables.tf
        │   └── outputs.tf
        │
        ├── rds/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        │
        └── sg/
            ├── main.tf
            ├── variables.tf
            └── outputs.tf

```
---

## Deployment Workflow

The deployment process follows an Infrastructure as Code and GitOps approach. Terraform is responsible for provisioning AWS infrastructure and installing Kubernetes platform components through Helm releases. ArgoCD continuously synchronises Kubernetes manifests from the Git repository, ensuring the cluster remains in the desired state.
 
## 1. Infrastructure

Terraform provisions:

- VPC
- Public and Private Subnets
- NAT Gateway
- Internet Gateway
- Route Tables
- EKS Cluster
- Managed Node Group
- IAM Roles
- Security Groups
- Amazon RDS
- Amazon ECR
- Secrets Manager

## 2. Kubernetes Platform Installation

After the EKS cluster and worker nodes are available, Terraform uses the Helm provider to install core Kubernetes services.

The following Helm releases are deployed automatically:

| Helm Release | Purpose |
|--------------|---------|
| Traefik | Ingress controller that routes external HTTP/HTTPS traffic into the cluster |
| cert-manager | Automates TLS certificate issuance and renewal using Let's Encrypt |
| External DNS | Automatically manages DNS records for Kubernetes services and ingress resources |
| External Secrets Operator | Synchronises secrets from external secret stores into Kubernetes Secrets |
| ArgoCD | GitOps continuous delivery platform for application deployment |

These platform services provide networking, security, DNS automation, secret management, and GitOps capabilities before any application workloads are deployed.

## 3. Application Container Pipeline

Application changes trigger the CI pipeline:

1. GitHub Actions builds the Docker image
2. The image is tagged and pushed to Amazon ECR
3. Kubernetes deployment manifests are updated with the new image version

The EKS cluster retrieves container images from ECR during deployment.

## 4. GitOps Deployment with ArgoCD

Once ArgoCD is installed by Terraform, it manages application deployments using Git as the source of truth.

ArgoCD continuously monitors Kubernetes manifests stored in the repository.

When changes are detected:

1. ArgoCD compares Git state with the current cluster state
2. Detects configuration drift
3. Applies Kubernetes manifests
4. Maintains the desired state of applications

ArgoCD manages:

- Memos application
- Monitoring stack
- Application configuration
- Kubernetes resources

## 5. Request flow

External traffic flows through the Kubernetes ingress layer:

```text
User
 │
 ▼
Cloudflare
 │
 ▼
Traefik LoadBalancer Service
 │
 ▼
Traefik Ingress Controller
 │
 ▼
Kubernetes Service
 │
 ▼
Memos Pods
 │
 ▼
Amazon RDS PostgreSQL
```

DNS records are automatically managed by External DNS, while TLS certificates are automatically provisioned and renewed by cert-manager.

## 6. Monitoring and Observability

The cluster includes Prometheus and Grafana for Kubernetes and application monitoring.

The monitoring stack provides visibility into:

- Node resource usage
- Pod health
- CPU and memory consumption
- Container restarts
- Application availability
- Cluster performance

Metrics are collected by Prometheus and visualised through Grafana dashboards.


```text
Kubernetes Resources
        │
        ▼
   Prometheus
        │
        ▼
     Grafana
        │
        ▼
Monitoring Dashboards
```
---
## Security


Security practices implemented:

- Private Kubernetes worker nodes
- HTTPS-only application access
- TLS certificates managed automatically with cert-manager
- Secrets stored in AWS Secrets Manager
- External Secrets Operator for Kubernetes secret synchronisation
- IAM least privilege permissions
- Security groups controlling network access
- PostgreSQL database isolated from public access
- Container images stored securely in Amazon ECR

---

## Future Improvements

- Cluster Autoscaler
- Loki for log aggregation
- Alertmanager notifications
- Multi-environment deployments (dev/staging/production)
- Blue/Green deployments
---














































