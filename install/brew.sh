#!/bin/sh

# Install Homebrew or make sure it's up to date
which -s brew
if [[ $? != 0 ]] ; then
    echo "Homebrew not found. Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew already installed. Updating..."
    brew update
    brew upgrade
fi

echo "No analytics..."
brew analytics off
export HOMEBREW_NO_ANALYTICS=1

echo "Installing Homebrew packages..."
brew install clang-format           # format C/C++ and protobuf files
brew install cmake                  # cross platform build system
brew install ctag                   # index lang objects for vim
brew install fzf                    # fuzzy searching
brew install gotop                  # graphical activity monitor
brew install htop                   # process viewer
brew install lazygit                # UI for git
brew install neofetch               # for unixporn
brew install ranger                 # file manager

echo "Installing development tools..."
brew install git                    # keep git updated with homebrew
brew install go                     # Go programing language
brew install python                 # Python 3 and pip
brew install the_silver_searcher    # code searching tool
brew install tmux                   # terminal multiplexer
brew install vim                    # text/code editor that rocks
brew install zsh                    # the only shell you need
brew install grip                   # preview github flavoured markdown

# configuration for zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

pip3 install pynvim                 # required for fzf.vim plugin

echo "Installing casks..."
brew cask install firefox           # internet browser
brew cask install iterm2            # terminal emulator
brew cask install slack             # messaging client
brew cask install spotify           # music client

echo "Cleanup..."
brew cleanup
