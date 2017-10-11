#!/bin/bash

# Initial setup
apt-get install software-properties-common python-software-properties curl build-essential cmake -y

# Add PPA's
add-apt-repository ppa:openjdk-r/ppa -y
add-apt-repository ppa:neovim-ppa/stable -y
apt-get update

# Pac Managed installs
apt-get install \
  git python3 \
  python-dev python-pip python3-dev python3-pip \
  zsh unzip xclip neovim \
  tree gnome-control-center scrot imagemagick \
  fonts-hack-ttf ruby-full blueman \
  -y

# Haskell install
add-apt-repository -y ppa:hvr/ghc
apt-get update
apt-get install -y cabal-install-1.22 ghc-7.10.3

# Haskell setup
cabal update
cabal install ghc-mod hoogle hlint pointfree

# Ack
apt-get install ack-grep
ln -s .ackrc ~/.ackrc

# Github setup
ssh-keygen
ssh-add ~/.ssh/id_rsa

# Node
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install nodejs

# Rust
curl https://sh.rustup.rs -sSf | sh

source ~/.zshrc

# Set up nvim
pip2 install neovim
pip install neovim
gem install neovim
update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ./init.vim ~/.config/nvim/init.vim

# Stack packages
stack setup
stack update

## Purescript
stack unpack purescript
cd purescript-*
stack install --flag purescript:RELEASE
cd ..
rm -rf purescript-*

# NPM packages
npm i -g typescript bower

apt-get update
apt-get autoremove -y

echo "
Install is now complete, although some additional steps will needs to be taken
  - Log out and log back in to ensure all changes are applied
  - Add the SSH key to Github
  - Compile YouCompleteMe
"

