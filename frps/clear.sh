#!/bin/sh

set -e

rm -rf /usr/local/bin/frps
rm -rf /etc/frps/frps.ini
rm -rf /etc/caddy/caddy.d/frps.caddy
rm -rf /etc/systemd/system/frps.service
