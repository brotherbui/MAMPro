#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

echo "Macintosh Apache MariaDB PHP installation."
echo "From Phong Black with 🍑🍌🍑"
echo "7. Oh-My-Zsh installation"

if [ ! -f ~/.oh-my-zsh/README.md ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "$Red"
  echo "Oh-My-Zsh is ALREADY INSTALLED! Exit now. $Color_Off"
  exit 1
fi