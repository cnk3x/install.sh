#!/usr/bin/env bash

set -e

subdomain_host=$1

if [ -z "${subdomain_host}" ]; then
    echo "v2ray.sh domain [host]"
    exit 1
fi

token=$(openssl rand -hex 16)
dashboard_pwd=$(openssl rand -hex 3)
baseURL="https://raw.githubusercontent.com/shuxs/install.sh/master/frps/"

mkdir -p /etc/frps /etc/caddy/caddy.d

wget --no-cache -nv -O /usr/local/bin/frps ${baseURL}/frps
wget --no-cache -nv -O /etc/frps/frps.ini ${baseURL}/frps.ini
wget --no-cache -nv -O /etc/caddy/caddy.d/frps.caddy ${baseURL}/frps.caddy
wget --no-cache -nv -O /etc/systemd/system/frps.service ${baseURL}/frps.service

sed -i "s/{token}/${token}/g" /etc/frps/frps.ini
sed -i "s/{dashboard_pwd}/${dashboard_pwd}/g" /etc/frps/frps.ini
sed -i "s/{subdomain_host}/${subdomain_host}/g" /etc/frps/frps.ini
sed -i "s/{subdomain_host}/${subdomain_host}/g" /etc/caddy/caddy.d/frps.caddy

chmod +x /usr/local/bin/frps
systemctl daemon-reload

echo
echo "服务器: frps.${subdomain_host}"
echo "密钥: ${token}"
echo "面板: https://frps.${subdomain_host}"
echo "账号: admin"
echo "密码: ${dashboard_pwd}"
