hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
port=1080

proxy="${hostip}:${port}"

set_proxy(){
    export http_proxy="${proxy}"
    export https_proxy="${proxy}"
}

unset_proxy(){
    unset http_proxy
    unset https_proxy
}

if [ "$1" = "set" ]
then
    set_proxy

elif [ "$1" = "unset" ]
then
    unset_proxy
fi
