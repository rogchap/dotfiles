#!/bin/sh

echo "installing dotfiles..."

echo "initializing submodule(s)"
git submodule update --init --recursive --jobs 8

source ./install/brew.sh
source ./install/link.sh
source ./install/linkdirs.sh
source ./install/osx.sh
source ./install/fonts.sh

echo "configuring zsh as default shell..."
chsh -s $(which zsh)

echo "installation....DONE"
exit 0
