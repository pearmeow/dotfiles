#!/bin/bash

# Symlinking folders & placing files

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES="$REPO/config"

# Initialize submodules if not done so already
git -C "$REPO" submodule update --init --recursive

# Set background image
# feh --bg-scale ~/dotfiles/wallpapers/katana.jpg

mkdir -p ~/repos

# Home directory files
ln -sf "$DOTFILES/home/clang-format" ~/.clang-format
ln -sf "$DOTFILES/home/gitignore_global" ~/.gitignore_global
ln -sf "$DOTFILES/home/gitconfig" ~/.gitconfig
ln -sf "$DOTFILES/home/gitmessage" ~/.gitmessage
ln -sf "$DOTFILES/home/wezterm.lua" ~/.wezterm.lua
ln -sf "$DOTFILES/home/zshrc" ~/.zshrc
ln -sf "$DOTFILES/home/templates" ~/templates

# .config directories
ln -sf "$DOTFILES/awesome" ~/.config/awesome
ln -sf "$DOTFILES/mpd" ~/.config/mpd
ln -sf "$DOTFILES/ncmpcpp" ~/.config/ncmpcpp
ln -sf "$DOTFILES/picom" ~/.config/picom
ln -sf "$DOTFILES/rofi" ~/.config/rofi
ln -sf "$DOTFILES/nvim" ~/.config/nvim

# keyd
sudo ln -sf "$DOTFILES/keyd/default.conf" /etc/keyd/default.conf

# sddm
sudo mkdir -p /usr/share/sddm/themes/
sudo ln -sf "$DOTFILES/sddm/where-is-my-sddm-theme" /usr/share/sddm/themes/where-is-my-sddm-theme
sudo mkdir -p /etc/sddm.conf.d/
sudo ln -sf "$DOTFILES/sddm/default.conf" /etc/sddm.conf.d/default.conf

# ssh
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ln -sf "$DOTFILES/ssh/config" ~/.ssh/config
chmod 600 "$DOTFILES/ssh/config"

# misc system configs
sudo ln -sf "$DOTFILES/misc/00-keyboard.conf" /etc/X11/xorg.conf.d/00-keyboard.conf
sudo ln -sf "$DOTFILES/misc/30-amdgpu-power.rules" /etc/udev/rules.d/30-amdgpu-power.rules
sudo ln -sf "$DOTFILES/misc/49-rootpw-global.rules" /etc/polkit-1/rules.d/49-rootpw-global.rules
sudo ln -sf "$DOTFILES/misc/50-libinputsnippit.conf" /etc/X11/xorg.conf.d/50-libinputsnippit.conf
sudo mkdir -p /etc/udev/rules.d/
sudo ln -sf "$DOTFILES/misc/50-zsa.rules" /etc/udev/rules.d/50-zsa.rules
sudo ln -sf "$DOTFILES/misc/default-wifi-powersave-on.conf" /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
sudo ln -sf "$DOTFILES/misc/local-overrides.quirks" /etc/libinput/local-overrides.quirks
sudo mkdir -p /etc/systemd/system/dhcpcd@.service.d/
sudo ln -sf "$DOTFILES/misc/nowait.conf" /etc/systemd/system/dhcpcd@.service.d/nowait.conf
sudo mkdir -p /etc/pacman.d/hooks
sudo ln -sf "$DOTFILES/misc/nvidia.hook" /etc/pacman.d/hooks/nvidia.hook

# Steam desktop file
mkdir -p ~/.local/share/applications/
ln -sf "$DOTFILES/misc/steam.desktop" ~/.local/share/applications/steam.desktop
