#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

echo "Macintosh Apache MariaDB PHP installation."
echo "From Phong Black with 🍑🍌🍑"
echo "8. Oh-My-Zsh config and plugins installation"

if [ -f ~/.oh-my-zsh/README.md ]; then
  echo "$Green"
  echo "Updating zsh config...$Color_Off"

  if [ ! -f ~/.oh-my-zsh/custom/themes/gruvbox.zsh-theme ]; then
    echo "$Green"
    echo "Installing gruvbox theme...$Color_Off"
    curl -L https://raw.githubusercontent.com/sbugzu/gruvbox-zsh/master/gruvbox.zsh-theme > ~/.oh-my-zsh/custom/themes/gruvbox.zsh-theme
  fi
 
  if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
    echo "$Green"
    echo "Installing zsh-completions...$Color_Off"
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
  fi

  if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    echo "$Green"
    echo "Installing zsh-autosuggestions$Color_Off"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  fi

  if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    echo "$Green"
    echo "Installing zsh-syntax-highlighting$Color_Off"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  fi

  CURRENT_USER="$(whoami)"

  CHECKFILE=~/mampro/config/develop.zsh

  if [ -f "$CHECKFILE" ]; then
    if [ ! -f ~/.oh-my-zsh/custom/local.zsh ]; then
      echo "$Green"
      echo "Linking config...$Color_Off"
      cp -rfv ~/mampro/config/develop.zsh ~/mampro/config/local.zsh
      ln -s ~/mampro/config/local.zsh ~/.oh-my-zsh/custom/local.zsh
    fi
  else
    echo "$Red"
    echo "~/mampro/config/develop.zsh is NOT FOUND! $Color_Off"
  fi

else
  echo "$Red"
  echo "Oh-My-Zsh is NOT INSTALLED! Exit now. $Color_Off"
  exit 1
fi

