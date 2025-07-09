# !/bin/bash

# Before you install
# Make sure yay is installed from the git repo

# Display server
sudo pacman -S --needed xorg-server xorg-apps xorg-xinit xorg-twm xorg-xclock xterm xorg-xmessage

# Essentials
sudo pacman -S --needed make gcc unzip wget fd openssh man

# Terminal emulator
sudo pacman -S --needed alacritty
polkit-kde-agent flameshot ncmpcpp btop vi

# File manager
sudo pacman -S --needed nautilus

# Text editor
sudo pacman -S --needed neovim

# Compositor if not on Wayland
sudo pacman -S --needed picom

# Display manager
sudo pacman -S --needed sddm

# Polkit authentication
sudo pacman -S --needed polkit-kde-agent

# Screenshot
sudo pacman -S --needed flameshot

# Music player
sudo pacman -S --needed ncmpcpp

# System overview
sudo pacman -S --needed btop

# Replacement for ls, cat, neofetch, and grep
sudo pacman -S --needed lsd, bat, fastfetch, ripgrep

# Window manager + notification daemon + bar + background image
sudo pacman -S --needed awesome

# Hide cursor after some time
sudo pacman -S --needed unclutter

# Dmenu replacement to search for apps
sudo pacman -S --needed rofi

# Clipboard
sudo pacman -S --needed xsel

# Notification daemon if not using awesome
# sudo pacman -S --needed dunst
# Wallpaper if not using awesome
# sudo pacman -S --needed feh

sudo systemctl enable sddm.service
feh --bg-scale ~/dotfiles/wallpapers/katana.jpg

# Time
sudo timedatectl set-ntp true
sudo timedatectl set-timezone US/Eastern
sudo hwclock --systohc --utc

# Audio
sudo pacman -S --needed pipewire-alsa pipewire-pulse
systemctl --user enable wireplumber.service

# Lock
sudo pacman -S --needed xss-lock i3lock

# Fonts
sudo pacman -S --needed noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-jetbrains-mono-nerd

# Audio Defaults
sudo gpasswd -a pearmeow realtime
sudo pacman -S realtime-privileges

# AUR (yay)
# Backlight
yay -S light
# Browser, discord, and font
yay -S brave-bin vesktop ttf-times-new-roman 
# Signal for low battery
yay -S batsignal
systemctl --user enable batsignal.service
