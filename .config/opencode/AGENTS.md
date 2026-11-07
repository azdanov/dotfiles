# Workflow preferences

- Investigate first. For investigations or multi-part work, diagnose and, when useful, write an untracked plan file with settled decisions; do not edit code until explicitly asked.
- Keep fixes scoped to the affected path; prove old and new behavior with tests; avoid drive-by refactors unless asked.
- Default verification is build plus automated tests; run browser/Playwright passes only when asked, and report unrun checks.
- Git: commit on the current integration branch, stage explicit paths, re-read `git status` and `git log` before quoting hashes because parallel sessions may share a checkout, amend or bundle only unpushed commits, and never rewrite published history or force push. Push only on demand.
- Keep comments and commit bodies essential: only non-obvious mechanisms or decisions; no plan IDs, internal batch names, or long verification trails.

## Local environment

- This development environment is not Arch Linux. Package management uses Shelly; do not assume `pacman`, `makepkg`, `vercmp` or `zsh` exist. Check Shelly's available commands first. Installed package metadata lives under `/var/lib/shelly/local`.
- Arch PKGBUILDs in a repository are packaging targets and do not identify the host distribution.
