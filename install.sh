#!/bin/bash
# set -x

####################################################################
# ZSH specific part
####################################################################
check_zsh=$(which zsh)

if [[ "$check_zsh" == *"zsh"* ]]; then
  echo "ZSH is already installed."
else
  echo "ZSH is not installed. Please install ZSH and rerun the script."
  exit 1
fi

if [[ -d ~/.antidote ]]; then
  echo "Antidote is already installed."
else
  echo "Installing antidote..."
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi

echo "Copying .zsh_plugins.txt..."
cp $(pwd)/.zsh_plugins.txt ~/.zsh_plugins.txt

echo "Copying .zshrc..."
cp $(pwd)/.zshrc ~/.zshrc

echo "Copying .zshenv..."
cp $(pwd)/.zshenv ~/.zshenv

echo "Copying .zprofile..."
cp $(pwd)/.zprofile ~/.zprofile

echo "Copying .p10k.zsh..."
cp $(pwd)/.p10k.zsh ~/.p10k.zsh

####################################################################
# TMUX specific part
####################################################################
echo "Copying tmux config..."
cp $(pwd)/.tmux.conf ~/.tmux.conf

if [[ -d ~/.tmux/plugins/tpm ]]; then
  echo "Tmux Plugin Manager is already installed."
else
  echo "Installing Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Set syntax highlight
zsh
fast-theme base16
