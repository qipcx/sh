## sh.qip.cx

Using any location:
```
raw.githubusercontent.com/qipcx/sh/main/proxy.sh ## View
cdn.jsdelivr.net/gh/qipcx/sh@main/proxy.sh       ## Download
sh.qip.cx/proxy.sh
```

* Set a short `/bin/sh` link to *bash* for simplify typing (or use `bash` instead `sh`): 
```shell
sudo ln -sf bash /bin/sh
```

Utils:
```shell
curl ip.qip.cx

curl sh.qip.cx
curl sh.qip.cx/headers.php?json

curl -sL sh.qip.cx/ubuntu.sh | sh
curl -sL sh.qip.cx/docker.sh | sh

curl sh.qip.cx/terminal.sh | sh
curl sh.qip.cx/byobu.sh | sh
bash <(curl -s sh.qip.cx/byobu-ol9.sh)

curl sh.qip.cx/proxy.sh | bash -s -- --port=XXXXX --user=user --pass=XXXXX
bash <(curl -s sh.qip.cx/proxy.sh)
curl sh.qip.cx/vpn.sh | sh
bash <(curl -s sh.qip.cx/wg.sh)

curl -sL sh.qip.cx/mailcow.sh | sh
curl -sL sh.qip.cx/nginx-watch-reload.sh | sh
```
