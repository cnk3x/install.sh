#!/usr/bin/env bash

systemctl stop v2ray
systemctl disable v2ray
rm -f /etc/systemd/system/v2ray.service
systemctl daemon-reload
rm -rf /etc/v2ray/
rm -rf /usr/local/v2ray
rm -rf /etc/caddy/caddy.d/v2ray.caddy
