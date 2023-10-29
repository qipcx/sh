## Sorbing Utils

Use any location:
```text
raw.githubusercontent.com/sorbing/utils/main/vps/proxy.sh ## Cross-Origin Read Blocking (CORB)
cdn.jsdelivr.net/gh/sorbing/utils@main/vps/proxy.sh
qip.cx/vps/proxy.sh
```

* Set a short `/bin/sh` link to *bash* for simplify typing (or use `bash` instead `sh`): 
```shell
sudo ln -sf bash /bin/sh
```

```shell
curl qip.cx/vps/ubuntu.sh | sh
curl qip.cx/vps/terminal.sh | sh
#curl qip.cx/vps/terminal.sh | sh -s option=valus

bash <(curl -s qip.cx/vps/byobu-ol9.sh)
bash <(curl -s qip.cx/vps/byobu.sh)
#curl qip.cx/vps/byobu.sh | bash      ## не работает интерактив

curl qip.cx/vps/proxy.sh | bash -s -- --port=XXXXX --user=user --pass=XXXXX
curl qip.cx/vps/vpn.sh | sh
bash <(curl -s qip.cx/vps/wg.sh)

bash <(curl -s qip.cx/vps/proxy.sh)
bash <(curl -s https://raw.githubusercontent.com/sorbing/utils/main/vps/proxy.sh)
bash <(curl -s https://raw.githubusercontent.com/sorbing/utils/main/vps/proxy.sh) --port=XXXXX --user=... --pass=...
```
