#!/bin/sh

systemctl stop caddy
systemctl disable caddy
rm /etc/systemd/system/caddy.service
systemctl daemon-reload
rm -rf /etc/caddy/
rm -f /usr/local/bin/caddy
