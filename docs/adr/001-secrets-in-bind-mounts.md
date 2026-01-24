# Secrets in Bind Mounts

## Status

Accepted, 2026-01-21

## Context

Some Docker containers require configuration files that cannot be fully managed via environment variables, labels, or entrypoint flags (e.g. Prometheus and Alertmanager).

**Options considered:**
- `docker cp` to copy files into running containers
- Docker Swarm mode with native secrets/config management
- Bind mounts with host files
- Seeding files into named volumes at runtime

## Decision

Bind mounts with templated configuration files.
**Security note:**
- Storing the configuration files on the node in plaintext without proper permissions can pose a security risk
- Making the files non-readable to "others" can break some container images that don't use common 1000:1000 UID:GID pattern
- To solve that issue the init container called `config-loader` is used, to copy the files from the node into the named volume and adjust permissions

**Flow**:
- Config files are stored as templates in the GitHub repository (secrets excluded)
- During deployment, GitHub Actions injects secrets from GitHub Actions Secrets
- Files are copied with proper permissions and ownership to the host via rsync over SSH
- Init container copies the files to the named volume with proper permissions

## Consequences

**Tradeoffs:**
- Config files containing secrets are stored in plaintext on the host
- File permissions restrict access to the owning user and group
- Root access to the host means access to all secrets

**Why this is acceptable:**
- Root compromise already implies full access (container exec, memory inspection, etc.)
- Docker Swarm adds operational complexity unnecessary for single-node deployment
- External secrets managers (HashiCorp Vault for example) are overkill at this scale, but are a good option for future improvements
- The project is single user and single node in nature. There is limited scaling needed

**Migration path:**
- The issue could be solved with upgrading to Docker Swarm or creating custom GHA Workflow that can handle seeding the files to volumes