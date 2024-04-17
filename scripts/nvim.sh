#! /bin/bash

#yes, duplicate curl installation if this script is run by itself
sudo pacman -S ninja-build gettext cmake unzip curl build-essential libstdc++-12-dev

cd ~/
git clone https://github.com/neovim/neovim.git
cd ~/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

#kickstart setup + treesitter + nodes
sudo pacman -S make gcc ripgrep unzip
git clone git@github.com:PearMeow/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
