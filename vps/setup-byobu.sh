#!/bin/bash

if command -v apt &> /dev/null; then command -v byobu &> /dev/null || sudo apt install byobu -y; fi

#touch ~/.byobu/status

byobu

config='
# Tmux отображает одну строку состояния разделенную на 2 части
tmux_left="logo #distro #release #arch #whoami #hostname session"

# Вы можете настроить несколько правых строк и циклически перемещаться между ними с помощью Shift+F5
tmux_right="network raid services processes load_average cpu_count cpu_freq memory swap disk disk_io uptime distro release updates_available reboot_required apport ip_address date time"
'

echo "$config" > ~/.byobu/status
