# Security hardening on VPS

## Users and groups management
- **Deployment user** - used for deployment
    - Configured with password
    - Has sudo access without password
    - Used by GitHub Actions and Ansible
- **Human user** - for human access
    - Configured with password and requires password for sudo
    - Access to VPS via SSH with key authentication
- No changes to groups, except adding both users to `docker` group 

## SSH
- Custom SSH port
- Disabled root access 
- Only access via key authentication
- Both users have different SSH keys


## Fail2ban
- Configured for:
    - SSH
    - Traefik
    - Backend services behind Traefik

## UFW
- Enabled only necessary ports (least privilege principle)

## Secrets handling
- Secrets are stored locally in encrypted file (Ansible Vault) and in GitHub Actions Secrets
- GitHub Actions workflow loads secrets to the runner
- Ansible deployments on local machine prompt for password to the secrets