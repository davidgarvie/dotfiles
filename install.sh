#!/bin/sh

REPO_DIR="$HOME/projects/dotfiles"
BREW_INSTALLS_FILE="$REPO_DIR/brew_bundle_dump"
GIT_URL="git@github.com:davidgarvie/dotfiles.git"

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

  

  if [ ! -d "$REPO_DIR" ] ; then
    mkdir -p "$REPO_DIR"
    git clone --depth=1 $GIT_URL "$REPO_DIR" || {
    printf "Error: git clone of configuration repo failed\n"
    exit 1
  }
  else
    cd "$REPO_DIR"
    git pull $GIT_URL
  fi

  echo "Succesfully cloned repo"
}

create_symlinks() {
  echo "Creating symlinks between dotfiles folder and home"
  ln -sfn "$REPO_DIR/.zshrc" ~
  ln -sfn "$REPO_DIR/.p10k.zsh" ~
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

setup_terminal() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
  sudo sh -c "echo $(which zsh) >> /etc/shells"
  chsh -s $(which zsh)
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/themes/powerlevel10k
}

main() {
  prompt_user
  clone_repo
  create_symlinks
  setup_brew
  setup_terminal
  "$REPO_DIR/cron_jobs.sh"
  echo "Finished setting up. You will need to open a new terminal to use oh-my-zsh."
}

main
