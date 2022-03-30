#!/bin/bash

if ! readlink /proc/$$/exe | grep 'bin/bash' > /dev/null; then curl -sL qip.cx/vps/terminal.sh?dev | bash -s -- "$@"; exit; fi ## Run in bash

bind -p > ~/.inputrc-backup.conf 2>/dev/null

#cat <<<EOF
#bind '"\C-h": backward-kill-word'
#bind '"\e[3;5~": kill-word'  ## Ctrl+Del
#bind '"\e[3;2~": kill-whole-line'
#bind '"\e[1~" beginning-of-line'
#bind '"\e[4~" end-of-line'
#bind '"\e[A": history-search-backward'
#bind '"\e[B": history-search-forward'
#EOF

## Not works from script
#bind '"\C-h": backward-kill-word' 2>/dev/null   ## Ctrl+Backspace


tee ~/.inputrc cat > /dev/null <<EOT
## Ctrl+Backspace
"\C-h": backward-kill-word

## Ctrl+Del
"\e[3;5~": kill-word

## Shift+Delete
"\e[3;2~": kill-whole-line

## Ctrl+Left/Right
"\e[1;5D": backward-word
"\e[1;5C": forward-word

## Home/End
#"\e[1~" beginning-of-line
#"\e[4~" end-of-line

## History search by begin text
"\e[A": history-search-backward
"\e[B": history-search-forward

## Copy current command to "kill buffer"
#"\C-k": unix-line-discard
#"\C-j": copy-region-as-kill
#"\C-j": undo

## Command completion by single Tab, instead double Tab
#set show-all-if-ambiguous on
EOT

## Not works from script
#bind -f ~/.inputrc 2>/dev/null

echo "🛈 Restore keybindings:  bind -f ~/.inputrc-backup.conf"
#echo 'stty sane && bind -f ~/.inputrc-backup.conf'
echo "🛈 Apply keybindings: ☛ bind -f ~/.inputrc"

#Configure Byobu's ctrl-a behavior...
#
#When you press ctrl-a in Byobu, do you want it to operate in:
#    (1) Screen mode (GNU Screen's default escape sequence)
#    (2) Emacs mode  (go to beginning of line)
#
#Note that:
#  - F12 also operates as an escape in Byobu
#  - You can press F9 and choose your escape character
#  - You can run 'byobu-ctrl-a' at any time to change your selection
#
#Select [1 or 2]:
