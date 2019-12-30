#!/bin/sh

DF=$HOME/dotfiles

cwd=$(pwd)
cd $DF/fonts
for f in $(ls *.ttf); do
    echo "copying font: $f"
    cp $f ~/Library/Fonts/ 
done
cd $cwd
