#!/bin/sh

DF=$HOME/dotfiles

echo "Creating symlinked directories..."

links=("$DF/vim/")

for d in $links; do
    t="$HOME/.$(basename $d)"
    if [ -e $t ]; then
        echo "~${t#$HOME} already exists; skipping..."
    else
        echo "Creating symlink for $t..."
        ln -s $d $t
    fi
done

exit 0
