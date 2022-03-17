#!/bin/bash

port=$(echo -n "$@" | grep -Po '(?<=--port=)[^ "]+')
user=$(echo -n "$@" | grep -Po '(?<=--user=)[^ "]+')
pass=$(echo -n "$@" | grep -Po '(?<=--pass=)[^ "]+')

# @todo Alternative format: --port 56293 --basic-auth user:pass

rand_user=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 6 | head -n 1)
rand_pass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9#_%^&' | fold -w 12 | head -n 1)
rand_port="5"$(cat /dev/urandom | tr -dc '0-9' | fold -w 4 | head -n 1)

test -z "$user" && read -r -p "Proxy user ($rand_user): " user
test -z "$pass" && read -r -p "Proxy pass ($rand_pass): " pass
test -z "$port" && read -r -p "Proxy port ($rand_port): " port

user=${user:-$rand_user}
pass=${pass:-$rand_pass}
port=${port:-$rand_port}

test -z "$port" && { echo "Not specified --port!"; exit 1; }
test -z "$user" && { echo "Not specified --user!"; exit 2; }
test -z "$pass" && { echo "Not specified --pass!"; exit 3; }

## Ubuntu/Debian
if command -v apt &> /dev/null; then command -v pip &> /dev/null || sudo apt install python3-pip -y; fi
command -v proxy &> /dev/null || sudo pip install --upgrade --prefix /usr/local proxy.py
sudo iptables -I INPUT 5 -p tcp --dport "$port" -m state --state NEW,ESTABLISHED -j ACCEPT

ip=$(curl -s 2ip.fun)

cmd="proxy --hostname 0.0.0.0 --port $port --basic-auth $user:$pass"

echo
echo "See: https://github.com/abhinavsingh/proxy.py#start-proxypy"
echo "Run: $cmd"
echo "IP:  $ip"
echo "Use: curl -x http://$user:$pass@$ip:$port https://2ip.fun"
echo

eval "$cmd"
