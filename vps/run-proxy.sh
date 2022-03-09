#!/bin/bash

port=$(echo -n "$@" | grep -Po '(?<=--port=)[^ "]+')
user=$(echo -n "$@" | grep -Po '(?<=--user=)[^ "]+')
pass=$(echo -n "$@" | grep -Po '(?<=--pass=)[^ "]+')

# @todo Alternative format: --port 56293 --basic-auth user:pass

rand_pass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9#_%^&' | fold -w 12 | head -n 1)

test -z "$port" && read -r -p "Proxy port: " port
test -z "$user" && read -r -p "Proxy user: " user
test -z "$pass" && read -r -p "Proxy pass ($rand_pass): " pass
pass=${pass:-$rand_pass}

test -z "$port" && { echo "Not specified --port!"; exit 1; }
test -z "$user" && { echo "Not specified --user!"; exit 2; }
test -z "$pass" && { echo "Not specified --pass!"; exit 3; }

## Ubuntu/Debian
if command -v apt &> /dev/null; then command -v pip &> /dev/null || sudo apt install pip -y; fi
command -v proxy &> /dev/null || sudo pip install --upgrade --prefix /usr/local proxy.py

sudo iptables -I INPUT 5 -p tcp --dport "$port" -m state --state NEW,ESTABLISHED -j ACCEPT

ip=$(curl -s checkip.amazonaws.com)

cmd="proxy --hostname 0.0.0.0 --port $port --basic-auth $user:$pass"

echo
echo "See: https://github.com/abhinavsingh/proxy.py#start-proxypy"
echo "Run: $cmd"
echo "IP:  $ip"
echo "Use: curl -x http://$user:$pass@$ip:$port http://checkip.amazonaws.com"
echo

eval "$cmd"
