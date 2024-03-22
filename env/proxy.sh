host=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
# wsl_host=$(hostname -I | awk '{print $1}')

port=1080

proxy="http://${host}:${port}"

set_proxy(){
    export HTTP_PROXY="${proxy}"
    export HTTPS_PROXY="${proxy}"
    
    git config --global http.https://github.com.proxy ${proxy}
    git config --global https.https://github.com.proxy ${proxy}
}

unset_proxy(){
    unset HTTP_PROXY
    unset HTTPS_PROXY

    git config --global --unset http.https://github.com.proxy
    git config --global --unset https.https://github.com.proxy
}

if [ "$1" = "set" ]
then
    set_proxy

elif [ "$1" = "unset" ]
then
    unset_proxy
fi


