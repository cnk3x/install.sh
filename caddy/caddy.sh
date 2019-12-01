#!/bin/sh

caddyUrl="https://raw.githubusercontent.com/shuxs/install.sh/master/caddy/"

if [ -x "$(which caddy)" ]; then
    echo "caddy已存在"
    exit 1
fi

if [ -f "/etc/systemd/system/caddy.service" ]; then
    echo "caddy.service 已存在"
fi

set -e

mkdir -p /etc/caddy/caddy.d /etc/caddy/cert
curl -Ss -o /usr/local/bin/caddy ${caddyUrl}/caddy
curl -Ss -o /etc/systemd/system/caddy.service ${caddyUrl}/Caddyfile
chmod +x /usr/local/bin/caddy
systemctl daemon-reload
