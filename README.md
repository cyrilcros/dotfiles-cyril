# dotfiles-cyril

Managed with [chezmoi](https://www.chezmoi.io/).

## Quick start

```bash
chezmoi init --apply cyrilcros/dotfiles-cyril
```

During init you'll be prompted to choose your git profile (`embl` or `personal`).

## Manual install

```bash
# Install chezmoi
sh -c "$(curl -fsLS https://get.chezmoi.io)"

# Clone and apply
chezmoi init --apply git@github.com:cyrilcros/dotfiles-cyril.git
```

## What's included

| Tool | Config |
|------|--------|
| bash | `.bashrc_additions` (sourced from `.bashrc`) |
| vim | `.vimrc` (vim-plug based) |
| tmux | `.tmux.conf` (tpm plugins) |
| git | `.gitconfig` (templated: EMBL or personal) |
| conda | `.condarc` + auto-installer |
| lf | `~/.config/lf/lfrc` |
