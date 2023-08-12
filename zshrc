# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

function reload() {
	source ~/.zshrc
}

# Opens nvim in the specified directory
# $1 is required and should point to a directory
# $2 is optional and specifies the file to open initially
function workspace() {
	readonly dir=${1:?"You must specify a directory for the workspace"}
	readonly file=$2
	local prev_dir=$PWD
	cd $dir
	nvim $file
	cd $prev_dir
}

function zshrc() {
	workspace $HOME $HOME/.zshrc
}

function vimrc() {
	workspace ~/.config/nvim init.vim
}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

plugins=(
	archlinux
	asdf
  aws
	flutter
	fzf
	git
	golang
	node
	npm
	python
	pip
	ruby
	tmux
)

MODE_CURSOR_VIINS="#00ff00 blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"

source $ZSH/oh-my-zsh.sh

set -o vi
set show-mode-in-prompt on
set vi-cmd-mode-string "\1\e[2 q\2"
set vi-ins-mode-string "\1\e[6 q\2"

export EDITOR=nvim
alias vi=nvim
alias vim=nvim

export ARCHFLAGS="-arch x86_64"

alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if [ -d "/usr/local/go" ]; then
	export GOPATH="$HOME"
	export GOBIN="$GOPATH/bin"
	export PATH="/usr/local/go/bin:$GOBIN:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm/bin:$PATH"

if [ -d "/opt/asdf-vm" ]; then
	. /opt/asdf-vm/asdf.sh
fi

if ! [ -x "$(which google-chrome)" ]; then
	CHROME_EXECUTABLE=$(which chromium)
fi

if [ -d "$HOME/.pub-cache" ]; then
	export PATH="$PATH":"$HOME/.pub-cache/bin"
fi

# Configure bitwarden cli completions
if [ -x "$(which bw)" ]; then
	eval "$(bw completion --shell zsh); compdef _bw bw;"
fi

# opencv emits warning logs by default, set it to error instead
export OPENCV_LOG_LEVEL=ERROR

fpath=(${ASDF_DIR}/completions $fpath)

eval "$(direnv hook zsh)"

