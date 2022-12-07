init(){
    apt update
    apt upgrade -y
    apt autoremove -y

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"

    cargo install shadowsocks-rust
}

start(){
    password=`uuidgen -r | head -c 8`
    echo $password

    cat > ssconfig.json << EOF
    {
        "server": "::",
        "server_port": 8388,
        "password": "$password",
        "method": "aes-256-gcm"
    }
    EOF

    ssserver -c ssconfig.json
}

if [ "$1" = "init" ]
then
    init

else
    start
fi
