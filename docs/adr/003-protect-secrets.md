# Protecting and handling secrets

## Status: Accepted, 2026-01-25

## Context

While configuring multiple tools like Ansible or Docker Compose, there is a need to use secrets. Current solution does not track the secrets files, they are encrypted with Ansible Vault and exported to GHA Secrets via CLI.

### Options considered

1. Using external secrets manager

   - **Pros**:
     - Strong access control and policy control
     - Audit logs
   - **Cons**:
     - Huge operational overhead
     - Adds runtime dependency on external service/network
     - Requires more integration (for every tool)
     - Costs money

1. Single locally encrypted file, decrypted and parsed during deployment

   - **Pros**:
     - Simple mental model: one artifact to manage per environment
   - **Cons**:
     - Requires parsing script that can cause mistakes
     - Additional complexity when parsing the secrets into different files (for differnt tools)
     - Lack of transparancy: the files are not readable, there is an external template or docs file needed to list all needed secrets

1. Mozilla SOPS

   - **Pros**:
     - Git firendly, minimal diffs
     - Supports most common config files
     - Flexible key backends
     - Edit in memory, the values are always encrypted at rest
     - Can be decrypted non-interactively (e.g. via uploaded private key in GHA secrets)
     - Self documenting: no need to explain what secrets must be set, they are visible in their files.
   - **Cons**:
     - Key rotation is strongly advised
     - Dependency from the key backend

## Decision

I will protect all my secrets with SOPS, keeping them in the files tracked by git.

## Consequences

- Implementation strategy:
  - Set up the `age` backend
  - Encrypt existing secrets files for ansible, configs and docker compose
  - Store the private key file securealy outside the repository
  - Add pre-commit hook that verifies encryption of secrets files
- If the complexity of the project increases, the next step would be to upgrade to external secrets management
