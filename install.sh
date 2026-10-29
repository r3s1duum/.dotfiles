#!/bin/bash
# set -x
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
####################################################################
# Local functions
####################################################################
link() {
  mkdir -p "$(dirname "$2")"
  ln -sfn "$1" "$2"
  echo "Linked $2 -> $1"
}
####################################################################
# brew specific part
####################################################################
echo "Install brew packages"
brew install tmux neovim fzf fd ripgrep -y
# Check last status code
[[ $? != 0 ]] && echo "Installation failure!" && exit 1

echo ""
####################################################################
# ZSH specific part
####################################################################
echo "Overriding and sourcing .zshenv"
echo "export ZDOTDIR=\"$SCRIPT_DIR\"" > "$HOME/.zshenv"
echo '[[ -f "$ZDOTDIR/.zshenv" ]] && source "$ZDOTDIR/.zshenv"' >> "$HOME/.zshenv"
chmod +x "$HOME/.zshenv" && . "$HOME/.zshenv"
source "$HOME/.zshenv" # Source zshenv for later usage (antidote)

echo ""
####################################################################
# TMUX specific part
####################################################################
echo "####### tmux specific #######"
if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
  mkdir -p "$HOME/.config/tmux/plugins"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
else
  echo "Skipping, tpm already exists"
fi

echo "Linking tmux config..."
link "$SCRIPT_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

echo ""
####################################################################
# NeoVim specific part
####################################################################
echo "####### nvim specific #######"
echo "Linking nvim config..."
link "$SCRIPT_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"

echo ""
####################################################################
# Antidote specific part
####################################################################
echo "####### antidote specific #######"
if [[ ! -d "$SCRIPT_DIR/.antidote" ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git "${ZDOTDIR:-$HOME}/.antidote"
else
  echo "Skipping, antidote already exists"
fi
echo ""

echo "***Finished!***"
zsh # Install zsh plugins with antidote
fast-theme base16 # Set syntax highlight
