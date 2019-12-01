#!/bin/sh

set -ex
baseURL="https://raw.githubusercontent.com/shuxs/install.sh/master/v2ray"

h2host=$1
h2domain=$2
uid=$(cat /proc/sys/kernel/random/uuid)

mkdir -p /etc/v2ray /usr/local/v2ray /etc/v2ray /etc/caddy/caddy.d /data/www/${h2host}

wget --no-cache -O /usr/local/v2ray/v2ray ${baseURL}/v2ray
wget --no-cache -O /usr/local/v2ray/v2ctl ${baseURL}/v2ctl
wget --no-cache -O /usr/local/v2ray/geoip.dat ${baseURL}/geoip.dat
wget --no-cache -O /usr/local/v2ray/geosite.dat ${baseURL}/geosite.dat
wget --no-cache -O /etc/v2ray/config.json ${baseURL}/config.json
wget --no-cache -O /etc/caddy/caddy.d/v2ray.caddy ${baseURL}/v2ray.caddy
wget --no-cache -O /etc/systemd/system/v2ray.service ${baseURL}/v2ray.service

sed -i "s/{h2host}/${h2host}/g" /etc/v2ray/config.json
sed -i "s/{h2domain}/${h2domain}/g" /etc/v2ray/config.json
sed -i "s/{uid}/${uid}/g" /etc/v2ray/config.json

sed -i "s/{h2host}/${h2host}/g" /etc/caddy/caddy.d/v2ray.caddy
sed -i "s/{h2domain}/${h2domain}/g" /etc/caddy/caddy.d/v2ray.caddy
sed -i "s/{uid}/${uid}/g" /etc/caddy/caddy.d/v2ray.caddy

chmod +x /usr/local/v2ray/v2ray
chmod +x /usr/local/v2ray/v2ctl

systemctl daemon-reload

echo <<EOF
服务器配置
协议: vmess
服务器地址: ${h2host}.${h2domain}
端口号: ${h2host}.${h2domain}
ID: ${uid}
alterId: 4 level: 0
security: auto

传输配置
网络: h2
主机: ${h2host}.${h2domain}
路径: /${h2host}

安全: tls
allowInsecure: yes
tls 服务名: ${h2host}.${h2domain}
EOF
