# TODO list

## CI/CD
- [x] Automatic deployment to the test environement
    - Use of detached bash scripts for deployment, removal and rollback. This way I can control via SSH also.
- [ ] Shell, Docker compose liting and validation
- [ ] Python linter and formatter (for scripts)
- [ ] Use caching for dclint (saves on time)
- [ ] Make sure that tags are up-to date (if new version comes, create the tag)
- [ ] Deployment via docker context over ssh (? do i want automatic deployment?)

## Configuration
- [ ] Automatic configuration of `fail2ban`
- [ ] `ufw` configuration
- [ ] SSH hardening
- [ ] User and groups management

## Docker compose
- [ ] Move services to seperate files


## Secrets management
- [x] Create `secrets.txt` (exclude in gitignore)
- [x] Script for loading screts to github (via `gh`)

## Security
- [ ] Users and groups on the VPS? (`deploy` user and group? with only access to docker and the repo?)


