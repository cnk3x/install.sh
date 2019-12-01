#!/bin/sh

set -e

token=$(openssl rand -hex 16)
dashboard_pwd=$(openssl rand -hex 16)
subdomain_host=$(openssl rand -hex 16)
baseURL="https://raw.githubusercontent.com/shuxs/install.sh/master/caddy/"
mkdir -p /etc/frps

wget --no-cache -nv -O /usr/local/bin/frps ${baseURL}/frps
wget --no-cache -nv -O /etc/frps/frps.ini ${baseURL}/frps.ini
wget --no-cache -nv -O /etc/systemd/system/frps.service ${baseURL}/frps.service

sed -i "s/{token}/${token}/g" /etc/frps/frps.ini
sed -i "s/{dashboard_pwd}/${dashboard_pwd}/g" /etc/frps/frps.ini
sed -i "s/{subdomain_host}/${subdomain_host}/g" /etc/frps/frps.ini

chmod +x /usr/local/bin/frps
systemctl daemon-reload
