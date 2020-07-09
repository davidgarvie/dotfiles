# !/bin/bash

REPO_DIR="$HOME/projects/dotfiles"
BREW_INSTALLS_FILE="$REPO_DIR/brew_bundle_dump"
THIS_SCRIPT_FULL_PATH="$REPO_DIR/$(basename -- "$0")"
VSCODE_EXTENSIONS_FILE="$REPO_DIR/vscode/extensions"

/usr/local/bin/brew bundle dump --force --file="$REPO_DIR/brew_bundle_dump"
/usr/local/bin/code --list-extensions > "$REPO_DIR/vscode/extensions"

cd "$REPO_DIR" || exit
if ! git diff --quiet HEAD || git status --short; then
  git add --all
  git commit -m "updating dotfiles on $(date -u)"
  git pull
  git push origin master
fi

cat $VSCODE_EXTENSIONS_FILE | xargs /usr/local/bin/code --install-extension

brew bundle install --file="$BREW_INSTALLS_FILE"

# Make this script call itself hourly from the crontab, if it isn't already.
if ! crontab -l | grep "$THIS_SCRIPT_FULL_PATH"; then
  (crontab -l ; echo "0 * * * * $THIS_SCRIPT_FULL_PATH > /dev/null 2>&1") | sort - | uniq - | crontab - 2>&1
fi