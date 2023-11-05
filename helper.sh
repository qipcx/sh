#!/usr/bin/env bash

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
LIME_YELLOW=$(tput setaf 190)
YELLOW=$(tput setaf 3)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

function echo_error() { echo "${RED}${*}${NORMAL}" >&2; } ## echo -e '\033[31m RED \033[0m Normal'
function echo_warn() { echo "${YELLOW}${*}${NORMAL}"; }
function echo_help() { echo "${MAGENTA}${*}"${NORMAL}; }
function echo_info() { echo "${BLUE}${*}"${NORMAL}; }
#function echo_step() { echo "${BLUE}${*}"${NORMAL}; }

#function echo_confirm() {
#  read -n 1 -r -p "${LIME_YELLOW}${*} [Y/n] ${NORMAL}" reply;
#  echo
#  [[ -z "$reply" || "$reply" =~ ^([yY][eE][sS]|[yY])$ ]] || return 1;
#}

function confirm() {
    while true; do
        read -r -p "${LIME_YELLOW}${*} [Y/n]:${NORMAL} " reply </dev/tty; ## echo # -n 1
        ## @note </dev/tty allow to wait input for pipe: `curl .. | sh`
        case $reply in
            "" ) return 0;;
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes/no.";;
        esac
    done
}
