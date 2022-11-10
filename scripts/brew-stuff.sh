#!/bin/sh

ACTION="$1"
CACHEDIR=$(brew --cache)

if [ "$ACTION" == "update" ]; then
  brew update
  brew upgrade
elif [ "$ACTION" == "cleanup" ]; then
  brew cleanup
  echo "Removing Homebrew cache directory..."
  rm -rfv $CACHEDIR
else
  brew doctor
fi
