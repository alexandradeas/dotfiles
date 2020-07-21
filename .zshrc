ZSH=$HOME/.oh-my-zsh
OS=$(uname)
ZSH=$HOME/.oh-my-zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Mac specific config
if [ OS = "Darwin" ]; then
  source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

if [ -s "$HOME/.zsh_aliases" ]; then
  source $HOME/.zsh_aliases
fi

if [ -s "$HOME/.zsh_profile" ]; then
  source $HOME/.zsh_profile
fi

if [ -s "$HOME/.local/bin" ]; then
  PATH=$PATH:$HOME/.local/bin
fi

if [ -s "$HOME/.cargo/bin" ]; then
  PATH=$PATH:$HOME/.cargo/bin
fi

if [ -s "$HOME/.local/flutter" ]; then
  PATH=$PATH:$HOME/.local/flutter/bin
elif [ -s "/usr/local/flutter" ]; then
  PATH=$PATH:/usr/local/flutter/bin
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

plugins+=(
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
  zsh-completions
)

if [ command -v flatpak > /dev/null 2>&1 ]; then
  if [ ! -s $HOME/.oh-my-zsh/custom/plugins/flatpak ]; then
    git clone https://github.com/bilelmoussaoui/flatpak-zsh-completion $HOME/.oh-my-zsh/custom/plugins/flatpak
  fi
  plugins+=(flatpak)
fi

unset KUBECONFIG

if [ -s "$HOME/.kube/configs" ]; then
  KUBE_CONFIGS_PATH=$HOME/.kube/configs
for FILE in $(ls -F $HOME/.kube/configs); do
  FILE_PATH="$KUBE_CONFIGS_PATH/$FILE"
  if [ -z ${KUBECONFIG} ]; then
    export KUBECONFIG=$FILE_PATH
  else
    export KUBECONFIG=$KUBECONFIG:$FILE_PATH
  fi
done

fi

autoload -U compinit && compinit

# Compilation flags
export ARCHFLAGS="-arch x86_64"

function makeDirectoryAndEnter () {
  mkdir $1
  cd $1
}

export XLIB_SKIP_ARGB_VISUALS=1
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

if type kubectl > /dev/null ; then
  source <(kubectl completion zsh)

  function kubeshell() {
    kubectl exec -it $1 -- sh
  }
fi

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ -s "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  \. "$NVM_DIR/nvm.sh"  # This loads nvm
  \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# opam configuration
test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if [ -d "$HOME/.asdf" ]; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

if [ -s "$HOME/.yarn" ]; then
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

if [ -s "$HOME/.krew" ]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi
