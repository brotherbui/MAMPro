#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow


app="$(basename "$0")"
latest="7.4"
action="$1"

phpversion="$latest"
mod_php="mod_php"

if [ -f "$HOMEBREW_PREFIX"/etc/fcgi ]; then
  phpversion="$2"
  mod_php=""
fi

opcache_conf_path="$HOMEBREW_PREFIX/etc/php/$phpversion/conf.d"
opcache_conf_file="ext-opcache.ini"
opcache_conf=$opcache_conf_path/$opcache_conf_file

STATUS="enabled"
RESTART="no"
SHOWHELP="yes"
PHPEXEC="$HOMEBREW_PREFIX/opt/php@$phpversion/bin/php"


if [ "$phpversion" != "" ]; then
  if [ -f "$opcache_conf" ] && [ -f "$opcache_conf.disabled" ]; then
    echo "$Red"
    echo "Detected both enabled and disabled opcache ini files. Deleting the disabled one. $Color_Off"
    rm -rf "$opcache_conf.disabled"
    STATUS="enabled"
  elif [ -f "$opcache_conf.disabled" ]; then
    STATUS="disabled"
  fi

  if [ $# -ge 1 ]; then
    if [ "$action" == "on" ] || [ "$action" == "s" ] || [ "$action" == "e" ]; then
      mv "$opcache_conf.disabled" "$opcache_conf" 2> /dev/null
      STATUS="enabled"
      RESTART="yes"
      SHOWHELP="no"
    elif [ "$action" == "off" ] || [ "$action" == "o" ] || [ "$action" == "d" ]; then
      mv "$opcache_conf" "$opcache_conf.disabled" 2> /dev/null
      STATUS="disabled"
      RESTART="yes"
      SHOWHELP="no"
    fi
  fi
else
  SHOWHELP="yes"
fi


if [ "$SHOWHELP" == "yes" ]; then
  echo "$Green"
  if [ "$mod_php" != "" ]; then
    echo "Usage: ${app} <on/s/e | off/o/d> $Color_Off"
  else
    echo "Usage: ${app} <on/s/e | off/o/d> php_version"
    echo "Example: o e 8.0 $Color_Off"
  fi
fi

if [ "$RESTART" == "yes" ]; then
  echo "$Green"
  echo "Opcache has been $STATUS, restarting server $Color_Off"
  if [ "$mod_php" != "" ]; then
    brew services restart httpd
  else
    brew services restart php@"$phpversion"
  fi
  echo ""
  $PHPEXEC -v
fi