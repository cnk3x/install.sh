#!/usr/bin/env bash

set -e
baseURL="https://raw.githubusercontent.com/shuxs/install.sh/master/v2ray"

h2domain=$1
h2host=$2
uid=$(cat /proc/sys/kernel/random/uuid)

if [ -z "${h2host}" ]; then
    h2host="$(hostname)"
fi

if [ -z "${h2domain}" ]; then
    echo "v2ray.sh domain [host]"
    exit 1
fi

mkdir -p /etc/v2ray /usr/local/v2ray /etc/v2ray /etc/caddy/caddy.d /data/www/${h2host}

wget --no-cache -nv -O /usr/local/v2ray/v2ray ${baseURL}/v2ray
wget --no-cache -nv -O /usr/local/v2ray/v2ctl ${baseURL}/v2ctl
wget --no-cache -nv -O /usr/local/v2ray/geoip.dat ${baseURL}/geoip.dat
wget --no-cache -nv -O /usr/local/v2ray/geosite.dat ${baseURL}/geosite.dat
wget --no-cache -nv -O /etc/v2ray/config.json ${baseURL}/config.json
wget --no-cache -nv -O /etc/caddy/caddy.d/v2ray.caddy ${baseURL}/v2ray.caddy
wget --no-cache -nv -O /etc/systemd/system/v2ray.service ${baseURL}/v2ray.service

sed -i "s/{h2host}/${h2host}/g" /etc/v2ray/config.json
sed -i "s/{h2domain}/${h2domain}/g" /etc/v2ray/config.json
sed -i "s/{uid}/${uid}/g" /etc/v2ray/config.json

sed -i "s/{h2host}/${h2host}/g" /etc/caddy/caddy.d/v2ray.caddy
sed -i "s/{h2domain}/${h2domain}/g" /etc/caddy/caddy.d/v2ray.caddy
sed -i "s/{uid}/${uid}/g" /etc/caddy/caddy.d/v2ray.caddy

chmod +x /usr/local/v2ray/v2ray
chmod +x /usr/local/v2ray/v2ctl

systemctl daemon-reload

echo
echo "服务器配置"
echo "协议: vmess"
echo "服务器地址: ${h2host}.${h2domain}"
echo "端口号: ${h2host}.${h2domain}"
echo "ID: ${uid}"
echo "alterId: 4 level: 0"
echo "security: auto"
echo
echo "传输配置"
echo "网络: h2"
echo "主机: ${h2host}.${h2domain}"
echo "路径: /${h2host}"
echo
echo "安全: tls"
echo "allowInsecure: yes"
echo "tls 服务名: ${h2host}.${h2domain}"
