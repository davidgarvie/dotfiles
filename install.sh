#!/bin/sh

REPO_DIR="$HOME/projects/dotfiles2"

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

main() {
  prompt_user
  clone_repo
}

main
