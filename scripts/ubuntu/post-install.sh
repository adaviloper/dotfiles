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

# Headset controls
sudo apt-get install -y build-essential git cmake libhidapi-dev
git clone https://github.com/Sapd/HeadsetControl "$HOME/Code/HeadsetControl" && cd "$HOME/Code/HeadsetControl"
mkdir build && cd build
cmake ..
make
sudo make install

# On LINUX, to access without root reboot your computer or run
sudo udevadm control --reload-rules && sudo udevadm trigger

