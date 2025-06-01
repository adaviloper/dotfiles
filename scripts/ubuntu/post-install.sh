#!/bin/bash

flatpak install flathub app.zen_browser.zen

sudo apt update && sudo apt install build-essential git wl-clipboard libxkbcommon-dev libdbus-1-dev '^libwxgtk3\.[0-9].*-dev$' libssl-dev
sudo apt install cargo
cd $HOME/Code/
git clone https://github.com/espanso/espanso
cd espanso/
sudo apt install rustup
rustup update
cargo search cargo-make
cargo install cargo-make
cargo make --profile release --env NO_X11=true build-binary 
sudo mv target/release/espanso /usr/local/bin/espanso
sudo setcap "cap_dac_override+p" $(which espanso)
espanso service register
espanso start

