# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# In zsh vi(m) mode this needs to be enjected to be able to use fzf in insert mode
ZVM_INIT_MODE=sourcing

# source antidote
source ~/.antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ZSH keybinding
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

###############################################################################
# Aliases
###############################################################################
# Common Aliases
alias la="ls -lA"
alias ll="ls -l"

# Git Aliases
alias gs="git status"
alias gc="git commit"
alias gf="git fetch -p -a"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
