#!/bin/sh

set -e

echo "Starting bootstrapping process..."

# We need git, curl, and zsh for Oh My Zsh, Brew, and the shell itself.
# build-essential is required by Homebrew.
if command -v apt &> /dev/null; then
  echo "Found 'apt', installing system dependencies..."
  sudo apt-get update
  sudo apt-get install -y zsh git curl build-essential fzf
else
  echo "Warning: 'apt' not found. Skipping system dependency installation."
  echo "Please ensure 'zsh', 'git', and 'curl' are installed manually."
fi

# Install ohmyzsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is already installed. Skipping installation"
else
  echo "Oh My Zsh not found. Installing..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Checking if homebrew installed..."

if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  echo "Homebrew is already installed. Skipping installation"
else
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install packages
echo "Installing packages from Brewfile..."
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew bundle install --file=~/Brewfile

echo "Bootstrapping complete."
echo "---"
echo "To make Zsh your default shell, run this command and then log out:"
echo "chsh -s $(which zsh)"
