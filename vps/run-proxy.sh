#!/bin/bash

#grep -Po '^NAME="\K([^"]+)' /etc/os-release  ## /etc/*-release
#exit

port=$(echo -n "$@" | grep -Po '(?<=--port=)[^ "]+')
user=$(echo -n "$@" | grep -Po '(?<=--user=)[^ "]+')
pass=$(echo -n "$@" | grep -Po '(?<=--pass=)[^ "]+')

test -z "$port" && read -r -p "Proxy port:" port
test -z "$user" && read -r -p "Proxy user: " user
test -z "$pass" && read -r -p "Proxy pass: " pass

command -v pip &> /dev/null || sudo apt install pip -y
command -v proxy &> /dev/null || sudo pip install --upgrade --prefix /usr/local proxy.py
#sudo iptables -I INPUT 5 -i ens3 -p tcp --dport "$port" -m state --state NEW,ESTABLISHED -j ACCEPT
echo "See: https://github.com/abhinavsingh/proxy.py#start-proxypy"
echo "IP: $(curl ifconfig.co)"
proxy --hostname 0.0.0.0 --port "$port" --basic-auth "$user:$pass"
