#!/bin/bash

command -v entr &> /dev/null || sudo apt install entr -y -qq -o=Dpkg::Use-Pty=0

ls /etc/nginx/sites-available/*.conf | entr -p -s 'sudo nginx -t && sudo service nginx reload'
