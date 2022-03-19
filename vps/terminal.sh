#!/bin/bash

[ "$(readlink /proc/$$/exe)" = /usr/bin/bash ] || { curl -sL qip.cx/vps/terminal.sh | bash -s -- "$@"; exit; } ## Run in bash

bind -p > ~/.inputrc-backup.conf 2>/dev/null

## Not works from script
#bind '"\C-h": backward-kill-word' 2>/dev/null # Ctrl+Backspace

tee ~/.inputrc cat > /dev/null <<EOT
## Ctrl+Backspace. Ломает Ctrl+K!
"\C-h": backward-kill-word

## Copy current command to "kill buffer"
"\C-j": copy-region-as-kill

#"\C-k": unix-line-discard
#"\C-j": undo

## History search by begin text
"\e[A": history-search-backward
"\e[B": history-search-forward

## Command completion by single Tab, instead double Tab
#set show-all-if-ambiguous on
EOT

## Not works from script
bind -f ~/.inputrc 2>/dev/null

echo "🛈 To Restore settings:  bind -f ~/.inputrc-backup.conf"
#echo 'stty sane && bind -f ~/.inputrc-backup.conf'
echo "🛈 To Apply settings:    bind -f ~/.inputrc"
