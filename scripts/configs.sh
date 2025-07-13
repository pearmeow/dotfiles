#!/bin/bash

# Copying folders & placing files

# Set background image
# feh --bg-scale ~/dotfiles/wallpapers/katana.jpg

# Set up development environment
mkdir ~/repos
cp ../zshrc ~/.zshrc
cp ../clang-format ~/.clang-format
cp ../gitignore_global ~/.gitignore_global

# Copy awesome alacritty, and rofi configs into .config
cp -r ../config/awesome ~/.config/
cp -r ../config/alacritty ~/.config/
cp -r ../config/rofi ~/.config/

# Copy ssh config into .ssh directory
mkdir -p ~/.ssh
cp ../config/ssh/ ~/.ssh/config

# Copy templates for editing files
cp -r ../templates ~/

# Copy steam desktop file to its directory
mkdir -p ~/.local/share/applications/
cp ../misc/steam.desktop ~/.local/share/applications/

# Make dhcpcd run in the background to boot faster
sudo mkdir /etc/systemd/system/dhcpcd@.service.d/
sudo cp ../config/conf/nowait.conf /etc/systemd/system/dhcpcd@.service.d/

# Configure mouse and keyboard behavior
sudo cp ../config/conf/00-keyboard.conf /etc/X11/xorg.conf.d/
sudo cp ../config/conf/50-libinputsnippit.conf /etc/X11/xorg.conf.d/

# Configure wifi card to not shut down randomly
sudo cp ../config/conf/default-wifi-powersave-on.conf /etc/NetworkManager/conf.d/

# Copy sddm configs into their respective places
sudo mkdir -p /usr/share/sddm/themes/
sudo cp -r ../config/sddm/where-is-my-sddm-theme/ /usr/share/sddm/themes/
sudo mkdir -p /etc/sddm.conf.d/
sudo cp ../config/sddm/default.conf /etc/sddm.conf.d/

# Copy amdgpu power rules to fix flickering
sudo cp 30-amdgpu-power.rules /etc/udev/rules.d
