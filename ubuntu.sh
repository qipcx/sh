#!/bin/bash

if [ -z "$BASH_VERSION" ]; then curl -sL https://sh.qip.cx/ubuntu.sh | bash -s -- "$@"; exit; fi ## /usr/bin/dash ## ## Run in bash

source <(curl -sL https://sh.qip.cx/helper.sh)


sh_type=$(readlink /bin/sh)
if ! [[ $sh_type =~ bash ]]; then
  if confirm "Do you want to link \"sh\" to \"bash\" (current: $sh_type)?"; then
    sudo ln -sf bash /bin/sh
    echo "readlink /bin/sh ## $(readlink /bin/sh)"
  fi
fi

echo_info "Do update & upgrade packages..."; sleep 3
sudo apt update -qq && sudo apt upgrade -y -qq
#sudo hostnamectl set-hostname oracle-micro-ams2

echo_info "Do install bash-completion"; sleep 3
[[ -f /etc/profile.d/bash_completion.sh ]] || sudo apt install bash-completion -y

echo_info "Do setup timezone & locale"; sleep 3
sudo timedatectl set-timezone Europe/Kiev
#timedatectl list-timezones | grep Kiev
sudo localectl set-locale LC_TIME=C.UTF-8

#sudo apt install -y -qq apt-utils

echo_info "Do install nano, cron, iputils-ping..."; sleep 3
command -v nano &> /dev/null || sudo apt install nano -y -qq -o=Dpkg::Use-Pty=0
command -v cron &> /dev/null || (sudo apt install cron -y -qq -o=Dpkg::Use-Pty=0 && sudo systemctl enable cron)
command -v ping &> /dev/null || sudo apt install iputils-ping -y -qq -o=Dpkg::Use-Pty=0

if confirm "Do you want to install the Docker?"; then
  bash <(curl sh.qip.cx/docker.sh)
fi

if confirm "Do you want to install the Byobu?"; then
  bash <(curl -s sh.qip.cx/byobu.sh)
fi

if confirm "Do you want to apply Git Aliases?"; then
  git config --global alias.co checkout
  git config --global alias.ci commit
  git config --global alias.st status
  git config --global alias.br branch
  git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
  git config --global alias.type 'cat-file -t'
  git config --global alias.dump 'cat-file -p'
fi

#sudo apt install python3-pip
#sudo systemctl restart mysql.service

echo_help 'su -s ${USER}                       ## Apply docker permissions'
echo_help '. /etc/profile.d/bash_completion.sh ## Apply Shell Completion'
echo_help "bind '\"\C-h\": backward-kill-word'   ## Apply Ctrl+Backspace"
## bind '"\C-h": backward-kill-word'
