# !/bin/bash

# Display server
sudo pacman -S xorg-server xorg-apps xorg-xinit xorg-twm xorg-xclock xterm

# Essentials
sudo pacman -S git make gcc ripgrep unzip wget fd openssh man fastfetch bat lsd
sudo pacman -S --needed xmonad xmonad-contrib xmobar qutebrowser alacritty thunar gvim neovim picom dunst sddm dmenu polkit-kde-agent flameshot feh ncmpcpp btop clipmenu
sudo systemctl enable sddm.service
systemctl --user enable clipmenud.service
feh --bg-scale dotfiles/themes/120_-_KnFPX73.jpg

# time stuff
sudo timedatectl set-ntp true
sudo timedatectl set-timezone US/Eastern
sudo hwclock --systohc --utc
