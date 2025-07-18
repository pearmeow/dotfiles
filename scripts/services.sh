#!/bin/bash

# Services

# Start ssh agent on boot
systemctl --user enable ssh-agent.service
# Low battery
systemctl --user enable batsignal.service
# Audio with wpctl
systemctl --user enable wireplumber.service
# Mpd for music but it's a socket so only activated when needed
systemctl --user enable mpd.socket
# Display manager
sudo systemctl enable sddm.service
# Periodic trim for ssd wear leveling: more info on archlinux trim page
sudo systemctl enable fstrim.timer
# Enable bluetooth
sudo systemctl enable bluetooth.service
