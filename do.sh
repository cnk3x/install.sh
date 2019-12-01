#!/bin/sh
set -e
app=$1
case "$2" in
install)
    echo "安装 ${app}"
    wget -q -O ${app}.sh https://raw.githubusercontent.com/shuxs/install.sh/master/${app}/${app}.sh
    sh ${app}.sh ${@:3}
    rm -f ${app}.sh
    ;;
uninstall)
    echo "卸载 ${app}"
    wget -q -O - https://raw.githubusercontent.com/shuxs/install.sh/master/${app}/clear.sh | sh
    ;;
*)
    echo "sh do.sh (v2ray | frps | caddy) (install | uninstall)"
    ;;
esac
