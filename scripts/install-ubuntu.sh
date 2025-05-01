#!/bin/bash

# Espanso
wget https://github.com/espanso/espanso/releases/download/v2.2.1/espanso-debian-wayland-amd64.deb
sudo apt install ./espanso-debian-wayland-amd64.deb
sudo setcap "cap_dac_override+p" $(which espanso)
sudo apt install libwxgtk3.0-gtk3-dev
espanso service register

