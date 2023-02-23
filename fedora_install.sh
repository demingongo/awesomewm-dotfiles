#!/bin/bash

### Tested on Fedora 37 Workstation
###
### Execute the script as a simple user and NOT as root.
###

## Fail if something went wrong
set -euo pipefail

# Authorize sudo
sudo echo

GIT_PATH="$(which git)"

if [[ -z GIT_PATH ]]; then
    sudo dnf install git
fi

echo
echo -n "Copy dotfiles for awesome wm ? [y/N] "
read c_answer_awesome
if [[ "$c_answer_awesome" == "y" ]]; then
    cp -r config/awesome ~/.config/
    cp -r config/kitty ~/.config/
    cp -r config/picom ~/.config/
    
    git clone https://github.com/streetturtle/awesome-wm-widgets.git ~/.config/awesome/awesome-wm-widgets
    git clone https://github.com/lcpz/awesome-freedesktop.git ~/.config/awesome/freedesktop
    git clone https://github.com/lcpz/lain.git ~/.config/awesome/lain
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
    
    ## Fun tools
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

echo
echo -n "Copy dotfiles for neovim ? [y/N] "
read c_answer_neovim
if [[ "$c_answer_neovim" == "y" ]]; then
    cp -r config/nvim ~/.config/
fi

c_answer_neovim_dep="y"
if [[ "$c_answer_neovim" != "y" ]]; then
    echo
    echo -n "Install neovim and its dependencies ? [y/N] "
    read c_answer_neovim_dep
fi

if [[ "$c_answer_neovim_dep" == "y" ]]; then
    ## Neovim
    #
    # neovim, gcc-c++, go
    #
    sudo dnf install neovim gcc-c++ go
    #
    # vim-plug: https://github.com/junegunn/vim-plug
    #
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    #
    # ascii-image-converter
    #
    go install github.com/TheZoraiz/ascii-image-converter@latest
    #
    # node, npm
    #
    set +e
    NPM_PATH="$(which npm)"
    if [[ -z NPM_PATH ]]; then
        NVM_PATH="$(which nvm)"
        if [[ -z NVM_PATH ]]; then
            # install nvm
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
        fi
        # install node
        nvm install node
    fi
    #
    # lsp
    #
    npm i -g pyright @angular/language-server vscode-langservers-extracted typescript typescript-language-server yaml-language-server
    set -e
fi

### Fonts
#
# https://github.com/ryanoasis/nerd-fonts
#
# Install Hack font (see https://github.com/ryanoasis/nerd-fonts#option-3-install-script)
#
