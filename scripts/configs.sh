#!/bin/bash

# Copying folders & placing files

# Set background image
# feh --bg-scale ~/dotfiles/wallpapers/katana.jpg

# Copy files that belong in the home directory to ~/
mkdir -p ~/repos
cp ../config/home/zshrc ~/.zshrc
cp ../config/home/clang-format ~/.clang-format
cp ../config/home/gitignore_global ~/.gitignore_global
cp ../config/home/gitconfig ~/.gitconfig
cp -r ../config/home/templates ~/

# Copy configs that live in .config into their respective places
cp -r ../config/alacritty ~/.config/
cp -r ../config/awesome ~/.config/
cp -r ../config/mpd ~/.config/
cp -r ../config/ncmpcpp ~/.config/
cp -r ../config/picom ~/.config/
cp -r ../config/rofi ~/.config/

# Copy sddm configs into their respective places
sudo mkdir -p /usr/share/sddm/themes/
sudo cp -r ../config/sddm/where-is-my-sddm-theme/ /usr/share/sddm/themes/
sudo mkdir -p /etc/sddm.conf.d/
sudo cp ../config/sddm/default.conf /etc/sddm.conf.d/

# Copy ssh config into .ssh directory
mkdir -p ~/.ssh
cp ../config/ssh/config ~/.ssh/

# Configure mouse
sudo cp ../config/misc/00-keyboard.conf /etc/X11/xorg.conf.d/

# Copy amdgpu power rules to fix flickering
sudo cp ../config/misc/30-amdgpu-power.rules /etc/udev/rules.d

# Configure polkit to use root password
sudo cp ../config/misc/49-rootpw-global.rules /etc/polkit-1/rules.d/

# Configure keyboard behavior
sudo cp ../config/misc/50-libinputsnippit.conf /etc/X11/xorg.conf.d/

# Configure wifi card to not shut down randomly
sudo cp ../config/misc/default-wifi-powersave-on.conf /etc/NetworkManager/conf.d/

# Add keyd fix for trackpad interfering with input
sudo cp ../config/misc/local-overrides.quirks /etc/libinput/

# Make dhcpcd run in the background to boot faster
sudo mkdir -p /etc/systemd/system/dhcpcd@.service.d/
sudo cp ../config/misc/nowait.conf /etc/systemd/system/dhcpcd@.service.d/

# Copy nvidia hook into pacman
sudo mkdir -p /etc/pacman.d/hooks
sudo cp ../config/misc/nvidia.hook /etc/pacman.d/hooks/

# Copy steam desktop file to its directory
mkdir -p ~/.local/share/applications/
cp ../config/misc/steam.desktop ~/.local/share/applications/

