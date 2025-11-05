#!/bin/sh
set -e

echo "Installing Zsh plugins"

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_DIR="$ZSH_CUSTOM/plugins"

echo "Installing Zsh plugins to $PLUGINS_DIR..."

# zsh-autosuggestions
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
  echo "Cloning zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGINS_DIR/zsh-autosuggestions"
else
  echo "zsh-autosuggestions already installed."
fi

# zsh-syntax-highlighting
if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
  echo "Cloning zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR/zsh-syntax-highlighting"
else
  echo "zsh-syntax-highlighting already installed."
fi

# zsh-fzf-history-search
if [ ! -d "$PLUGINS_DIR/zsh-fzf-history-search" ]; then
  echo "Cloning zsh-fzf-history-search..."
  git clone https://github.com/joshskidmore/zsh-fzf-history-search.git "$PLUGINS_DIR/zsh-fzf-history-search"
else
  echo "zsh-fzf-history-search already installed."
fi

echo "Shell tool installation complete."
