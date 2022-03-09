#!/bin/bash

#grep -Po '^NAME="\K([^"]+)' /etc/os-release  ## /etc/*-release
#exit

port=$(echo -n "$@" | grep -Po '(?<=--port=)[^ "]+')
user=$(echo -n "$@" | grep -Po '(?<=--user=)[^ "]+')
pass=$(echo -n "$@" | grep -Po '(?<=--pass=)[^ "]+')

rand_pass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9@#_%^&' | fold -w 12 | head -n 1)

test -z "$port" && read -r -p "Proxy port: " port
test -z "$user" && read -r -p "Proxy user: " user
test -z "$pass" && read -r -p "Proxy pass ($rand_pass): " pass
pass=${pass:-$rand_pass}

command -v pip &> /dev/null || sudo apt install pip -y
command -v proxy &> /dev/null || sudo pip install --upgrade --prefix /usr/local proxy.py

#sudo iptables -I INPUT 5 -i ens3 -p tcp --dport "$port" -m state --state NEW,ESTABLISHED -j ACCEPT

cmd="proxy --hostname 0.0.0.0 --port $port --basic-auth \"$user:$pass\""
echo "See: https://github.com/abhinavsingh/proxy.py#start-proxypy"
echo "IP: $(curl -s checkip.amazonaws.com)"
echo "$cmd"
eval "$cmd"
