#!/bin/sh

BREW_INSTALLS_FILE="$REPO_DIR/brew_bundle_dump"
REPO_DIR="$HOME/projects/dotfiles"
VSCODE_EXTENSIONS_FILE="$REPO_DIR/vscode/extensions"

cat $VSCODE_EXTENSIONS_FILE | xargs /usr/local/bin/code --install-extension

brew bundle install --file="$BREW_INSTALLS_FILE"