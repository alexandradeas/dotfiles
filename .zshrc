export ZSH=~/.oh-my-zsh

if [ -d "$HOME/.local/bin" ]; then
  PATH=$PATH:$HOME/.local/bin
fi

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

source $ZSH/oh-my-zsh.sh

plugins=(
  aws
  colorize
  command-not-found
  common-aliases
  docker
  git
  git-extras
  gitfast
  git-flow
  github
  gitignore
  kubectl
  node
  npm
  npx
  ubuntu
  yarn
)

# Compilation flags
export ARCHFLAGS="-arch x86_64"

alias dotfiles="vi ~/dotfiles"
alias irc="irssi"

function makeDirectoryAndEnter () {
  mkdir $1
  cd $1
}

alias update_commit_time='GIT_COMMITTER_DATE="`date`" git commit --amend --date "`date`"'

alias re-source="source ~/.zshrc"
alias t="tree -L 1"
alias vimrc="vi ~/.config/nvim/init.vim"
alias zshrc="vi ~/.zshrc"
alias wmrc="vi ~/.config/i3"

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'
export XLIB_SKIP_ARGB_VISUALS=1
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi
# source <(aws-okta completion zsh)
function kubeshell() {
  kubectl exec -it $1 -- sh
}
export PATH=/home/alexandra/.cache/rebar3/bin:$PATH
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export NVM_DIR="$HOME/.config"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export AWS_OKTA_BACKEND=secret-service

function aolist() { aws-okta list; }

function aoweb() { aws-okta login $1; }

function aoshell() {
  export AWS_OKTA_PROFILE=$1;
  OLDPS1=$PS1;
  export PS1="\e[0;31m${AWS_OKTA_PROFILE}\e[m \[\033]0;\w\007\]┌─[\[\e[0;36m\]0\[\e[39m\]][\[\e[0;36m\]\W\[\e[0m\]] └─▪ ";
  aws-okta exec $1 -- bash;
  PS1=$OLDPS1;
  unset AWS_OKTA_PROFILE;
}
export AWS_OKTA_BACKEND=secret-service
