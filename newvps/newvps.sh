#!/usr/bin/env bash

set -e
apt update
apt install -y git zsh vim
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
sed -i "s/robbyrussell/ys/g" ${HOME}/.zshrc
chsh -s $(which zsh)
zsh
source ${HOME}/.zshrc
