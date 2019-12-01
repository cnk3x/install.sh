#!/bin/sh

baseURL="https://raw.githubusercontent.com/shuxs/install.sh/master/v2ray"

if [ -f "/usr/local/v2ray/v2ray" ]; then
    echo "v2ray 已存在"
    exit 1
fi

if [ -f "/etc/systemd/system/v2ray.service" ]; then
    echo "v2ray.service 已存在"
    exit 1
fi

set -ex

h2host=$1
h2domain=$2
uid=$(cat /proc/sys/kernel/random/uuid)

mkdir -p /etc/v2ray /usr/local/v2ray /etc/v2ray /etc/caddy.d /data/www/${h2host}

curl -sSL -o /usr/local/v2ray/v2ray ${baseURL}/v2ray
curl -sSL -o /usr/local/v2ray/v2ctl ${baseURL}/v2ctl
curl -sSL -o /usr/local/v2ray/geoip.dat ${baseURL}/geoip.dat
curl -sSL -o /usr/local/v2ray/geosite.dat ${baseURL}/geosite.dat

curl -sSL -o /etc/v2ray/config.json ${baseURL}/config.json
curl -sSL -o /etc/caddy/caddy.d/v2ray.caddy ${baseURL}/v2ray.caddy
curl -sSL -o /etc/systemd/system/v2ray.service ${baseURL}/v2ray.service

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
