#!/bin/bash

[ "$(readlink /proc/$$/exe)" = /usr/bin/bash ] || { curl -sL qip.cx/vps/byobu.sh | bash -s -- "$@"; exit; } ## Run in bash

echo "⚑ Check dependencies.."
if command -v apt &> /dev/null; then command -v byobu &> /dev/null || sudo apt install byobu -y; fi
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
  sed -i 's/^tmux_right=.*$/tmux_right="network raid services processes load_average cpu_count cpu_freq memory swap disk disk_io uptime distro release updates_available reboot_required apport ip_address custom #date time"/' $status_path

  ## Test Real IP
  if [ -d  /usr/lib/byobu/ ]; then # ubuntu
    . /usr/lib/byobu/include/dirs && . /usr/lib/byobu/include/shutil && . /usr/lib/byobu/ip_address
  fi

  if [ -d /usr/libexec/byobu/ ]; then # centos 7
    . /usr/libexec/byobu/include/dirs && . /usr/libexec/byobu/include/shutil && . /usr/libexec/byobu/ip_address
  fi

  byobu_ip=$(__ip_address t 2> /dev/null)
  #real_ip=$(curl -s http://checkip.amazonaws.com/)
  real_ip=$(curl -s 2ip.fun)

  if [ "$byobu_ip" != "$real_ip" ]; then
    echo "You byobu IP $byobu_ip is not equal real IP $real_ip"
    #read -r -n 1 -p "Switch ~/.byobu/statusrc config to show real IP? [Y/n] " reply
    #if [[ -z "$reply" || "$reply" =~ ^([yY][eE][sS]|[yY])$ ]]; then  ## @todo Replace for sh: 35: Syntax error: "(" unexpected (expecting "then")
    if true; then
      #echo # need for reply
      sed -i 's/.*IP_EXTERNAL=.*$/IP_EXTERNAL=1/' ~/.byobu/statusrc
      echo "⚑ Changed: IP_EXTERNAL=1 in the ~/.byobu/statusrc"
      echo
      echo "You can change it:"
      echo "sed -i 's^IP_EXTERNAL=1^IP_EXTERNAL=0^' ~/.byobu/statusrc"
      echo "sed -i 's^IP_EXTERNAL=0^IP_EXTERNAL=1^' ~/.byobu/statusrc"
      echo "nano $status_path"
      echo
    fi
  fi

  #byobu-enable
  echo "Run: byobu"
  #byobu # Error: open terminal failed: not a terminal
else
  echo "⚠ Config not found: $status_path"
  echo "Try start byobu and run script again"
  exit 1
fi
