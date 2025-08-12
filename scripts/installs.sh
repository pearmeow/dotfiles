# !/bin/bash

# Before you install
# Make sure yay is installed from the git repo

# Package variable so everything can be installed in one command later
packages=""

# Display server
packages+=" xorg-server xorg-apps xorg-xinit xorg-twm xorg-xclock xterm xorg-xmessage"

# Essentials
packages+=" make gcc unzip wget openssh man"

# C++ debugging
packages+=" gdb"

# Terminal emulator
packages+=" wezterm"

# File manager
packages+=" nautilus"

# Text editor
packages+=" neovim"

# Compositor
# packages+=" picom"

# Display manager
packages+=" sddm"

# Polkit authentication
packages+=" polkit-kde-agent"

# Screenshot
packages+=" flameshot"

# Music player
packages+=" ncmpcpp"

# And music downloader
packages+=" yt-dlp"

# And mpd server
packages+=" mpd"

# System overview
packages+=" btop"

# Replacement for ls, cat, neofetch, grep, and find
packages+=" lsd bat bat-extras fastfetch ripgrep fd"

# Git diff using delta
packages+=" git-delta"

# Window manager + notification daemon + bar + background image
packages+=" awesome"

# Hide cursor after some time
packages+=" unclutter"

# Dmenu replacement to search for apps
packages+=" rofi"

# Clipboard
packages+=" xsel"

# Notification daemon if not using awesome
# packages+=" dunst"
# Wallpaper if not using awesome
# packages+=" feh"

# Bluetooth
packages+=" bluez bluez-utils"

# Audio
packages+=" pipewire-alsa pipewire-pulse"

# Lock
packages+=" xss-lock"

# Fonts
packages+=" noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-jetbrains-mono-nerd ttf-roboto"

# Audio Defaults
packages+=" realtime-privileges"

# Battery command
packages+=" acpi"

# Autostart using awesome
packages+=" dex"

# Configure logitech mice
packages+=" solaar"

# Sddm theme dependency
packages+=" qt6-5compat"

# Xournal++ for drawing
packages+=" xournalpp"

# Keyd for key remapping & other utility
packages+=" keyd"

# AUR (yay)
yaypackages=""
# Backlight
yaypackages+=" light"
# Browser, discord, and font
yaypackages+=" brave-bin vesktop ttf-times-new-roman"
# Signal for low battery
yaypackages+=" batsignal"
# Locking mechanism
yaypackages+=" i3lock-color"

sudo pacman -S --needed $packages
yay -S --needed $yaypackages
