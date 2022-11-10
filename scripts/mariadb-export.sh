#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

DB="$1"

if [ -z "$DB" ]; then
  echo "$Red"
  echo "No database name given. Exit now! $Color_Off"
  exit 1
else
  if [ -d "$HOMEBREW_PREFIX/var/mysql/$DB" ]; then
    cd ~/Desktop
    mariadb-dump -u root -proot $DB | gzip -9 > $DB.sql.gz
    echo "$Green"
    echo "$DB is dumped to ~/Desktop/$DB.sql.gz! $Color_Off"
  else
    echo "$Red"
    echo "The database '$DB' doesn't exist! $Color_Off"
    exit 1
  fi
fi