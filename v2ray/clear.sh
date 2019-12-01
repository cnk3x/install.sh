#!/bin/sh

systemctl stop v2ray
systemctl disable v2ray
rm /etc/systemd/system/v2ray.service
systemctl daemon-reload
rm -rf /etc/v2ray/
rm -ff /usr/local/v2ray
