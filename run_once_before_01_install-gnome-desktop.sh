#!/bin/bash

sudo apt update && sudo apt upgrade
sudo apt git
sudo apt curl

sudo apt install vanilla-gnome-desktop vanilla-gnome-default-settings
sudo apt purge ubuntu-desktop gnome-shell-extension-ubuntu-dock

sudo apt autoremove --purge

# Adding some environment paths
echo 'export PATH=~/.local/bin:$PATH' >> ~/.bash_profile
