#!/bin/sh
PHP_VER="8.1"

Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

usageFunc()
{
  echo "$Yellow"
  echo "Usage: ./$(basename $0) -m MODE [fcgi/apache] -v VERSIONS -x EXTENSIONS"
  echo "Eg:    ./$(basename $0) -m fcgi -v 7.4,8.1 -x xdebug,mongodb,redis"
  echo "$Color_Off"
  exit 1 # Exit script after printing help
}

while getopts m:v:x: opt
do
  case "$opt" in
    m) MODE="$OPTARG" ;;
    v) VERSIONS="$OPTARG" ;;
    x) EXTENSIONS="$OPTARG" ;;
    ?) usageFunc ;; # Print helpFunction in case parameter is non-existent
  esac
done


if [ -z "$MODE" ]; then
   MODE="fcgi"
fi

if [ -z "$VERSIONS" ] || [ -z "$EXTENSIONS" ]; then
  usageFunc
fi


vers=(${VERSIONS//","/ })
exts=(${EXTENSIONS//","/ })

echo "Macintosh Apache MariaDB PHP installation."
echo "From Phong Black with 🍑🍌🍑"
echo "2. Install PHP ($VERSIONS), extensions ($EXTENSIONS), composer and process config files"

if test $(which brew); then
  #Create mode file to tell Apache which mode will be used
  echo $MODE > $HOMEBREW_PREFIX/etc/$MODE

  LATEST_PHP_VERSION=$(brew info php | grep -Eo "etc/php/[0-9.]*" | awk -F/ '{print $(NF)}')

  d=$(date +%Y%m%d)
  # Now loop the versions and install 
  for i in "${vers[@]}";
  do
    PATH_TO_PHP_DIR=$HOMEBREW_PREFIX/opt/php@"$i"
    if [ "$i" == "$LATEST_PHP_VERSION" ]; then
      PATH_TO_PHP_DIR=$HOMEBREW_PREFIX/opt/php
    fi
    if [ ! -f $PATH_TO_PHP_DIR/bin/php ]; then
      echo "$Green Installing PHP $i.. $Color_Off"

      NODOT=${i/./}
      brew install php@"$i"

      #brew link --force --overwrite php@"$i"

      cp $HOMEBREW_PREFIX/etc/php/"$i"/php.ini $HOMEBREW_PREFIX/etc/php/"$i"/php.ini.$d.bak

      #Fix mongodb installation error
      ln -s $HOMEBREW_PREFIX/opt/pcre2/include/pcre2.h $PATH_TO_PHP_DIR/include/php/ext/pcre/pcre2.h
      
      for ext in "${exts[@]}";
      do
        if [ -f ../config/ext-$ext.ini ]; then
          check=$($PATH_TO_PHP_DIR/bin/php -m | grep -i "$ext")
          if [ "$check" != "" ]; then
            echo "Extension '$ext' is already installed. Skip."
          else
            echo "$Green Installing extension $ext for PHP $i.. $Color_Off"
            if [ "$ext" == "redis" ]; then
              $PATH_TO_PHP_DIR/bin/pecl install --configureoptions 'enable-redis-igbinary="no" enable-redis-lzf="no" enable-redis-zstd="no"' $ext
            else
              $PATH_TO_PHP_DIR/bin/pecl install $ext
            fi
            cp -rf ../config/ext-$ext.ini $HOMEBREW_PREFIX/etc/php/"$i"/conf.d/
          fi
          
        else
          echo "$Red"
          echo "Extension $ext is not valid! $Color_Off"
        fi

      done

      # Delete default values added to main php.ini file then use separated extension conf instead
      sed -i '' -e '/extension="redis.so"/d' $HOMEBREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' -e '/extension="mongodb.so"/d' $HOMEBREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' -e '/zend_extension="xdebug.so"/d' $HOMEBREW_PREFIX/etc/php/"$i"/php.ini

      sed -i '' 's/max_execution_time = 30/max_execution_time = 0/g' $HOMEBREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' 's/max_input_time = 60/max_input_time = 0/g' $HOMEBREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' 's/memory_limit = 128M/memory_limit = 512M/g' $HOMEBREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' 's/post_max_size = 8M/post_max_size = 128M/g' $HOMEBREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' 's/upload_max_filesize = 2M/upload_max_filesize = 128M/g' $HOMEBREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' 's/;max_input_vars = 1000/max_input_vars = 10000/g' $HOMEBREW_PREFIX/etc/php/"$i"/php.ini

      sed -i '' "s/9000/90$NODOT/g" $HOMEBREW_PREFIX/etc/php/"$i"/php-fpm.d/www.conf

       brew services start php@"$i"
    else
      echo "$Yellow"
      echo "PHP $i is already installed! Skip. $Color_Off"
    fi
  done

  #Install tools
  if [ ! -f $HOMEBREW_PREFIX/bin/composer ]; then
    brew install composer
  fi

  if [ ! -f $HOMEBREW_PREFIX/bin/php-cs-fixer ]; then 
    brew install php-cs-fixer
  fi

else
  echo "$Red"
  echo "Homebrew is NOT installed or you might need to quit Terminal and try again. Exit now. $Color_Off"
  exit 1
fi