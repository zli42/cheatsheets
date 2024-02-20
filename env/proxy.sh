host=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
# host=$(ip route show | grep -i default | awk '{ print $3}')  # WSL

port=1080

proxy="http://${host}:${port}"

set_proxy(){
    export HTTP_PROXY="${proxy}"
    export HTTPS_PROXY="${proxy}"
}

unset_proxy(){
    unset HTTP_PROXY
    unset HTTPS_PROXY
}

if [ "$1" = "set" ]
then
    set_proxy

elif [ "$1" = "unset" ]
then
    unset_proxy
fi

# git config --global http.https://github.com.proxy ${proxy}
# git config --global https.https://github.com.proxy ${proxy}
