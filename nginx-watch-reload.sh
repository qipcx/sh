#!/bin/bash

#if [ -z "$BASH_VERSION" ]; then curl -sL https://sh.qip.cx/nginx-watch-reload.sh | bash -s -- "$@"; exit; fi ## /usr/bin/dash ## ## Run in bash

command -v entr || sudo apt install entr -y -qq -o=Dpkg::Use-Pty=0
#ls /etc/nginx/sites-available/*.conf | entr -p -s 'sudo nginx -t && sudo service nginx reload'
ls /etc/nginx/sites-available/*.conf | entr -p -s 'sudo nginx -t && sudo nginx -s reload'
