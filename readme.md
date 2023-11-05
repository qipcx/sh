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

bash <(curl -s sh.qip.cx/ubuntu.sh)
bash <(curl -s sh.qip.cx/docker.sh)
curl sh.qip.cx/terminal.sh | sh
bash <(curl -s sh.qip.cx/byobu-ol9.sh)
bash <(curl -s sh.qip.cx/byobu.sh)
curl sh.qip.cx/proxy.sh | bash -s -- --port=XXXXX --user=user --pass=XXXXX
bash <(curl -s sh.qip.cx/proxy.sh)
curl sh.qip.cx/vpn.sh | sh
bash <(curl -s sh.qip.cx/wg.sh)

bash <(curl -s sh.qip.cx/mailcow.sh)
curl sh.qip.cx/nginx-watch-reload.sh | sh
```
