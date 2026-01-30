# Scoping Terraform as Demonstration

## Status: Accepted, 2026-01-28

## Context

Initial plan: use Terraform to provision the VPS and achieve fully automated IaC deployment.

Reality: my actual VPS is a 12-month contract, not dynamically provisioned.

### Why not full cloud deployment?

1. This project does not need cloud resources like managed databases or complex networking
1. Cost and complexity are not justified for a single static VPS
1. Terraform here demonstrates capability, not a production requirement

## Decision

Limit Terraform to demonstration scope:

1. EC2 instance provisioned via Terraform
1. Docker Compose deploys the service stack

## Consequences

The Terraform deployment omits production features:

1. No Ansible run on the EC2 instance
1. No volume restoration or backup
1. No custom security hardening

### Mitigation

None planned. A future cloud-native project would be the appropriate place for full dynamic provisioning with backup and restore.
