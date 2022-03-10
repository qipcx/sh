#!/bin/bash

if command -v apt &> /dev/null; then command -v byobu &> /dev/null || sudo apt install byobu -y; fi

(nohup byobu >/dev/null 2>&1 &) > /dev/null
sleep 2
kill $(ps aux | grep byobu-shell | awk '{print $2}') >/dev/null 2>&1

status_path=~/.byobu/status

if [[ -f status_path ]]; then
  sed -i 's/^tmux_left=.*$/tmux_left="logo #distro #release #arch #whoami #hostname session"/' $status_path
  sed -i 's/^tmux_right=.*$/tmux_right="network raid services processes load_average cpu_count cpu_freq memory swap disk disk_io uptime distro release updates_available reboot_required apport ip_address date time"/' status_path

  byobu-enable
  echo "Run: byobu"
else
  echo "⚠ Config not found: $status_path"
  echo "Try start byobu and run script again"
  exit 1
fi
