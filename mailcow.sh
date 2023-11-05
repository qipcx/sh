#!/usr/bin/env bash

## To Mailcow install
## @see https://github.com/mailcow/mailcow-dockerized

if [ -z "$BASH_VERSION" ]; then curl -sL https://sh.qip.cx/mailcow.sh | bash -s -- "$@"; exit; fi ## /usr/bin/dash ## ## Run in bash

source <(curl -sL https://sh.qip.cx/helper.sh)

[[ $USER == root ]] || { echo_error "You need to tun script as root!"; echo_help "Use: sudo su"; exit 1; }
[[ $(uname -m) == aarch64 ]] && { echo_error "Not supported aarch64 :("; exit 1; } ## x86_64 | aarch64

echo_warn "Mailcow will be installed in the current directory: ${PWD}"
if ! confirm "Are you sure?"; then echo_warn "Skip installation.. Exit"; exit; fi
echo "Started installation Mailcow.."

#mkdir mailcow; cd mailcow/ || exit 1
test -z $(docker info | grep selinux) && ! test -f /etc/docker/daemon.json && echo '{ "selinux-enabled": true }' | sudo tee /etc/docker/daemon.json
git clone https://github.com/mailcow/mailcow-dockerized .
./generate_config.sh ## mail.qip.cx

echo_info "You can edit config: nano mailcow.conf"; sleep 5

#sudo sysctl -w net.core.somaxconn=65535
#sudo sysctl -w net.ipv4.ip_unprivileged_port_start=25
##echo 'net.ipv4.ip_unprivileged_port_start=465' | sudo tee -a /etc/sysctl.conf
##echo 465 | sudo tee /proc/sys/net/ipv4/ip_unprivileged_port_start

echo_info "Starting: docker compose up -d"; sleep 5
docker compose up -d
## @see https://img.qip.cx/2023/11/mailcow-installation-process.png

echo_info "Use: docker compose up -d"

#docker compose rm --force --volumes  ## Delete all containers & volumes
#docker system prune -a
