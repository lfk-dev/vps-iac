
## Roles

### fail2ban
- Set's up fail2ban for `sshd`
- Secrets prefixed with `vault_`

### restic
- Set's restic backup for docker volumes
- Secrets prefixed with `vault_`
- Tags:
    - `check` - checks the repository and prints the output in stdout
    - `init` - initilizes repository and set's up the cronjob
