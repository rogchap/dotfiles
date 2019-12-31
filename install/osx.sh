#!/bin/sh

# Close any open System Preferences panes,
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "System: disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "

echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Finder: show the ~/Library folder"
chflags nohidden ~/Library

echo "Finder: Disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true

echo "Finder: use current directory as default search scope"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons"
defaults write com.apple.finder QuitMenuItem -bool true

echo "Finder: show Path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "Finder: show Status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Dock: automatically hide and show"
defaults write com.apple.dock autohide -bool true

echo "Dock: orientation to the right"
defaults write com.apple.dock orientation -string right

echo "iTerm2: specify the preferences directory"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"

echo "iTerm2: use the custom preferences in the directory"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

echo "killing affected applications"
for app in Finder Dock SystemUIServer; do killall "$app" >/dev/null 2>&1; done
