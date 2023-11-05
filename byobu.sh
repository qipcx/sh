#!/bin/bash

## To Byobu install & setup

if [ -z "$BASH_VERSION" ]; then curl -sL https://sh.qip.cx/ubuntu.sh | bash -s -- "$@"; exit; fi ## /usr/bin/dash ## ## Run in bash

source <(curl -sL https://sh.qip.cx/helper.sh)

echo_info "⚑ Check dependencies.."
if command -v apt &> /dev/null; then command -v byobu &> /dev/null || sudo apt install byobu -y -qq -o=Dpkg::Use-Pty=0; fi
if command -v yum &> /dev/null; then command -v byobu &> /dev/null || sudo yum install byobu -y; fi ## sudo yum check-update; yum info byobu2 && echo OK || echo NO

status_path=~/.byobu/status

## @note Hack. Init the ~/.byobu directory & configs
if [ ! -f $status_path ]; then
  echo "⚑ Init ~/.byobu/ configs.."
  (nohup byobu >/dev/null 2>&1 &) > /dev/null
  sleep 3
  kill $(ps aux | grep byobu-shell | awk '{print $2}') >/dev/null 2>&1
fi

if [ -f $status_path ]; then
  echo "⚑ Update $status_path"
  sed -i 's/^tmux_left=.*$/tmux_left="logo #distro #release #arch #whoami #hostname session"/' $status_path
  sed -i 's/^tmux_right=.*$/tmux_right="network raid services processes load_average cpu_count cpu_freq memory swap disk disk_io uptime distro release updates_available reboot_required apport ip_address4 custom #date time"/' $status_path

  ## Load scripts to detect Real IP
  if [ -d  /usr/lib/byobu/ ]; then # ubuntu
    . /usr/lib/byobu/include/dirs && . /usr/lib/byobu/include/shutil && . /usr/lib/byobu/ip_address
  fi

  if [ -d /usr/libexec/byobu/ ]; then # centos 7
    . /usr/libexec/byobu/include/dirs && . /usr/libexec/byobu/include/shutil && . /usr/libexec/byobu/ip_address
  fi

  byobu_ip=$(__ip_address t 2> /dev/null)
  real_ip=$(curl -sL ip.qip.cx) ## 2ip.fun

  echo_info "Byoby IP:  $byobu_ip"
  echo_info "Real IP:   $real_ip"
  echo_info "Cached IP: $(cat $BYOBU_RUN_DIR/cache.$BYOBU_BACKEND/ip_address)"
  sleep 5

  if [ "$byobu_ip" != "$real_ip" ]; then
  echo_warn "You Byobu detect IP $byobu_ip is not equal to Real IP $real_ip"
  #You byobu IP 128.140.XX.XX is not equal real IP 2a01:000:0000:4192::1
  #⚑ Changed: IP_EXTERNAL=1 in the ~/.byobu/statusrc

  if confirm "Do you want to use IP_EXTERNAL=1 in the ~/.byobu/statusrc?"; then
    sed -i 's/.*IP_EXTERNAL=.*$/IP_EXTERNAL=1/' ~/.byobu/statusrc
    echo "⚑ Changed: IP_EXTERNAL=1 in the ~/.byobu/statusrc"
    sleep 3
  fi
fi

  byobu-ctrl-a emacs ## emacs | screen

  echo_help "Help to use:"
  echo_info "byobu"
  echo_info "byobu-enable"  ## Use to autostart byobu
  echo_info "nano $status_path"
  echo_info "sed -i 's^IP_EXTERNAL=1^IP_EXTERNAL=0^' ~/.byobu/statusrc"
  echo_info "sed -i 's^IP_EXTERNAL=0^IP_EXTERNAL=1^' ~/.byobu/statusrc"
  echo_info "byobu-ctrl-a emacs"
else
  echo "⚠ Config not found: $status_path"
  echo "Try start byobu and run script again"
  exit 1
fi

## @todo Replace in the ~/.bashrc
#case "$TERM" in
#    screen*|xterm|xterm-color|*-256color*) color_prompt=yes;;
#esac
