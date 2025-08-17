#!/bin/bash

find ~/.oh-my-zsh/custom -type d ! -perm 755 -exec chmod 755 {} +
find ~/.oh-my-zsh/custom -type f ! -perm 644 -exec chmod 644 {} +
