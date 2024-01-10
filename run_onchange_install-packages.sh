#!/bin/bash

sudo apt update
sudo apt upgrade

sudo apt install vanilla-gnome-desktop vanilla-gnome-default-settings
sudo apt purge ubuntu-desktop gnome-shell-extension-ubuntu-dock

sudo apt autoremove --purge

sudo apt update
sudo apt upgrade
sudo apt install curl

# install brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt install brave-browser

# atom
# (blender)
sudo apt install calibre
sudo apt install digikam
# double commander or filezilla
# eternl
# guake terminal
# gnome-clocks
# inkscape
# joplin
keepassxc
klatexformula
ledgerlive
nordvpn
okular
# (qgis)
# (redshift)
# slack
superproductivity
syncthing
teams
telegram
timeshift
tlp #(battery optimizer)
# transmission
vlc
# (xygrib)
zoom
zotero
