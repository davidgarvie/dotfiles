#!/bin/sh

REPO_DIR="$HOME/projects/dotfiles"
BREW_INSTALLS_FILE="$REPO_DIR/brew_bundle_dump"

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

prompt_user() {
  echo "Welcome traveler. You are about to install dotfiles which may overwrite any existing configuration files in your home directory. Please backup any important files before you begin. Are you sure you would like to continue? y/n"

  read opt

  case $opt in
    y*|Y*|"") echo "Starting installation process..." ;;
    n*|N*) echo "Skipping installation, I'll exit now."; exit 1;;
    *) echo "Invalid choice. Please run the scipt again."; return ;;
  esac
}

clone_repo() {
	echo "Cloning dotfiles repo"

	command_exists git || {
		printf "git is not installed, make sure you have installed the xcode command line tools.\n"
		exit 1
	}

  mkdir -p "$REPO_DIR"

  git clone --depth=1 git@github.com:davidgarvie/dotfiles.git "$REPO_DIR" || {
    printf "Error: git clone of configuration repo failed\n"
    exit 1
  }
  echo "Succesfully cloned repo"
}

create_symlinks() {
  echo "Creating symlinks between dotfiles folder and home"
  ln -sv "$REPO_DIR/.zshrc" ~
  echo "Succesfully created symlinks"
}

setup_brew() {
  command_exists brew || {
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  }

  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_INSECURE_REDIRECT=1
  export HOMEBREW_CASK_OPTS=--require-sha

  brew update-reset && brew update
  brew tap Homebrew/bundle
  brew bundle install --file="$BREW_INSTALLS_FILE"
  brew upgrade && brew cleanup
}

main() {
  prompt_user
  clone_repo
  create_symlinks
  setup_brew
  "$REPO_DIR/cron_jobs.sh"
}

main
