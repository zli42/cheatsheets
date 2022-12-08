#!/bin/bash

init(){
    apt update
    apt upgrade -y
    apt autoremove -y

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"

    cargo install shadowsocks-rust
}

start(){
    ip=`curl -s ifconfig.io`
    echo "ip: $ip"

    password=`uuidgen -r | head -c 8`
    echo "password: $password"
    echo

    cat > ssconfig.json << EOF
{
    "server": "::",
    "server_port": 8388,
    "password": "$password",
    "method": "aes-256-gcm"
}
EOF

    echo "start server"
    ssserver -c ssconfig.json
}

if [ "$1" = "init" ]
then
    init

else
    start
fi
