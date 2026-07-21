<!-- context7 -->
Use Context7 MCP to fetch current documentation whenever the user asks about a library, framework, SDK, API, CLI tool, or cloud service — even well-known ones like React, Next.js, Prisma, Express, Tailwind, Django, or Spring Boot. This includes API syntax, configuration, version migration, library-specific debugging, setup instructions, and CLI tool usage. Use even when you think you know the answer — your training data may not reflect recent changes. Prefer this over web search for library docs.

Do not use for: refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.

## Steps

1. Always start with `resolve-library-id` using the library name and the user's question, unless the user provides an exact library ID in `/org/project` format
2. Pick the best match (ID format: `/org/project`) by: exact name match, description relevance, code snippet count, source reputation (High/Medium preferred), and benchmark score (higher is better). If results don't look right, try alternate names or queries (e.g., "next.js" not "nextjs", or rephrase the question). Use version-specific IDs when the user mentions a version
3. `query-docs` with the selected library ID and the user's full question (not single words), scoped to a single concept. If the question spans multiple distinct concepts (e.g. routing and auth and caching), make a separate `query-docs` call per concept with the same library ID, unless the question is about how the concepts interact — combined queries dilute ranking and return shallow results for each topic
4. Answer using the fetched docs
<!-- context7 -->

## Chezmoi Dotfiles Workflow

This machine's dotfiles are managed by chezmoi (source: `~/.local/share/chezmoi`,
structured under a `home/` subdirectory per `.chezmoiroot`).

### Files That Trigger This Workflow

Any edit to these paths means the file is chezmoi-managed — follow the workflow below:
- `~/.bashrc_additions`, `~/.vimrc`, `~/.tmux.conf`, `~/.condarc`, `~/.gitconfig`
- `~/.config/lf/**`
- `~/.config/opencode/**` (config, models, AGENTS.md, tui, skills)
- `~/.opencode/**` (custom skills, references, scripts)
- `~/.opencode_env`, `~/.hpc_config`, `~/.hpc_reference` (private files)

### Before Editing

1. Run `chezmoi diff`. If remote changes exist, run `chezmoi update` first.
2. If you have uncommitted local changes, warn the user before overwriting.

### Editing

- Edit the source file: `~/.local/share/chezmoi/home/dot_file`
- Or use `chezmoi edit ~/.file` to open the source in `$EDITOR`.
- Templates: `chezmoi cd && $EDITOR home/dot_gitconfig.tmpl`

### After Editing

- Run `chezmoi apply` — deploys to `$HOME` and auto-commits.
- Remind the user to push: `chezmoi git push` or `git push` from source dir.

### New Files

- `chezmoi add ~/.newfile` to start tracking.
- For secrets: `private_` prefix + add pattern to repo `.gitignore`.

### Private Files (Recreated Per Machine)

These are chezmoi-managed with `private_` prefix (0600) but gitignored.
On a new machine they must be recreated — ask the user for each value.

**~/.opencode_env** (sourced by `~/.bashrc_additions`):
```
export CONTEXT7_API_KEY=<key from context7.com>
```

**~/.hpc_config** (sourced by embl-hpc skill):
```
HPC_USER=<cluster username>
HPC_GROUP=<cluster group>
HPC_DATA_DIR=/g/$GROUP/$USER
HPC_SSH_KEY=~/.ssh/id_rsa_gitlab
```

**~/.hpc_reference** (sourced by embl-hpc skill):
Contains cluster hostnames, service URLs, SSH fingerprints, and filesystem
paths. EMBL-internal — copy from an existing machine or the cluster wiki.
