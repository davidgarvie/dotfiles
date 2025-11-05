#  Dotfiles

This repository contains my personal dotfiles, managed by [chezmoi](https://www.chezmoi.io/).

This setup should sync my shell environment across hosts and allow bootstrapping new machines. It automatically installs:
* Zsh + Oh My Zsh
* Starship Prompt
* Homebrew (Linuxbrew)
* A core set of CLI tools and applications (via `Brewfile`)

---

## Instructions

Install chezmoi binary and clone the dotfiles repo
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply davidgarvie
```

Apply to the local machine
```
chezmoi apply
```

Set zsh as the default shell
```
chsh -s $(which zsh)
```
