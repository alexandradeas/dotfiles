#!/bin/bash

# Initial setup
sudo apt-get install -y \
	software-properties-common \
	python-software-properties \
	curl \
	build-essential \
	cmake \
	python-pip \
	python3-pip \
	tree \
	fonts-hack-ttf \
	ruby-full \
	ack-grep \
        zsh


# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Neovim

# Ack
ln -s "$(pwd)/.ackrc" "$HOME/.ackrc"

# NVM & Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# Rust
curl https://sh.rustup.rs -sSf | sh

# Dart & Flutter
cd $HOME
curl https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_1.17.3-stable.tar.xz
tar xf flutter_linux_1.17.3-stable.tar.xz
cd -

ln -s "$(pwd)/.zshrc" "$HOME/.zshrc"
ls -s "$(pwd)/.zsh_aliases" "$HOME/.zsh_aliases"
source "$HOME/.zshrc"

nvm install --lts

# Set up nvim
pip2 install -U neovim
pip3 install -U neovim
sudo gem install neovim
npm i -g neovim
curl -fLo "$HOME/.var/app/io.neovim.nvim/data/nvim/site/autoload/plug.vim" \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s "$(pwd)./init.vim" "$HOME/.var/app/io.neovim/nvim/config/init.vim"

# NPM packages
npm i -g typescript

sudo apt-get update
sudo apt-get autoremove -y

echo "
Install is now complete, although some additional steps will needs to be taken
  - Log out and log back in to ensure all changes are applied
"

