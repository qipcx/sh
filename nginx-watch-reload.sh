#!/bin/bash

ls /etc/nginx/sites-available/*.conf | entr -p -s 'sudo nginx -t && sudo service nginx reload'
