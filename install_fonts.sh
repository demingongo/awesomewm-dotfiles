#!/usr/bin/env bash

# install_fonts.sh
#
# Description: install fonts from local/share/fonts folder
# Author: demingongo
# Link: https://github.com/demingongo
# Availability: https://github.com/demingongo/awesomewm-dotfiles

# Tested on Fedora 37 Workstation
#
# Execute the script as a simple user and NOT as root.
#

mkdir -p ~/.local/share
cp -r local/share/fonts ~/.local/share/
fc-cache -v
