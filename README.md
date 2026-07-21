# dotfiles-cyril

Managed with [chezmoi](https://www.chezmoi.io/).

## Quick start

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply cyrilcros/dotfiles-cyril
```

During init you'll be prompted to choose your git profile (`embl` or `personal`).

## What's included

| Tool | Config |
|------|--------|
| bash | `.bashrc_additions` (sourced from `.bashrc`) |
| vim | `.vimrc` (vim-plug based) |
| tmux | `.tmux.conf` (tpm plugins) |
| git | `.gitconfig` (templated: EMBL or personal) |
| conda | `.condarc` + auto-installer |
| lf | `~/.config/lf/lfrc` |
| opencode | Full config — models, MCP servers, skills, theme |

## Full machine setup

### 1. Core dotfiles

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply cyrilcros/dotfiles-cyril
```

### 2. CLI tools

```bash
# GitHub CLI
(type -p wget >/dev/null || sudo apt install wget -y) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y

# GitLab CLI
sudo apt install glab -y
# or: snap install glab

# Seqera CLI (for Seqera Platform / Nextflow Tower)
curl -fsSL https://github.com/seqeralabs/tower-cli/releases/latest/download/tw-linux-x86_64 -o ~/.local/bin/tw \
  && chmod +x ~/.local/bin/tw
```

### 3. OpenCode

```bash
# Install binary
curl -fsSL https://opencode.ai/install.sh | sh
# → installs to ~/.opencode/bin/opencode

# Create private credential files (NOT in version control)
cat > ~/.opencode_env << 'EOF'
export CONTEXT7_API_KEY=<your-context7-key>
EOF

# HPC cluster (if applicable)
cat > ~/.hpc_config << 'EOF'
HPC_USER=<your-user>
HPC_GROUP=<your-group>
HPC_DATA_DIR=/g/<group>/<user>
HPC_SSH_KEY=~/.ssh/id_rsa_gitlab
EOF

# Launch — plugins and skills auto-install on first run
opencode
```

### 4. Authenticate CLIs

```bash
gh auth login
glab auth login
tw login    # Seqera — opens browser for token
```

## Private files (not in git)

These files are chezmoi-managed with `private_` prefix (0600 permissions) but
gitignored. On a new machine they must be created manually.

### `~/.opencode_env`

```bash
cat > ~/.opencode_env << 'EOF'
export CONTEXT7_API_KEY=<key from context7.com>
EOF
```

### `~/.hpc_config`

```bash
cat > ~/.hpc_config << 'EOF'
HPC_USER=<cluster username>
HPC_GROUP=<cluster group>
HPC_DATA_DIR=/g/$GROUP/$USER
HPC_SSH_KEY=~/.ssh/id_rsa_gitlab
EOF
```

### `~/.hpc_reference`

Cluster hostnames, service URLs, SSH fingerprints, and filesystem paths used by
the embl-hpc skill. EMBL-internal — copy from an existing machine or the
cluster wiki.

```bash
cat > ~/.hpc_reference << 'EOF'
LOGIN_NODES=login1.cluster.embl.de login2.cluster.embl.de
SLURM_REST_API=https://slurmrest.cluster.embl.de
JUPYTERHUB=https://jupyterhub.embl.de
INTERNAL_GITLAB=https://git.embl.de
REGISTRY_MIRROR=regmirror.embl.de
# ... (copy full file from an existing machine)
EOF
```

## What's managed by chezmoi

| Category | Files |
|----------|-------|
| Shell | `dot_bashrc_additions` |
| Editor | `dot_vimrc` |
| Terminal | `dot_tmux.conf` |
| Git | `dot_gitconfig.tmpl` (profile-based) |
| Conda | `dot_condarc` |
| File manager | `dot_config/lf/lfrc` |
| OpenCode config | `opencode.jsonc`, `oh-my-opencode-slim.json`, `AGENTS.md`, `tui.json` |
| OpenCode skills | `co-scientist`, `embl-hpc` (with wiki references) |
| Scripts | `run_once_append-bashrc.sh`, `run_once_install-conda.sh` |
