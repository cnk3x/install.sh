#!/usr/bin/env bash

set -e
app=$1

case "$2" in
install)
    echo "安装 ${app}"
    wget -q -O ${app}.sh https://raw.githubusercontent.com/shuxs/install.sh/master/${app}/${app}.sh
    chmod +x ${app}.sh
    ./${app}.sh ${@:3}
    rm -f ${app}.sh
    ;;
uninstall)
    echo "卸载 ${app}"
    wget -q -O - https://raw.githubusercontent.com/shuxs/install.sh/master/${app}/clear.sh | sh
    ;;
init)
    systemctl enable ${app}
    ;;
start)
    systemctl start ${app}
    ;;
status)
    systemctl status ${app}
    ;;
stop)
    systemctl stop ${app}
    ;;
log)
    journalctl -fu ${app}
    ;;
*)
    echo "sh do.sh [v2ray | frps | caddy] [install | uninstall | init | start | status | stop | log]"
    ;;
esac
