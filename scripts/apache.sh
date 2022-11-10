#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

ACTION="$1"

if [ "$ACTION" == "start" ]; then
    brew services start httpd
elif [ "$ACTION" == "stop" ]; then
    brew services stop httpd
elif [ "$ACTION" == "restart" ]; then
    brew services restart httpd
fi