#!/bin/sh

Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow



mkdir -p $HOMEBREW_PREFIX/etc/httpd/vhosts
cp -rf ../config/httpd/localhost.conf $HOMEBREW_PREFIX/etc/httpd/vhosts/localhost.conf

cp -rf ../config/httpd/httpd-override.conf $HOMEBREW_PREFIX/etc/httpd/httpd-override.conf
sed -i '' "s|current_user|$USER|g" $HOMEBREW_PREFIX/etc/httpd/httpd-override.conf
sed -i '' "s|homebrew_prefix|$HOMEBREW_PREFIX|g" $HOMEBREW_PREFIX/etc/httpd/httpd-override.conf

cp -rf $HOMEBREW_PREFIX/etc/httpd/original/httpd.conf $HOMEBREW_PREFIX/etc/httpd/httpd.conf

sed -i '' "s|<IfModule ssl_module>|\\n# Override default settings\\nInclude $HOMEBREW_PREFIX/etc/httpd/httpd-override.conf\\n\\n<IfModule ssl_module>|g" $HOMEBREW_PREFIX/etc/httpd/httpd.conf

brew services restart httpd




