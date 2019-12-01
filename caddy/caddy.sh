#!/bin/sh
set -ex

baseURL="https://raw.githubusercontent.com/shuxs/install.sh/master/caddy/"
mkdir -p /etc/caddy
wget --no-cache -O /usr/local/bin/caddy ${baseURL}/caddy
wget --no-cache -O /etc/systemd/system/caddy.service ${baseURL}/caddy.service
wget --no-cache -O /etc/caddy/Caddyfile ${baseURL}/Caddyfile
chmod +x /usr/local/bin/caddy
systemctl daemon-reload
