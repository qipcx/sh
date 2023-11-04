#!/bin/bash

if ! readlink /proc/$$/exe | grep 'bin/bash'; then curl -sL qip.cx/vps/vpn.sh | bash -s -- "$@"; exit; fi ## Run in bash

if command -v apt &> /dev/null; then command -v docker &> /dev/null || (sudo apt update -qq && sudo apt install docker.io -y -qq -o=Dpkg::Use-Pty=0); fi  ## 25 sec

if [[ -z $(id -nG | grep docker) ]]; then
  sudo usermod -aG docker "$USER"
  newgrp docker
fi

## Start docker and enable it to start after the system reboot:
#sudo systemctl enable --now docker

# 3333:1194 # https://api.ipify.org
docker run -d --rm --cap-add=NET_ADMIN -p 1194:1194/udp -p 80:8080/tcp -e HOST_ADDR="$(curl -s 2ip.fun)" --name dockovpn alekslitvinenk/openvpn ## -it

echo "Usage as:"
echo "docker exec dockovpn ./version.sh"
echo "docker exec dockovpn ./genclient.sh"
