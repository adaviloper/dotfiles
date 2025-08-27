#!/bin/bash

chmod 755 ~/.oh-my-zsh
find ~/.oh-my-zsh/custom -type d ! -perm 755 -exec chmod 755 {} +
find ~/.oh-my-zsh/custom -type f ! -perm 644 -exec chmod 644 {} +
