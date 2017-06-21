#!/bin/bash

# Initial setup
sudo apt-get install software-properties-common python-software-properties curl build-essential -y

# Add PPA's
sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt-get update

# Pac Managed installs
sudo apt-get install \
  git haskell-platform python3 \
  python-dev python-pip python3-dev python3-pip \
  zsh openjdk-9-jdk unzip xclip neovim \
  -y

# Github setup
ssh-keygen -t rsa -b 4096 -C "alex.deas@hypatia.co.uk"
ssh-add ~/.ssh/id_rsa

# Node
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install nodejs

# zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Mash
curl -o ~/Downloads/mash/deb https://github.com/mdr/mash/releases/download/v0.0.5/mash_0.0.5_all.deb
sudo dpkg -i ~/Downloads/mash.deb

# Rust
curl https://sh.rustup.rs -sSf | sh

# Get some interesting git repos
mkdir ~/Projects
git clone https://www.github.com/purescript/purescript ~/Projects/purescript
git clone https://www.github.com/purescript/psc-package ~/Projects/psc-package
git clone https://www.github.com/puresciprt/purescript-prelude ~/purescript-prelude

# Set up nvim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ./init.vim ~/.local/share/nvim

# Ack
sudo apt-get install ack-grep
ln -s .ackrc ~/.ackrc

echo "
Install is now complete, although some additional steps will needs to be taken
  - Log out and log back in again to swap the terminal to zsh
  - Add the SSH key to Github"

