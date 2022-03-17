#!/bin/bash

shell=$(readlink /proc/$$/exe) # /usr/bin/bash
if ! [ "$shell" = "/usr/bin/bash" ]; then
  echo "Run in bash:"
  echo "bash <(curl -sL qip.cx/vps/terminal.sh)"
  exit 1
fi

bind -p > ~/.inputrc-restore

bind '"\C-h": backward-kill-word' # Ctrl+Backspace
bind '"\e[A": history-search-backward' # History search by begin text
bind '"\e[B": history-search-forward'  # History search by begin text

stty kill undef
bind '"\C-u": undo'
stty kill ^K

tee ~/.inputrc cat > /dev/null <<EOT
# Ctrl+Backspace
"\C-h": backward-kill-word

# Ctrl+Delete
#"\e[3;5~": kill-word

# Ctrl+Left/Right
#"\e[1;5D": backward-word
#"\e[1;5C": forward-word

# History search by begin text
"\e[A": history-search-backward
"\e[B": history-search-forward

# Дополнение Tab, двойной Tab
#set show-all-if-ambiguous on
EOT

echo "Use to restore/reset settings:"
echo 'stty sane && bind -f ~/.inputrc-restore'
