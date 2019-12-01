#!/bin/sh

caddyUrl="https://raw.githubusercontent.com/shuxs/install.sh/master/caddy/"

if [ -x "$(which caddy)" ]; then
    echo "caddy已存在"
    exit 1
fi

if [ -f "/etc/systemd/system/caddy.service" ]; then
    echo "caddy.service 已存在"
    exit 1
fi

set -ex

mkdir -p /etc/caddy
curl -sSL -o /usr/local/bin/caddy ${caddyUrl}/caddy
curl -sSL -o /etc/systemd/system/caddy.service ${caddyUrl}/caddy.service
curl -sSL -o /etc/caddy/Caddyfile ${caddyUrl}/Caddyfile
chmod +x /usr/local/bin/caddy
systemctl daemon-reload
