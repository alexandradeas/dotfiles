#!/bin/bash

# Initial setup
sudo apt-get install software-properties-common python-software-properties curl build-essential cmake -y

# Add PPA's
sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt-get update

# Pac Managed installs
sudo apt-get install \
  git python3 \
  python-dev python-pip python3-dev python3-pip \
  zsh unzip xclip neovim \
  tree gnome-control-center scrot imagemagick \
  fonts-hack-ttf ruby-full blueman \
  -y

# Ack
apt-get install ack-grep
ln -s .ackrc ~/.ackrc

# SSH setup
ssh-keygen
ssh-add ~/.ssh/id_rsa

# Node
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install nodejs

# Rust
curl https://sh.rustup.rs -sSf | sh

source ~/.zshrc

# Set up nvim
pip2 install -U neovim
pip install -U neovim
sudo gem install neovim
sudo npm i -g neovim
update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ./init.vim ~/.config/nvim/init.vim

# NPM packages
npm i -g typescript

apt-get update
apt-get autoremove -y

echo "
Install is now complete, although some additional steps will needs to be taken
  - Log out and log back in to ensure all changes are applied
  - Add the SSH key to Github
  - Compile YouCompleteMe
"

