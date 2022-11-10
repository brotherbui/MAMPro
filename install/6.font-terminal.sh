#!/bin/sh

Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow



echo "Macintosh Apache MariaDB PHP installation."
echo "From Phong Black with 🍑🍌🍑"
echo "6. Jetbrains Font and Terminal profile installation"

if test $(which brew); then
  # Install font
  brew install font-jetbrains-mono-nerd-font
  
  # Set Dracula as default theme
  theme=$(<../config/Dracula.terminal.xml)
  plutil -replace Window\ Settings.Dracula -xml "$theme" ~/Library/Preferences/com.apple.Terminal.plist
  defaults write com.apple.Terminal "Default Window Settings" -string "Dracula"
  defaults write com.apple.Terminal "Startup Window Settings" -string "Dracula"
  defaults write com.apple.Terminal "NSWindow Frame TTWindow Dracula" -string "529 372 682 442 0 0 1920 1055 "

else
  echo "$Red"
  echo "Homebrew is NOT installed or you might need to quit Terminal and try again. Exit now. $Color_Off"
  exit 1
fi



