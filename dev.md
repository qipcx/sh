```shell
docker compose up
docker compose exec nginx sh
```

```shell
#curl sh.qip.cx/ubuntu.sh | sh ## не работает интерактив
#curl sh.qip.cx/terminal.sh | sh -s option=valus
#curl sh.qip.cx/byobu.sh | bash      ## не работает интерактив
bash <(curl -s https://raw.githubusercontent.com/qipcx/sh/main/proxy.sh) --port=XXXXX --user=... --pass=...
```

SSL:
```shell
sudo certbot --nginx -d qip.cx -d www.qip.cx -d sh.qip.cx -d ip.qip.cx -d img.qip.cx -d tmp.qip.cx
```
