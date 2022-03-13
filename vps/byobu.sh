#!/bin/bash

if command -v apt &> /dev/null; then command -v byobu &> /dev/null || sudo apt install byobu -y; fi

(nohup byobu >/dev/null 2>&1 &) > /dev/null
sleep 3
kill $(ps aux | grep byobu-shell | awk '{print $2}') >/dev/null 2>&1

status_path=~/.byobu/status

if [[ -f $status_path ]]; then
  sed -i 's/^tmux_left=.*$/tmux_left="logo #distro #release #arch #whoami #hostname session"/' $status_path
  sed -i 's/^tmux_right=.*$/tmux_right="network raid services processes load_average cpu_count cpu_freq memory swap disk disk_io uptime distro release updates_available reboot_required apport ip_address custom date time"/' $status_path

  ## Test Real IP
  . /usr/lib/byobu/include/dirs
  . /usr/lib/byobu/include/shutil
  . /usr/lib/byobu/ip_address
  byobu_ip=$(__ip_address t 2> /dev/null)
  real_ip=$(curl -s http://checkip.amazonaws.com/)

  if [[ "$byobu_ip" != "$real_ip" ]]; then
    echo "You byobu IP $byobu_ip is not equal real IP $real_ip"
    read -r -n 1 -p "Switch ~/.byobu/statusrc config to show real IP? [Y/n] " reply
    if [[ -z "$reply" || "$reply" =~ ^([yY][eE][sS]|[yY])$ ]]; then
      echo
      sed -i 's/.*IP_EXTERNAL=.*$/IP_EXTERNAL=1/' ~/.byobu/statusrc
      echo "Changed: IP_EXTERNAL=1 in the ~/.byobu/statusrc"
    fi
  fi

  #byobu-enable
  echo "Run: byobu"
else
  echo "⚠ Config not found: $status_path"
  echo "Try start byobu and run script again"
  exit 1
fi
