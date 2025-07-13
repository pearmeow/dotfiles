#!/bin/bash

# Services

# Start ssh agent on boot
systemctl --user enable ssh-agent.service
# Low battery
systemctl --user enable batsignal.service
# Audio with wpctl
systemctl --user enable wireplumber.service
# Display manager
sudo systemctl enable sddm.service
# Periodic trim for ssd wear leveling: more info on archlinux trim page
sudo systemctl enable fstrim.timer
