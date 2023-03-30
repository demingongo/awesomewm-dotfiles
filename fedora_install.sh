#!/usr/bin/env bash

# fedora_install.sh
#
# Description: install awesomewm-dotfiles
# Author: demingongo
# Link: https://github.com/demingongo
# Availability: https://github.com/demingongo/awesomewm-dotfiles

# Tested on Fedora 37 Workstation
#
# Execute the script as a simple user and NOT as root.
#

## Fail if something went wrong
set -euo pipefail

# Authorize sudo
sudo echo

# Install git if command "git" was not found
if ! command -v git &> /dev/null 
then
    sudo dnf install git
fi

echo
echo -n "Copy dotfiles for awesome wm ? [y/N] "
read c_answer_awesome
if [[ "$c_answer_awesome" == "y" ]]; then
    cp -r config/awesome ~/.config/
    cp -r config/kitty ~/.config/
    cp -r config/picom ~/.config/

    ./install_fonts.sh

    cp -r local/bin ~/.local/
    
    set +e
    git clone https://github.com/demingongo/awesomewm-mpris-widget.git ~/.config/awesome/awesomewm-mpris-widget
    git clone https://github.com/streetturtle/awesome-wm-widgets.git ~/.config/awesome/awesome-wm-widgets
    git clone https://github.com/lcpz/awesome-freedesktop.git ~/.config/awesome/freedesktop
    git clone https://github.com/lcpz/lain.git ~/.config/awesome/lain
    set -e
fi

c_answer_dep="y"
if [[ "$c_answer_awesome" != "y" ]]; then
    echo
    echo -n "Install awesome and its dependencies ? [y/N] "
    read c_answer_dep
fi

if [[ "$c_answer_dep" == "y" ]]; then
    ## Awesome WM
    #
    # Install
    #
    sudo dnf install awesome.x86_64
    
    ## Usefool tools
    #
    # Install
    #
    sudo dnf install xset xinput numlockx brightnessctl pavucontrol acpi network-manager-applet blueman picom kitty cool-retro-term
    
    ## "Nice to have" tools
    #
    # Install
    #
    sudo dnf install neofetch cava
    
    echo
    echo -n "Set a GNOME session for awesome ? [y/N] "
    read c_answer_session
    if [[ "$c_answer_session" == "y" ]]; then
        #
        # Set session
        #
        echo """[GNOME Session]
Name=Awesome session
RequiredComponents=awesome;gnome-settings-daemon;
DesktopName=Awesome
        """ | sudo tee /usr/share/gnome-session/sessions/awesome.session
        #
        # Desktop entry
        #
        echo """[Desktop Entry]
Version=1.0
Type=Application
Name=Awesome
Comment=The awesome launcher!
TryExec=awesome
Exec=awesome
        """ | sudo tee /usr/share/applications/awesome.desktop
    fi
    
fi
