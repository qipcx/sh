#!/bin/bash

if ! readlink /proc/$$/exe | grep 'bin/bash'; then curl -sL qip.cx/vps/proxy.sh | bash -s -- "$@"; exit; fi ## Run in bash

function randval() {
  cat /dev/urandom | tr -dc "${1:-"a-zA-Z0-9"}" | fold -w "${2:-12}" | head -n 1
}

port=$(echo -n "$@" | grep -Po '(?<=--port[=| ])[^ "]+')
user=$(echo -n "$@" | grep -Po '(?<=--user[=| ])[^ "]+')
pass=$(echo -n "$@" | grep -Po '(?<=--pass[=| ])[^ "]+')

rand_user=$(randval 'a-z' 6)
rand_pass=$(randval 'a-zA-Z0-9#_%^&' 12)
rand_port="5"$(randval '0-9' 4)

test -n "$user" || read -r -p "Proxy user ($rand_user): " user </dev/tty
test -z "$pass" && read -r -p "Proxy pass ($rand_pass): " pass </dev/tty
test -z "$port" && read -r -p "Proxy port ($rand_port): " port </dev/tty

user=${user:-$rand_user}
pass=${pass:-$rand_pass}
port=${port:-$rand_port}

test -z "$port" && { echo "Not specified --port!"; exit 1; }
test -z "$user" && { echo "Not specified --user!"; exit 2; }
test -z "$pass" && { echo "Not specified --pass!"; exit 3; }

## Ubuntu/Debian
if command -v apt &> /dev/null; then command -v pip &> /dev/null || sudo apt install python3-pip -y; fi
command -v proxy &> /dev/null || sudo pip install --upgrade --prefix /usr/local proxy.py

command -v proxy &> /dev/null || { echo "Не удалось установить proxy.py!"; exit 9; }

sudo iptables -I INPUT 1 -p tcp --dport "$port" -m state --state NEW,ESTABLISHED -j ACCEPT
# OR: sudo iptables -I INPUT 1 -i ens3 -p tcp --dport XXXXX -j ACCEPT
# OR: sudo iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
cmd="proxy --hostname 0.0.0.0 --port $port --basic-auth $user:$pass"

ip=$(curl -s 2ip.fun)

echo
echo "See: https://github.com/abhinavsingh/proxy.py#start-proxypy"
echo "Run: $cmd"
echo "IP:  $ip"
echo "Use: curl -x http://$user:$pass@$ip:$port https://2ip.fun"
echo

eval "$cmd"
