export ZSH=~/.oh-my-zsh

ZSH_THEME="af-magic"

CASE_SENSITIVE="true"

# ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(aws, bi, cabal, command-not-found, git, get-extras, get-flow, httpie, zsh-nvm, sudo, stack)

source $ZSH/oh-my-zsh.sh

# Compilation flags
export ARCHFLAGS="-arch x86_64"

alias zshrc='nvim ~/.zshrc'
alias vimrc="nvim ~/.config/nvim/init.vim"
alias ackrc="nvim ~/.ackrc"
alias irc="irssi"

alias emacs="emacs --no-window-system"
alias vi='nvim'
alias vim="nvim"
alias update_commit_time='GIT_COMMITTER_DATE="`date`" git commit --amend --date "`date`"'

alias re-source="source ~/.zshrc"
alias t="tree -L 1"

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'
export XLIB_SKIP_ARGB_VISUALS=1


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH=$PATH:$HOME/bin:/usr/local/bin:~/.cabal/bin:/usr/local/go/bin:~/.local/bin/scala/bin:/usr/local/opt/node@6/bin

