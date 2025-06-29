#!/bin/bash

# Update Ubuntu before Steam installation
sudo apt update && sudo apt upgrade

# Install Initial Packages for Steam
sudo apt install software-properties-common apt-transport-https curl -y

# Enable 32-bit Support For Steam
sudo dpkg --add-architecture i386

# Install Steam on Ubuntu via Steam APT repository
sudo apt install steam-installer steam-devices
## Import Steam GPG key
curl -s http://repo.steampowered.com/steam/archive/stable/steam.gpg | sudo gpg --dearmor -o /usr/share/keyrings/steam.gpg > /dev/null
## Add Steam APT repository
echo deb '[arch=amd64 signed-by=/usr/share/keyrings/steam.gpg] http://repo.steampowered.com/steam/ stable steam' | sudo tee /etc/apt/sources.list.d/steam.list
## Update APT Cache After Steam PPA Import
sudo apt update

# Install the Steam on Ubuntu via APT Command
sudo apt-get install \
  libgl1-mesa-dri:amd64 \
  libgl1-mesa-dri:i386 \
  steam-launcher

sudo rm /etc/apt/sources.list.d/steam-beta.list
sudo rm /etc/apt/sources.list.d/steam-stable.list

flatpak install -y flathub com.heroicgameslauncher.hgl

sudo apt update
