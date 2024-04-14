#! /bin/bash

#get font - for windows terminal gotta change it manually
sudo cp ~/settings/fonts/DejaVuSansMNerdFontMono-Regular.ttf /usr/share/fonts/
sudo fc-cache -f -v

#zsh
sudo pacman -S zsh fzf curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

touch ~/.zshrc
cp ~/settings/.zshrc ~/.zshrc
