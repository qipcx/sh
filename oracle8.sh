#!/bin/bash

sudo yum update

# yum repolist | grep ol7_developer_EPEL/x86_64

# yum install oraclelinux-developer-release-el7
# yum install oracle-epel-release-el7

# yum install oraclelinux-developer-release-el8
# yum install oracle-epel-release-el8

sudo yum-config-manager --enable ol7_developer_EPEL > /dev/null && echo OK || echo Fail
sudo yum-config-manager --enable ol7_developer > /dev/null && echo OK || echo Fail
sudo yum update

sudo apt install bash-completion && . /etc/profile.d/bash_completion.sh

sudo timedatectl set-timezone Europe/Kiev
#timedatectl list-timezones | grep Kiev
#sudo systemctl restart mysql.service

command -v nano &> /dev/null || sudo apt install nano -y ## @todo А если yum

read -r -n 1 -p "Install the Byobu? [Y/n] " reply
if [[ -z "$reply" || "$reply" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo
  echo "Byobu"
fi

#read -r -n 1 -p "Install the Proxy.py? [Y/n] " reply
#if [[ -z "$reply" || "$reply" =~ ^([yY][eE][sS]|[yY])$ ]]; then
#  echo
#  echo "Proxy.py"
#  read -r -p "Proxy port (55132):" port
#  port=${port:-55132}
#  read -r -p "Proxy user: " proxyuser
#  read -r -p "Proxy pass: " proxypass
#  sudo apt install pip -y && sudo pip install --upgrade --prefix /usr/local proxy.py
#  #sudo iptables -I INPUT 5 -i ens3 -p tcp --dport "$port" -m state --state NEW,ESTABLISHED -j ACCEPT
#  echo "See: https://github.com/abhinavsingh/proxy.py#start-proxypy"
#  curl ifconfig.co
#  proxy --hostname 0.0.0.0 --port "$port" --basic-auth "$proxyuser:$proxypass"
#fi
