# Personal VPS Infrastructure

Production-grade infrastructure for self-hosted services, built with automation, security, and observability in mind.

**Key highlights:**
- Fully automated deployments via GitHub Actions + Ansible
- TLS termination and routing with Traefik reverse proxy
- Monitoring stack with Prometheus + Discord alerting
- Encrypted secrets pipeline (ansible-vault -> GitHub Secrets -> runtime injection)

## Why This Project?

I built this to run my own services while developing hands-on experience with real-world DevOps practices: automation, security hardening, monitoring, and GitOps workflows.

> [!IMPORTANT]
> For portfolio purposes, I focused on breadth of tools and practices rather than depth in any single tool.
> Future improvements are tracked in the [roadmap](#future-improvements) below.


## Tech Stack

### Container Orchestration
- **Docker Compose** — service deployment and orchestration
- **Traefik** — reverse proxy (L7) with automatic TLS certificate management

### Configuration Management — Ansible
- `fail2ban` configuration
- `ufw` firewall rules
- SSH hardening
- Volume backup management with retention policies

### CI/CD — GitHub Actions
- Manual deployment workflow with environment targeting
- Super-linter for code quality enforcement
- Ansible playbook execution

### Monitoring — Prometheus
- Node Exporter for system metrics collection
- Real-time notifications via Discord webhook
- Alerting for node metrics and traefik (network usage)


### Services
| Service | Description | Status |
|---------|-------------|--------|
| `nginx:alpine` | Test/demo service | ✅ Live |
| `kanboard` | Kanban board for task management | ✅ Live |
| `nextcloud` | Self-hosted cloud storage | ✅ Live |
| `garage` | S3-compatible object storage | 🔧 Deploying |
| `vaultwarden` | Password manager (Bitwarden-compatible) | 🔧 Configuring |
| `immich` | Photo and video gallery | 📋 Planned |


### Secrets Management
1. Secrets encrypted locally with `ansible-vault`
2. Local script decrypts and uploads to GitHub Actions Secrets
3. Deployment workflow handles secrets injection to Docker Compose and configuration files templates
4. Config files are copied to the host with proper permissions.


## Repository Structure

| Directory | Purpose |
|-----------|---------|
| `.github/workflows/` | CI/CD pipelines |
| `ansible/` | Configuration management playbooks |
| `docker/` | Docker Compose service definitions |
| `docs/` | Documentation and architecture decisions |
| `scripts/` | Automation and utility scripts |
| `configs/` | Configuration files for services | 

## Future Improvements

### High Priority
- **Terraform** — VPS provisioning, DNS management, remote state
- **Gitea Actions** — migrate CI/CD to self-hosted runner
- **Automated inventory** — Ansible inventory generated from Terraform outputs

### Security Enhancements
- HashiCorp Vault for advanced secrets management
- VPN gateway for production access restriction
- Host audit system (auditd + notifications)
  - SSH connection alerts with session details
  - Sudo usage logging and analysis
  - Failed login attempt notifications

### Operational Improvements
- Migrate cronjobs to systemd timer units
- Automatic security scanning on push to main
- Post-deployment performance tests
- Staging environment with isolated network
- Traefik configuration migration to YAML file
- Repository backup to external object storage
- (potenially): move to docker swarm in future for better config management