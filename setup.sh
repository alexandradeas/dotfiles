#!/bin/bash

# Initial setup
sudo apt-get install software-properties-common python-software-properties curl build-essential cmake -y

# i3 depdencies
sudo apt-get install i3lock i3blocks compton feh -y

# Add PPA's
sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt-get update

# Pac Managed installs
sudo apt-get install \
  git python3 \
  python-dev python-pip python3-dev python3-pip \
  zsh openjdk-9-jdk unzip xclip neovim \
  tree gnome-control-center scrot imagemagick \
  fonts-hack-ttf ruby-full \
  -y

# Debian files
curl -LOk https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.de://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb 
sudo dpkg -i playerctl-0.5.0_amd64.deb
rm playerctl-0.5.0_amd64.deb

# Haskell install
sudo add-apt-repository -y ppa:hvr/ghc
sudo apt-get update
sudo apt-get install -y cabal-install-1.22 ghc-7.10.3

# Haskell setup
cabal update
cabal install ghc-mod hoogle hlint pointfree

# Ack
sudo apt-get install ack-grep
ln -s .ackrc ~/.ackrc

# Github setup
ssh-keygen
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

source ~/.zshrc

# Set up nvim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ./init.vim ~/.config/nvim/init.vim
pip2 install neovim
pip install neovim
sudo gem install neovim

# Fonts
mkdir ~/.fonts

## San Francisco Font
curl -LOk "https://github.com/supermarin/YosemiteSanFranciscoFont/archive/master.zip"
unzip master.zip -d YosemiteSanFranciscoFont
mv ./YosemiteSanFranciscoFont/*.ttf ~/.fonts/
rm -rf YosemiteSanFranciscoFont master.zip

## Font Awesome
curl -LOk "http://fontawesome.io/assets/font-awesome-4.7.0.zip"
unzip font-awesome-4.7.0.zip -d font-awesome
mv font-awesome/font-awesome-4.7.0/fonts/*.ttf ~/.fonts/
rm -rf font-awesome font-awesome-4.7.0.zip

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
sudo npm i -g typescript bower

# i3
ln -s ~/dotfiles/i3/* ~/.config/i3/



sudo apt-get update
sudo apt-get autoremove -y

echo "
Install is now complete, although some additional steps will needs to be taken
  - Log out and log back in to ensure all changes are applied
  - Add the SSH key to Github
  - Compile YouCompleteMe
"

