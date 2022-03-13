#!/bin/bash

tee ~/.inputrc cat > /dev/null <<EOT
# Ctrl+Backspace
"\C-h": backward-kill-word

# Ctrl+Delete
"\e[3;5~": kill-word

# Ctrl+Left/Right
"\e[1;5D": backward-word
"\e[1;5C": forward-word

# История команд по начальному вхождению
"\e[A": history-search-backward
"\e[B": history-search-forward

# Дополнение Tab, двойной Tab
#set show-all-if-ambiguous on
EOT
