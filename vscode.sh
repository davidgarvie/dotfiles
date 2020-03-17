#!/bin/sh

REPO_DIR="$HOME/projects/dotfiles"
VSCODE_EXTENSIONS_FILE="$REPO_DIR/vscode/extensions"

cat $VSCODE_EXTENSIONS_FILE | xargs /usr/local/bin/code --install-extension