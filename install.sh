#!/bin/bash
# set -x
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
####################################################################
# brew specific part
####################################################################
echo "Install brew packages"
brew install tmux neovim fzf tpm fd ripgrep -y 
# Check last status code
[[ $? != 0 ]] && echo "Installation failure!" && exit 1

echo ""
####################################################################
# ZSH specific part
####################################################################
echo "Overriding and sourcing .zshenv"
echo "export ZDOTDIR=$SCRIPT_DIR" > ~/.zshenv
echo "[[ -f $SCRIPT_DIR/.zshenv ]] && source $SCRIPT_DIR/.zshenv" >> ~/.zshenv
chmod +x ~/.zshenv && . ~/.zshenv
source ~/.zshenv # Source zshenv for later usage (antidote)

echo ""
####################################################################
# TMUX specific part
####################################################################
echo "####### tmux specific #######"
echo "Install tpm"
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "tpm exists... skipping clone..."
  echo ""
fi

echo "Copying tmux config..."
mkdir -p ~/.config/tmux
cp $(pwd)/.tmux.conf ~/.config/tmux/tmux.conf

echo ""
####################################################################
# Antidote specific part
####################################################################
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote
echo ""

echo "***Finished!***"
zsh # Install zsh plugins with antidote
fast-theme base16 # Set syntax highlight
