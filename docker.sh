#!/bin/bash

## To Docker install & setup

if [ -z "$BASH_VERSION" ]; then curl -sL https://sh.qip.cx/ubuntu.sh | bash -s -- "$@"; exit; fi ## /usr/bin/dash ## ## Run in bash

#docker -v              ## Docker version 24.0.7
#docker compose version ## Docker Compose version v2.21.0

sudo apt install -y -qq apt-utils
curl -sSL https://get.docker.com/ | CHANNEL=stable sh

sudo apt install -y -qq uidmap
dockerd-rootless-setuptool.sh install

sudo systemctl enable --now docker

### Old version!!
##sudo apt install docker.io docker-compose -y -qq -o=Dpkg::Use-Pty=0
##sudo usermod -aG docker $USER

#sudo install -m 0755 -d /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#sudo chmod a+r /etc/apt/keyrings/docker.gpg
#echo \
#  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#sudo apt update
#sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
#sudo systemctl start docker
#sudo usermod -aG docker $USER
