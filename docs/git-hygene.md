# Git Hygiene

## Branches
- Use feature branches for any small changes to the codebase
- Don't commit on main, only merge feature branches into main
- Use squash merges for feature branches for cleaner history
- Delete feature branches after merge


## Tags
- Use SemVer for tags, starting from 0.1.0
- Version 1.0.0 is the release with:
    - Basic security hardening
    - Automated deployment
    - 2-4 basic services
    - Fully working and configured reverse proxy
- Adjust tags retroactively to match the versioning scheme

## Commit history
- Don't rewrite history on main, try to improve from now on

## Commits
- Try to use conventional commits
    - Commits with new features should start with `feat:`
    - Commits with bug fixes should start with `fix:`
    - Potentially breaking changes should start with `<prefix>!:`

