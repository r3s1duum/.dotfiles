#!/bin/bash
# set -x
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
####################################################################
# brew specific part
####################################################################
echo "Install brew packages"
brew install antidote tmux neovim fzf tpm fd ripgrep -y 
# Check last status code
[[ $? != 0 ]] && echo "Installation failure!" && exit 1

echo ""
####################################################################
# ZSH specific part
####################################################################
echo "Overriding and sourcing .zshenv"
echo "export ZDOTDIR=$SCRIPT_DIR" > ~/.zshenv
echo "[[ -f $SCRIPT_DIR/.zshenv ]] && $SCRIPT_DIR/.zshenv" >> ~/.zshenv
chmod +x ~/.zshenv && . ~/.zshenv

echo ""
####################################################################
# TMUX specific part
####################################################################
echo "####### tmux specific #######"
echo "Copying tmux config..."
cp $(pwd)/.tmux.conf ~/.tmux.conf

echo ""

echo "***Finished!***"
# Set syntax highlight
zsh
fast-theme base16
