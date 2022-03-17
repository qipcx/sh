#!/bin/bash

shell=$(readlink /proc/$$/exe) # /usr/bin/bash
if ! [ "$shell" = "/usr/bin/bash" ]; then
  #echo "Run in bash:"
  #echo "bash <(curl -sL qip.cx/vps/terminal.sh)"
  #exit 1
  curl -sL qip.cx/vps/terminal.sh | bash
fi

bind -p > ~/.inputrc-restore 2>/dev/null

#bind '"\C-h": backward-kill-word' # Ctrl+Backspace
#bind '"\C-k": unix-line-discard'  # Kill line
#bind '"\C-j": undo'  # Undo kill

tee ~/.inputrc cat > /dev/null <<EOT
# Ctrl+Backspace
"\C-h": backward-kill-word

"\C-k": unix-line-discard
"\C-j": undo

# History search by begin text
"\e[A": history-search-backward
"\e[B": history-search-forward

# Дополнение по одиночному Tab, вместо двойной Tab
#set show-all-if-ambiguous on
EOT

bind -f ~/.inputrc 2>/dev/null

echo "Use to restore/reset settings:"
echo 'stty sane && bind -f ~/.inputrc-restore'
