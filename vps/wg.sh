#!/bin/bash

if ! readlink /proc/$$/exe | grep 'bin/bash'; then curl -sL qip.cx/vps/wg.sh | bash -s -- "$@"; exit; fi ## Run in bash

[ "${-#*s}" = "$-" ] || { echo "⚠ Run as: bash <(curl qip.cx/vps/wg.sh)"; bash <(curl -sL qip.cx/vps/wg.sh) -s -- "$@"; exit 0; } ## Exec from stdin. Try run with `read` support
# @todo Required run as: bash <(curl qip.cx/vps/wg.sh?dev)

if ! command -v wg-quick &> /dev/null; then
  curl -sL https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh -O
  chmod +x wireguard-install.sh
  sudo ./wireguard-install.sh
fi

## 94.140.14.14,  94.140.15.15  | DNS "По умолчанию": блокирует рекламу, счетчики и фишинговые сайты
## 94.140.14.15,  94.140.15.16  | DNS "Семейный":     блокирует рекламу, счетчики, фишинговые и "взрослые" сайты, а также включить безопасный поиск
## 94.140.14.140, 94.140.14.141 | DNS "Нефильтрующий": не фильтруют какие-либо элементы

echo
echo "Example usage:"
echo "./wireguard-install.sh              ## To add client or uninstall"
echo "wg-quick down wg0                   ## To disconnect interface wg0"
echo "sudo nano /etc/wireguard/wg0.conf   ## To edit interface wg0"
echo "sudo systemctl restart wg-quick@wg0 ## ... and apply changes"
