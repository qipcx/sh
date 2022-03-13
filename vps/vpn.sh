#!/bin/bash

if command -v apt &> /dev/null; then command -v docker &> /dev/null || (sudo apt update && sudo apt install docker.io -y); fi  ## 25 sec

if [[ -z $(id -nG | grep docker) ]]; then
  sudo usermod -aG docker "$USER"
  newgrp docker
fi

## Start docker and enable it to start after the system reboot:
#sudo systemctl enable --now docker

# 3333:1194
docker run -it --rm --cap-add=NET_ADMIN -p 1194:1194/udp -p 80:8080/tcp -e HOST_ADDR=$(curl -s https://api.ipify.org) --name dockovpn alekslitvinenk/openvpn

#docker exec dockovpn ./version.sh
#docker exec dockovpn ./genclient.sh
