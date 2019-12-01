#!/bin/zsh

set -e

domain=$1

if [ -n "${domain}" ]; then
    ${HOME}/.acme.sh/acme.sh --installcert -d ${domain} --key-file ${domain}.key --fullchain-file ${domain}.pem
fi

for server in ${@:2}; do
    ssh root@${server} mkdir -p /etc/caddy/ssl
    scp ${domain}.key ${domain}.pem root@${server}:/etc/caddy/ssl/
    ssh root@${server} chmod 0666 /etc/caddy/ssl/${domain}.pem /etc/caddy/ssl/${domain}.key
done

rm -f ${domain}.key ${domain}.pem
