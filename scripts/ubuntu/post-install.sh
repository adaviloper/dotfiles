#!/bin/bash

flatpak install flathub app.zen_browser.zen

# Espanso
sudo apt update && sudo apt install -y build-essential git wl-clipboard libxkbcommon-dev libdbus-1-dev '^libwxgtk3\.[0-9].*-dev$' libssl-dev
sudo apt install -y cargo
cd $HOME/Code/
git clone https://github.com/espanso/espanso
cd espanso/
sudo apt install -y rustup
rustup update
cargo search cargo-make
cargo install cargo-make
cargo make --profile release --env NO_X11=true build-binary 
sudo mv target/release/espanso /usr/local/bin/espanso
sudo setcap "cap_dac_override+p" $(which espanso)
espanso service register
espanso start

# --- START HEADSET CONTROLS
sudo apt-get install -y build-essential git cmake libhidapi-dev
git clone https://github.com/Sapd/HeadsetControl "$HOME/Code/HeadsetControl" && cd "$HOME/Code/HeadsetControl"
mkdir build && cd build
cmake ..
make
sudo make install
# On LINUX, to access without root reboot your computer or run
sudo udevadm control --reload-rules && sudo udevadm trigger
# --- END HEADSET CONTROLS

# --- START DOCKER
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# // /etc/docker/daemon.json
# {
#   "dns": ["8.8.8.8", "1.1.1.1"]
# }

# --- END DOCKER
