#!/bin/bash

if ! readlink /proc/$$/exe | grep 'bin/bash'; then curl -sL qip.cx/vps/ubuntu-20.04.sh | bash -s -- "$@"; exit; fi ## Run in bash

## Linked `sh` to `bash`
sudo ln -sf bash /bin/sh && readlink /bin/sh

sudo apt update -qq && sudo apt upgrade -y
#sudo hostnamectl set-hostname oracle-micro-ams2

[[ -f /etc/profile.d/bash_completion.sh ]] || sudo apt install bash-completion -y
#[[ -f /etc/profile.d/bash_completion.sh ]] && . /etc/profile.d/bash_completion.sh # Need load in shell

sudo timedatectl set-timezone Europe/Kiev
#timedatectl list-timezones | grep Kiev
#sudo systemctl restart mysql.service

command -v nano &> /dev/null || sudo apt install nano -y -qq -o=Dpkg::Use-Pty=0
command -v cron &> /dev/null || (sudo apt install cron -y -qq -o=Dpkg::Use-Pty=0 && sudo systemctl enable cron)
sudo apt install docker.io docker-compose -y -qq -o=Dpkg::Use-Pty=0
#sudo apt install python3-pip

echo "Do exec:"
echo ". /etc/profile.d/bash_completion.sh"
