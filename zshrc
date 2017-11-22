export ZSH=~/.oh-my-zsh

function zsl-line-init zsl-keymap-select {
  VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)} $(git_custom_status) $ESP1"
  zle reset-prompt
}

zle -N zsl-line-init

# Vim mode setup
bindkey -v
export KEYTIMEOUT=1


ZSH_THEME="af-magic"

CASE_SENSITIVE="true"

# ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(aws, bi, cabal, command-not-found, git, git-extras, git-flow, httpie, zsh-nvm, sudo, stack)

source $ZSH/oh-my-zsh.sh

# Compilation flags
export ARCHFLAGS="-arch x86_64"

alias dotfiles="vi ~/dotfiles"
alias irc="irssi"

function makeDirectoryAndEnter () {
  mkdir $1
  cd $1
}

# alias emacs="emacs --no-window-system"
alias vi='nvim' 
alias vim="nvim"
alias update_commit_time='GIT_COMMITTER_DATE="`date`" git commit --amend --date "`date`"'

alias re-source="source ~/.zshrc"
alias t="tree -L 1"

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'
export XLIB_SKIP_ARGB_VISUALS=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm

export PATH=$PATH:$HOME/bin:/usr/local/bin:~/.cabal/bin:~/.local/go/bin:~/.local/bin/scala/bin:~/neovim/bin
export GOPATH=$HOME/.local/go
