#!/bin/bash
# set -x

####################################################################
# ZSH specific part
####################################################################
echo "####### ZSH specific #######"
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
  git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote 2 /dev/null &>1
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

echo ""
####################################################################
# TMUX specific part
####################################################################
echo "####### tmux specific #######"
echo "Copying tmux config..."
cp $(pwd)/.tmux.conf ~/.tmux.conf

if [[ -d ~/.tmux/plugins/tpm ]]; then
  echo "Tmux Plugin Manager is already installed."
else
  echo "Installing Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2 /dev/null &>1
fi

echo ""
####################################################################
# fzf specific part
####################################################################
echo "####### fzf specific #######"
if [[ -d ~/.fzf ]]; then
  echo "fzf is already installed"
else
  ~/.fzf/install --all --no-bash 2 /dev/null &>1 # Only for zsh is being used
fi

echo ""
####################################################################
# nvim specific part
####################################################################
echo "####### nvim specific #######"
if [[ -d ~/.config/nvim ]]; then
  echo "nvim config is already installed"
else
  git clone https://github.com/LazyVim/starter ~/.config/nvim 2 /dev/null &>1
  rm -rf ~/.config/nvim/.git # Its possible to track the own config. But I like the lazyVim
fi

echo "Copying LazyVim configs..."
mkdir -p ~/.config/nvim/lua/plugins
cp $(pwd)/colorscheme.lua ~/.config/nvim/lua/plugins/colorscheme.lua

echo ""
####################################################################
# Alacritty specific part
####################################################################
echo "####### Alacritty specific #######"
echo "Copying Alacritty config..."
mkdir -p ~/.config/alacritty
cp $(pwd)/alactritty.toml ~/.config/alacritty/alacritty.toml

echo ""
####################################################################
# MacOS specific part
####################################################################
echo "####### MacOS specific #######"
if [[ $(uname) == 'Darwin' ]]; then
  echo "Copy KeyBindings..."
  mkdir -p ~/Library/KeyBindings/
  cp $(pwd)/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
fi

echo ""

echo "***Finished!***"
# Set syntax highlight
zsh
fast-theme base16
