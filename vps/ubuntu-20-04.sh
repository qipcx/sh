#!/bin/bash

sudo apt update -qq && sudo apt upgrade -y

## Linked `sh` to `bash`
sudo ln -sf bash /bin/sh

[[ ! -f /etc/profile.d/bash_completion.sh ]] && (sudo apt install bash-completion -y && . /etc/profile.d/bash_completion.sh)

sudo timedatectl set-timezone Europe/Kiev
#timedatectl list-timezones | grep Kiev
#sudo systemctl restart mysql.service

command -v nano &> /dev/null || sudo apt install nano -y

read -r -n 1 -p "Install the Byobu? [Y/n] " reply
if [[ -z "$reply" || "$reply" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo
  echo "Byobu"
fi

# sudo apt install python3-pip
