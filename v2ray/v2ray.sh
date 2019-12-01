#!/bin/sh

baseURL="https://raw.githubusercontent.com/shuxs/install.sh/master/v2ray/"

if [ -f "/usr/local/v2ray/v2ray" ]; then
    echo "v2ray 已存在"
    exit 1
fi

if [ -f "/etc/systemd/system/v2ray.service" ]; then
    echo "v2ray.service 已存在"
    exit 1
fi

set -e

h2host=$1
h2domain=$2
uid=$(cat /proc/sys/kernel/random/uuid)

mkdir -p /etc/v2ray /usr/local/v2ray /etc/v2ray /data/www/${h2host}

curl -sSL -o /usr/local/v2ray/v2ray ${baseURL}/v2ray
curl -sSL -o /usr/local/v2ray/v2ctl ${baseURL}/v2ctl
curl -sSL -o /usr/local/v2ray/geoip.dat ${baseURL}/geoip.dat
curl -sSL -o /usr/local/v2ray/geosite.dat ${baseURL}/geosite.dat

curl -sSL -o /etc/systemd/system/v2ray.service ${baseURL}/v2ray.service
curl -sSL -o /etc/v2ray/config.json ${baseURL}/config.json

sed -i "s/{h2host}/${h2host}/g" /etc/v2ray/config.json
sed -i "s/{h2domain}/${h2domain}/g" /etc/v2ray/config.json
sed -i "s/{uid}/${uid}/g" /etc/v2ray/config.json

sed -i "s/{h2host}/${h2host}/g" /etc/caddy/caddy.d/v2ray.caddy
sed -i "s/{h2domain}/${h2domain}/g" /etc/caddy/caddy.d/v2ray.caddy
sed -i "s/{uid}/${uid}/g" /etc/caddy/caddy.d/v2ray.caddy

chmod +x /usr/local/v2ray/v2ray
chmod +x /usr/local/v2ray/v2ctl

systemctl daemon-reload
