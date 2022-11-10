#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

DB="$1"
FILE="$2"

DIR=$(pwd)

if [ -z "$DB" ]; then
  echo "$Red"
  echo "No database name given. Exit now! $Color_Off"
  exit 1
elif [ -z "$FILE" ]; then
  echo "$Red"
  echo "No import file given. Exit now! $Color_Off"
  exit 1
else
  cd "$DIR"

  if [ -d "$HOMEBREW_PREFIX/var/mysql/$DB" ]; then
    mariadb -u root -proot $DB < $FILE
    echo "$Green"
    echo "File: $FILE is imported to database: $DB $Color_Off"
  else
    echo "$Red"
    echo "The database '$DB' doesn't exist! $Color_Off"
    exit 1
  fi
fi