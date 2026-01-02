# IaC for personal VPS
This repository contains IaC for my personal VPS running self-hosted services. 

## Tech stack

### Currently implemented
- **Service deployment**: Docker Compose
- **Reverse proxy**: Traefik
    - reverse proxy(L7)
    - automatic TLS certification 
- **Services**:
    - `whoami` - test service

### Planned / in progress
- **CI/CD**: GitHub Actions
    - Docker compose validation
    - Shell linting
    - Automated deployment via SSH
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
- `.github/workflows/` - GitHub Actions workflows


