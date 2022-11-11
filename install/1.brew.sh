#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

echo "Macintosh Apache MariaDB PHP installation."
echo "From Phong Black with 🍑🍌🍑"
echo "1. Brew installation"

if test ! $(which brew); then

  echo "$Green Setting some prerequisites...$Color_Off" 
  echo '# Avoid needing to have Homebrew/homebrew-core or Homebrew/homebrew-cask repositories tapped/cloned locally' >> ~/.zprofile
  echo 'export HOMEBREW_INSTALL_FROM_API=1' >> ~/.zprofile
  echo 'export HOMEBREW_NO_ANALYTICS=1' >> ~/.zprofile
  echo 'export LC_CTYPE=en_US.UTF-8' >> ~/.zprofile
  echo 'export LC_ALL=en_US.UTF-8' >> ~/.zprofile

  # ". ~/.zprofile" does the same thing
  source ~/.zprofile

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  if [ "$(uname -m)" == "arm64" ]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo 'HOMEBREW_PREFIX=/usr/local' >> ~/.zprofile
  fi

  brew doctor
  brew tap brotherbui/homebrew
  brew install openssl
  
  echo "$Red"
  echo "Please quit Terminal and open it again before continuing! $Color_Off"
  exit 1

else
  echo "$Red"
  echo "Homebrew is already installed! Exit now! $Color_Off"
  exit 1
fi