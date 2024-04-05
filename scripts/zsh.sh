#! bin/bash

#get font - for windows terminal gotta change it manually
sudo cp ~/settings/fonts/DejaVuSansMNerdFontMono-Regular.ttf /usr/share/fonts/
sudo fc-cache -f -v

#zsh
sudo apt install zsh fzf curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

cp ~/settings/.zshrc ~/.zshrc
source ~/.zshrc
