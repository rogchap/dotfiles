#!/bin/sh

DF=$HOME/dotfiles

echo "Creating symlinked config directories..."

configs="$DF/kitty/ $DF/nvim/"

for d in $configs; do
    t="$HOME/.config/$(basename $d)"
    if [ -e $t ]; then
        echo "~${t#$HOME} already exists; skipping..."
    else
        echo "Creating symlink for $t..."
        ln -s $d $t
    fi
done
