#!/bin/sh
set -ex

baseURL="https://raw.githubusercontent.com/shuxs/install.sh/master/caddy/"
mkdir -p /etc/caddy
curl -sSL -o /usr/local/bin/caddy ${baseURL}/caddy
curl -sSL -o /etc/systemd/system/caddy.service ${baseURL}/caddy.service
curl -sSL -o /etc/caddy/Caddyfile ${baseURL}/Caddyfile
chmod +x /usr/local/bin/caddy
systemctl daemon-reload
