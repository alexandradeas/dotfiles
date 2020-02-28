export ZSH=~/.oh-my-zsh

if [ -f "$HOME/.bash_aliases" ]; then
  source $HOME/.bash_aliases
fi

if [ -f "$HOME/.zsh_profile" ]; then
  source $HOME/.zsh_profile
fi

if [ -f "$HOME/news/profile" ]; then
  source $HOME/news/.profile
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH=$PATH:$HOME/.local/bin
fi

if [ -d "$HOME/.cargo/bin" ]; then
  PATH=$PATH:$HOME/.cargo/bin
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


ZSH_THEME="bira"

CASE_SENSITIVE="true"

# ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh

fpath+=($ZSH/plugins/docker)

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
  fedora
  yarn
  zsh-completions
)

unset KUBECONFIG

KUBE_CONFIGS_PATH=$HOME/.kube/configs

for FILE in $(ls -F $HOME/.kube/configs); do
  FILE_PATH="$KUBE_CONFIGS_PATH/$FILE"
  if [ -z ${KUBECONFIG} ]; then
    export KUBECONFIG=$FILE_PATH
  else
    export KUBECONFIG=$KUBECONFIG:$FILE_PATH
  fi
done

autoload -U compinit && compinit

# Compilation flags
export ARCHFLAGS="-arch x86_64"

function makeDirectoryAndEnter () {
  mkdir $1
  cd $1
}

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'
export XLIB_SKIP_ARGB_VISUALS=1
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

if type aws > /dev/null && type aws-okta > /dev/null ; then
  source <(aws-okta completion zsh)
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
fi

if type kubectl > /dev/null ; then
  source <(kubectl completion zsh)

  function kubeshell() {
    kubectl exec -it $1 -- sh
  }
fi

if [ -d "$HOME/.cache/rebar3/bin" ]; then
  export PATH=$PATH:$HOME/.cache/rebar3/bin
fi

if [ -d "/snap/bin" ]; then
  export PATH=$PATH:/snap/bin
fi

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export NVM_DIR="$HOME/.config"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opam configuration
test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if [ -d "$HOME/.asdf" ]; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.rakudobrew/bin:$PATH"

function aolist() { aws-okta list; }

function aoconsole() { aws-okta login $1; }

function aoshell() {
  export AWS_OKTA_PROFILE=$1;
  OLDPS1=$PS1;
  export PS1="\e[0;31m${AWS_OKTA_PROFILE}\e[m \[\033]0;\w\007\]┌─[\[\e[0;36m\]0\[\e[39m\]][\[\e[0;36m\]\W\[\e[0m\]] └─▪ ";
  aws-okta exec $1 -- bash;
  PS1=$OLDPS1;
  unset AWS_OKTA_PROFILE;
}
eval "$(/home/alexandra/.rakudobrew/bin/rakudobrew init Zsh)"
