# Open tmux session on terminal startup
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux a -t default || exec tmux new -s default && exit;
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# In zsh vi(m) mode this needs to be enjected to be able to use fzf in insert mode
ZVM_INIT_MODE=sourcing

# source antidote
source ${ZDOTDIR}/.antidote/antidote.zsh

set_fast_theme() {
  if [[ "$FAST_THEME_NAME" != base16 ]]; then
    fast-theme -q base16
  fi
}

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load
autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source ${ZDOTDIR}/.p10k.zsh

# ZSH keybinding
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# source fzf
source <(fzf --zsh)

# History related settings because of tmux and my workflow
HISTFILE="$ZDOTDIR/.zsh_history"
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

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
