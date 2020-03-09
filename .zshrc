export ZSH=~/.oh-my-zsh

ZSH_THEME="spaceship"

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  terraform     # Terraform workspace section
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  kubectl       # Kubectl context section
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_TIME_SHOW=false
SPACESHIP_USER_SHOW=always
SPACESHIP_USER_SUFFIX=""
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SHOW=always
SPACESHIP_PACKAGE_SHOW=false

SPACESHIP_KUBECTL_PREFIX="
 "
SPACESHIP_KUBECTL_SHOW=true
SPACESHIP_KUBECTL_VERSION_SHOW=false

SPACESHIP_CHAR_PREFIX="
 "
SPACESHIP_CHAR_SYMBOL=⇒
SPACESHIP_CHAR_SUFFIX=" "


if [ -f "$HOME/.zsh_aliases" ]; then
  source $HOME/.zsh_aliases
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
function assume_eks_role {
  unset AWS_SESSION_TOKEN
  AWS_REGION=eu-west-1
  # Export AWS IAM User credentials
  export AWS_ACCESS_KEY_ID=${K8S_AWS_ACCESS_KEY}
  export AWS_SECRET_ACCESS_KEY=${K8S_AWS_SECRET_KEY}
  export AWS_DEFAULT_REGION=${AWS_REGION}

  # Assume IAM Role and export credentials
  awsKeys=$(aws sts assume-role --role-arn ${K8S_AWS_IAM_ROLE_ARN} --role-session-name eks-session)
  export AWS_ACCESS_KEY_ID=$(echo $awsKeys | jq -r .Credentials.AccessKeyId)
  export AWS_SECRET_ACCESS_KEY=$(echo $awsKeys | jq -r .Credentials.SecretAccessKey)
  export AWS_SESSION_TOKEN=$(echo $awsKeys | jq -r .Credentials.SessionToken)
  
  aws eks update-kubeconfig --name ${K8S_CLUSTER_NAME}
}

function assume_eks_role_dev {
  K8S_AWS_ACCESS_KEY=changeme
  K8S_AWS_SECRET_KEY=changeme
  K8S_AWS_IAM_ROLE_ARN=changeme
  K8S_CLUSTER_NAME=ceng-eks-dev

  assume_eks_role
}

function talksport-dev {
  assume_eks_role_dev
  kubectl config set-context --current --namespace wd-talksport-dev
}

function times-dev {
  assume_eks_role_dev
  kubectl config set-context --current --namespace wd-times-radio-dev
}

function audio-platform-dev {
  assume_eks_role_dev
  kubectl config set-context --current --namespace wd-audio-platform-dev
}
