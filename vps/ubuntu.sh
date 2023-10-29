#!/bin/bash

if ! readlink /proc/$$/exe | grep 'bin/bash'; then curl -sL qip.cx/vps/ubuntu.sh | bash -s -- "$@"; exit; fi ## Run in bash

## Linked `sh` to `bash`
sudo ln -sf bash /bin/sh && readlink /bin/sh

sudo apt update -qq && sudo apt upgrade -y -qq
#sudo hostnamectl set-hostname oracle-micro-ams2

[[ -f /etc/profile.d/bash_completion.sh ]] || sudo apt install bash-completion -y
#[[ -f /etc/profile.d/bash_completion.sh ]] && . /etc/profile.d/bash_completion.sh # Need load in shell

sudo timedatectl set-timezone Europe/Kiev
sudo localectl set-locale LC_TIME=C.UTF-8
#timedatectl list-timezones | grep Kiev
#sudo systemctl restart mysql.service

command -v nano &> /dev/null || sudo apt install nano -y -qq -o=Dpkg::Use-Pty=0
command -v cron &> /dev/null || (sudo apt install cron -y -qq -o=Dpkg::Use-Pty=0 && sudo systemctl enable cron)

read -r -n 1 -p "Do you want to install the Docker? [Y/n] " reply
if [[ -z "$reply" || "$reply" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  ## Old version!!
  #sudo apt install docker.io docker-compose -y -qq -o=Dpkg::Use-Pty=0
  #sudo usermod -aG docker $USER

  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
  sudo systemctl start docker
fi

read -r -n 1 -p "Do you want to install the Byobu? [Y/n] " reply
if [[ -z "$reply" || "$reply" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  bash <(curl -s qip.cx/vps/byobu.sh)
fi

#sudo apt install python3-pip

echo "Do exec:"
echo ". /etc/profile.d/bash_completion.sh"
echo 'bind '"\C-h": backward-kill-word''
