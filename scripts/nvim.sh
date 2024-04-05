#! bin/bash

#yes, duplicate curl installation if this script is run by itself
sudo apt-get install ninja-build gettext cmake unzip curl build-essential libstdc++-12-dev

git clone https://github.com/neovim/neovim.git ~/
cd ~/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
cd ~/neovim && make clean

#kickstart setup + treesitter + nodes
sudo apt install make gcc ripgrep unzip
sudo apt install npm
npm install -g tree-sitter-cli
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
sudo nvm install node

git clone git@github.com:PearMeow/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
source ~/.zshrc
