# IaC for personal VPS
This repository contains IaC for my personal VPS running self-hosted services. 

## Tech stack

### Currently implemented
- **Service deployment**: Docker Compose
- **Reverse proxy**: Traefik
    - reverse proxy(L7)
    - automatic TLS certification 
- **Services**:
    - `nginx:alpine` - test service
    - `kanboard` - kanban board for personal use
    - `nextcloud` - cloud storage (**in progress**)
    - `garage` - S3 compatible object storage (**in progress**)
    - `vaultwarden` - password manager (**in progress**)
    - `immich` - photo and video gallery (**in progress**)
- **Secrets management**:
    1. Locally encrypted file on my machine contains the key-value pairs of secrets
    2. Local script is used to upload secrets to GitHub Actions secrets
    3. Deployment workflow loads the GHA secrets to .env file in a runner.
    4. Secrets only persist while Docker Compose is executed on the runner.
- **CI/CD**: GitHub Actions
    - Manual deployment from GitHub repository to the VPS
    - Super-linter
    - Ansible deployment with GitHub Actions (**in progress**)


### Planned / in progress
- **Configuration management**: Ansible
    - `fail2ban` configuration
    - User and groups management
    - `ufw` firewall rules
    - SSH hardening
    - Volume backup management
- **Cloud infrastructure**: Terraform
    - VPS provisioning
    - DNS and firewall configuration
    - Object storage for backups
- **Monitoring and alerting**: Prometheus
    - Prometheus server for metrics collection
    - Node Exporter for VPS-level system metrics (CPU, memory, disk, network)
    - Basic alerting rules for host availability and resource usage

## Project goal
The goal of the project was to achieve highly replicable, reliable and well-documented IaC deployment for VPS with services for private use and as a portfolio project.

## Repository structure
- `docs/` - documentation and infrastructure planning
- `docker/` - docker compose files
- `scripts/` - scripts both for local and remote execution
- `ansible/` - ansible playbooks
- `.github/workflows/` - GitHub Actions workflows


