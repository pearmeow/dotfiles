# !/bin/bash
sudo pacman -S xorg-server xorg-apps xorg-xinit xorg-twm xorg-xclock xterm
sudo pacman -S git

sudo pacman -S make gcc ripgrep unzip wget fd
sudo pacman -S --needed xmonad xmonad-contrib xmobar qutebrowser alacritty thunar gvim neovim picom dunst sddm dmenu polkit-kde-agent flameshot feh ncmpcpp btop clipmenu
sudo systemctl enable sddm.service
systemctl --user enable clipmenud.service

sudo pacman -S openssh man
sudo pacman -S fastfetch bat lsd
