#!/bin/sh

echo "installing dotfiles..."

source ./install/link.sh
source ./install/brew.sh

echo "configuring zsh as default shell..."
chsh -s $(which zsh)

echo "installation....DONE"
exit 0
