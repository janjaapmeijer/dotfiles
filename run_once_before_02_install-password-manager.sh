#!/bin/bash

sudo apt update && sudo apt upgrade

sudo add-apt-repository ppa:phoerious/keepassxc -y
sudo apt update
sudo apt install keepassxc
