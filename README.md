#  Dotfiles

This repository contains my personal dotfiles, managed by [chezmoi](https://www.chezmoi.io/).

This setup should sync my shell environment across hosts and allow bootstrapping new machines. It automatically installs:
* Zsh + Oh My Zsh
* Starship Prompt
* Homebrew (Linuxbrew)
* A core set of CLI tools and applications (via `Brewfile`)

---

## Installation on remote hosts

Install chezmoi binary and clone the dotfiles repo
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply davidgarvie
```

## Useful commands

Fetch remote changes and apply locally
```
chezmoi update
```

Update local configuration to match the target state (does not pull changes)
```
chezmoi apply
```

