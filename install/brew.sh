#!/bin/sh

# Install Homebrew or make sure it's up to date
which -s brew
if [[ $? != 0 ]] ; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
brew install htop                   # process viewer
brew install lazygit                # UI for git
brew install neofetch               # for unixporn
brew install lf                     # file manager
brew install cmatrix                # just for fun 

echo "Installing development tools..."
brew install git                    # keep git updated with homebrew
brew install go                     # Go programing language
brew install node                   # Node.js and npm
brew install python                 # Python 3 and pip
brew install the_silver_searcher    # code searching tool
brew install tmux                   # terminal multiplexer
brew install neovim                 # text/code editor that rocks
brew install zsh                    # the only shell you need
brew install grip                   # preview github flavoured markdown
brew install github/gh/gh           # GitHub CLI
brew install gnupg                  # Privacy Guard
brew install pinentry-mac           # Secure PIN entry for PGP
brew install anomalyco/tap/opencode # AI coding agent

# configuration for zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

pip3 install pynvim                 # required for fzf.vim plugin

echo "Installing casks..."
brew install --cask firefox                 # internet browser
brew install --cask kitty                   # terminal emulator
brew install --cask slack                   # messaging client
brew install --cask docker 	                # *nix containers
brew install --cask 1password	            # password manager
brew install --cask claude                  # AI desktop app
brew install --cask git-credential-manager  # Git credential storage

echo "Cleanup..."
brew cleanup
