# Miscellaneous commands that don't belong in the other scripts

# Add groups to user: replace with your own username
sudo gpasswd -a $USER mpd
sudo gpasswd -a $USER realtime
sudo gpasswd -a $USER video
sudo groupadd plugdev
sudo usermod -aG plugdev $USER
