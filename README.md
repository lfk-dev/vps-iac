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
- **Secrets management**:
    1. Local file on my machine contains the key-value pairs of secrets
    2. Local script is used to update the GHA secrets via SSH
    3. Deployment workflow loads the GHA secrets to .env file in a runner.
    4. Secrets only persist while Docker Compose is executed on the runner.
- **CI/CD**: GitHub Actions
    - Manually triggered deployment of the services from GH Actions
    - Docker compose validation


### Planned / in progress
- **Configuration management**: Ansible
    - `fail2ban` configuration
    - user and groups management
    - `ufw` firewall rules
    - SSH hardening
- **Cloud infrastructure**: Terraform
    - VPS provisioning
    - DNS and firewall configuration
    - Object storage for backups
- **Monitoring and alerting**: Prometheus
    - Prometheus server for metrics collection
    - Node Exporter for VPS-level system metrics (CPU, memory, disk, network)
    - Basic alerting rules for host availability and resource usage

## Project goal
The goal of the project was to achieve highly replicable, reliable and well-documented IaC deployment for VPS with services for private use.

## Repository structure
- `docs/` - documentation and infrastructure planning
- `docker/` - docker compose files
- `scripts/` - scripts both for local and remote execution
- `.github/workflows/` - GitHub Actions workflows


