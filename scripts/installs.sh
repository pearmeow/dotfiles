# !/bin/bash

# Before you install
# Make sure yay is installed from the git repo

# Package variable so everything can be installed in one command later
packages=""

# Display server
packages="${packages} xorg-server xorg-apps xorg-xinit xorg-twm xorg-xclock xterm xorg-xmessage"

# Essentials
packages="${packages} make gcc unzip wget fd openssh man"

# Terminal emulator
packages="${packages} alacritty"

# File manager
packages="${packages} nautilus"

# Text editor
packages="${packages} neovim"

# Compositor if not on Wayland
packages="${packages} picom"

# Display manager
packages="${packages} sddm"

# Polkit authentication
packages="${packages} polkit-kde-agent"

# Screenshot
packages="${packages} flameshot"

# Music player
packages="${packages} ncmpcpp"

# System overview
packages="${packages} btop"

# Replacement for ls, cat, neofetch, and grep
packages="${packages} lsd, bat, fastfetch, ripgrep"

# Window manager + notification daemon + bar + background image
packages="${packages} awesome"

# Hide cursor after some time
packages="${packages} unclutter"

# Dmenu replacement to search for apps
packages="${packages} rofi"

# Clipboard
packages="${packages} xsel"

# Notification daemon if not using awesome
# packages="${packages} dunst"
# Wallpaper if not using awesome
# packages="${packages} feh"

# Audio
packages="${packages} pipewire-alsa pipewire-pulse"

# Lock
packages="${packages} xss-lock i3lock"

# Fonts
packages="${packages} noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-jetbrains-mono-nerd"

# Audio Defaults
packages="${packages} realtime-privileges"

# AUR (yay)
yaypackages=""
# Backlight
yaypackages="${yaypackages} light"
# Browser, discord, and font
yaypackages="${yaypackages} brave-bin vesktop ttf-times-new-roman"
# Signal for low battery
yaypackages="${yaypackages} batsignal"

sudo pacman -S --needed $packages
yay -S --needed $yaypackages

systemctl --user enable batsignal.service
systemctl --user enable wireplumber.service
sudo systemctl enable sddm.service
sudo gpasswd -a pearmeow realtime
# feh --bg-scale ~/dotfiles/wallpapers/katana.jpg

# Time
sudo timedatectl set-ntp true
sudo timedatectl set-timezone US/Eastern
sudo hwclock --systohc --utc

