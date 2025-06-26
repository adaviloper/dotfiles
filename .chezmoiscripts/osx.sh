#!/bin/bash

yellow() {
  tput setaf 3
  echo "$*"
  tput sgr0
}

info() {
  echo
  yellow "$@"
}

info "Show hidden files by default"
defaults write com.apple.Finder AppleShowAllFiles -bool false

info "Unhide ~/Library and other folders"
chflags nohidden ~
chflags nohidden ~/Library
chflags nohidden ~/Code

info "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

info "Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

info "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

info "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 2

info "Set a shorter delay until key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

info "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

info "Enable tap to click (Trackpad)"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

info "Restarting Finder to apply changes"
killall Finder

info "Restarting Dock to apply changes"
killall Dock

