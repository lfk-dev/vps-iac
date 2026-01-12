# IaC for Personal VPS

This repository contains Infrastructure as Code for my personal VPS running self-hosted services.

## Project Goal

Build highly replicable, reliable, and well-documented infrastructure deployment for a VPS hosting private services, demonstrating DevOps practices for portfolio purposes.

## Tech Stack

### Configuration Management
- **Ansible**
  - `fail2ban` configuration
  - `ufw` firewall rules (**in progress**)
  - SSH hardening (**in progress**)
  - Volume backup management (**in progress**)

### Container Orchestration
- **Docker Compose** - service deployment
- **Traefik** - reverse proxy (L7) with automatic TLS certification

### Services
- `nginx:alpine` - test service
- `kanboard` - kanban board
- `nextcloud` - cloud storage (**in progress**)
- `garage` - S3-compatible object storage (**in progress**)
- `vaultwarden` - password manager (**in progress**)
- `immich` - photo and video gallery (**in progress**)

### CI/CD
- **GitHub Actions**
  - Manual deployment workflow
  - Super-linter for code quality
  - Ansible deployment (**in progress**)

### Secrets Management
1. Secrets encrypted locally with Ansible Vault
2. Local script decrypts and uploads to GitHub Actions Secrets
3. Deployment workflow loads secrets to `.env` file on runner
4. Secrets only persist during Docker Compose execution

### Planned
- **Terraform** - VPS provisioning, DNS/firewall configuration, object storage for backups
- **Prometheus** - metrics collection, Node Exporter for system metrics, basic alerting

## Repository Structure

- `.github/workflows/` `- CI/CD pipelines`
- `ansible/` `- Configuration management playbooks`
- `docker/` `- Docker Compose files`
- `docs/` `- Documentation and planning`
- `scripts/` `- Automation scripts`

## Roadmap

**Infrastructure**
- Automatic Ansible inventory updates from Terraform outputs
- Terraform provisioning and state management

**CI/CD**
- Migrate to self-hosted Gitea Actions
- Automatic security testing on push to main
- Performance tests post-deployment
- Staging environment with enhanced security

**Security**
- Advanced secret management (HashiCorp Vault)
- VPN gateway VPS for production access restriction

**Operations**
- Repository backup script to external object storage