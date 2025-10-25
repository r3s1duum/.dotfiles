#!/bin/bash
# set -x

check_zsh=$(which zsh)

if [[ "$check_zsh" == *"zsh"* ]]; then
    echo "ZSH is installed."
else
    echo "ZSH is not installed. Please install ZSH and rerun the script."
    exit 1
fi

if [[ -z ~/.oh-my-zsh ]]; then
    echo "Oh My Zsh is not installed. Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

echo "Install tmux config..."
ln -s $(pwd)/.tmux.conf ~/.tmux.conf

echo "Install zsh config..."
ln -s $(pwd)/.zshrc ~/.zshrc

echo "Install .zshenv config..."
ln -s $(pwd)/.zshenv ~/.zshenv

echo "Install .zprofile config..."
ln -s $(pwd)/.zprofile ~/.zprofile

echo "Install tmux plugin manager..."
if [[ -d ~/.tmux/plugins/tpm ]]; then
    echo "Tmux Plugin Manager is already installed."
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "Tmux Plugin Manager installed."
fi



