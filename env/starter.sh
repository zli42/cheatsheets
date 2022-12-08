init(){
    echo "[update system]"
    apt update
    apt upgrade -y
    apt autoremove -y

    echo
    echo "[install rust]"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"

    echo
    echo "[install shadowsocks]"
    cargo install shadowsocks-rust
}

start(){
    ip=`curl -s ifconfig.io`
    port=4288
    password=`uuidgen -r | base64 | head -c 8`
    method="chacha20-ietf-poly1305"

    printf "%-10s %s\n" "ip" $ip
    printf "%-10s %s\n" "port" $port
    printf "%-10s %s\n" "password" $password
    printf "%-10s %s\n" "method" $method

    cat > ssconfig.json << EOF
{
    "server": "::",
    "server_port": $port,
    "password": "$password",
    "method": "$method"
}
EOF

    echo
    echo "start server"
    ssserver -c ssconfig.json
}

if [ "$1" = "init" ]
then
    init

else
    start
fi
