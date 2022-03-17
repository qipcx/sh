#!/bin/bash

shell=$(readlink /proc/$$/exe) # /usr/bin/bash
if ! [ "$shell" = "/usr/bin/bash" ]; then
  curl -sL qip.cx/vps/terminal.sh | bash
  exit
fi

bind -p > ~/.inputrc-restore 2>/dev/null

bind '"\C-h": backward-kill-word' 2>/dev/null # Ctrl+Backspace
bind '"\C-k": unix-line-discard'  2>/dev/null # Kill line
bind '"\C-j": undo' 2>/dev/null # Undo kill

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

echo "To Restore settings:"
echo 'stty sane && bind -f ~/.inputrc-restore'
echo "To Apply settings:"
echo "bind -f ~/.inputrc"
