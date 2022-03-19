#!/bin/bash

[ "$(readlink /proc/$$/exe)" = /usr/bin/bash ] || { curl -sL qip.cx/vps/ubuntu-20.04.sh | bash -s -- "$@"; exit; } ## Run in bash

## Linked `sh` to `bash`
sudo ln -sf bash /bin/sh && readlink /bin/sh

#sudo hostnamectl set-hostname oracle-micro-ams2

sudo apt update -qq && sudo apt upgrade -y

[[ -f /etc/profile.d/bash_completion.sh ]] || sudo apt install bash-completion -y
#[[ -f /etc/profile.d/bash_completion.sh ]] && . /etc/profile.d/bash_completion.sh # Need load in shell

sudo timedatectl set-timezone Europe/Kiev
#timedatectl list-timezones | grep Kiev
#sudo systemctl restart mysql.service

command -v nano &> /dev/null || sudo apt install nano -y
command -v cron &> /dev/null || (sudo apt install cron -y && sudo systemctl enable cron)
sudo apt install docker.io docker-compose -y

#read -r -n 1 -p "Install the Byobu? [Y/n] " reply
#if [[ -z "$reply" || "$reply" =~ ^([yY][eE][sS]|[yY])$ ]]; then
#  echo
#  echo "Byobu"
#fi

# sudo apt install python3-pip

echo "Exec this steep:"
echo ". /etc/profile.d/bash_completion.sh"
