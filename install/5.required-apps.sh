#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

echo "Macintosh Apache MariaDB PHP installation."
echo "From Phong Black with 🍑🍌🍑"
echo "5. Required applications installation"

if test $(which brew); then
  if [ ! -d "/Applications/Visual Studio Code.app" ]; then
    echo "$Green"
    echo "Installing Visual Studio Code... $Color_Off" 
    brew install visual-studio-code
  fi
else
  echo "$Red"
  echo "Homebrew is NOT installed or you might need to quit Terminal and try again. Exit now. $Color_Off"
  exit 1
fi