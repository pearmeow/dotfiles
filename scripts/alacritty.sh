#! /bin/bash

#alacritty - DO NOT DO IF IN WINDOWS
git clone https://github.com/alacritty/alacritty.git ~/
cd ~/alacritty

#rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup override set stable
rustup update stable

#building alacritty
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 gzip scdoc
cargo build --release

sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
infocmp alacritty

#icon for alacritty
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

#man pages
sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5
scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null

#themes & misc settings
mkdir -p ~/.config/alacritty/themes/
cp ~/settings/themes/alacritty.toml ~/.config/alacritty/
cp ~/settings/themes/snazzy.toml ~/.config/alacritty/themes/
