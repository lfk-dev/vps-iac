# Configure firewall

**Status**: Accepted, 2026-01-23

## Context

**Problem**: Should I use custom nftables configuration on the VPS, to have full controll over the firwall setup.

**Options considered**:

1. Use custom nftables

- **Pros**:
  - Full controll over incoming packets
- **Cons**:
  - Requires good knowledge of the nftables
  - Can break docker engine behaviour (source: https://docs.docker.com/engine/network/packet-filtering-firewalls/)
  - More complex to maintain (like adding new services on docker)

2. Use UFW

- **Pros**:
  - Simple to maintain and deploy via Ansible
  - Easy to debug
  - Easy to update
- **Cons**:
  - Docker controls iptables rules for FORWARD and NAT chains
  - No full controll and audit of the rules

**Additional information**:

- The VPS is behind the cloud provider firewall, that excludes any traffic except defined ports (SSH, HTTP, HTTPS)

## Decision

Use UFW to configure the host firewall, let the docker engine to modify the rest of the chains.

**Rationale**:

- The cloud provider firewall already excludes and techincally "overrides" any allow rules created by Docker engine
- UFW is simple to maintain and deploy via Ansible
- This project is for personal use, so the exposure to external threats is limited
- There is no benefit to having full control over the host's firewall rules with project of this stage

## Consequences

**Pros**:

- Simple to maintain and deploy via Ansible
- Easy to debug and update

**Cons**:

- Docker controls iptables rules for FORWARD and NAT chains
- No full controll and audit of the rules
