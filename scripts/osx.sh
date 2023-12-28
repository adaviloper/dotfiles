#!/bin/bash

echo "show hidden files by default"
defaults write com.apple.Finder AppleShowAllFiles -bool false

# echo "show the ~/Library folder in Finder"
chflags nohidden ~
chflags nohidden ~/Library
chflags nohidden ~/Code

echo "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

echo "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 2

echo "Set a shorter Delay until key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "Enable tap to click (Trackpad)"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
