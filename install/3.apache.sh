#!/bin/sh

Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

echo "Macintosh Apache MariaDB PHP installation."
echo "From Phong Black with 🍑🍌🍑"
echo "3. Dnsmasq and Apache installation"

config_path="mod_php"
if [ -f $HOMEBREW_PREFIX/etc/fcgi ]; then
  config_path="php_fpm"
fi

if test $(which brew); then
  if [ ! -f $HOMEBREW_PREFIX/sbin/dnsmasq ]; then
    echo "$Green"
    echo "Install Dnsmasq to auto resolve to localhost$Color_Off"
    brew install dnsmasq
    echo 'address=/.test/127.0.0.1' > $HOMEBREW_PREFIX/etc/dnsmasq.conf
  fi
  
  if [ ! -f $HOMEBREW_PREFIX/bin/httpd ]; then
    echo "$Green" 
    echo "Install apache and process config files$Color_Off"

    brew install httpd
    brew services start httpd

    if [ ! -f /etc/resolver/test ]; then
      sudo mkdir -p /etc/resolver
      sudo brew services start dnsmasq
      sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
    fi
    

    mv $HOMEBREW_PREFIX/etc/httpd/httpd.conf $HOMEBREW_PREFIX/etc/httpd/httpd.conf.bak
    mv $HOMEBREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf $HOMEBREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf.bak

    cp -rf ../config/httpd/$config_path/httpd.conf $HOMEBREW_PREFIX/etc/httpd/httpd.conf
    cp -rf ../config/httpd/$config_path/httpd-vhosts.conf $HOMEBREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf

    sed -i '' "s/currentuser/$USER/g" $HOMEBREW_PREFIX/etc/httpd/httpd.conf
    sed -i '' "s#homebrew_prefix#$HOMEBREW_PREFIX#g" $HOMEBREW_PREFIX/etc/httpd/httpd.conf

    sed -i '' "s/currentuser/$USER/g" $HOMEBREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf

  fi

else
  echo "$Red"
  echo "Homebrew is NOT installed! Exit now. $Color_Off"
  exit 1
fi

