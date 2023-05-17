# SSH

`authorized_keys` 存放本地 ssh pub key，用于免密登录。

`ssh.config`

```shell
Host $ALIAS
    HostName $IP 
    Port 22
    User $USER
    IdentityFile $PEM_PATH  # 密钥文件
    ProxyJump $JUMP_SERVER  # 跳板机
    ServerAliveInterval 300
    ServerAliveCountMax  3
```

## 本地转发

```shell
ssh -L localport:remotehost:remotehostport sshserver

说明：
localport　　　　　　 本机开启的端口号
remotehost　　　　　　最终连接机器的IP地址
remotehostport       最终连接机器的端口号
sshserver　　　　　　 转发机器的IP地址

选项：
-f 后台启用
-N 不打开远程shell，处于等待状态（不加-N则直接登录进去）
-g 启用网关功能
```

![local](https://github.com/zli42/cheatsheets/assets/30396815/301d5d5b-17f5-44a2-b85d-39020aeb78b8)

场景：内部服务器 C 不允许外部直接访问，服务器 B 是一个 ssh 服务器，有一个用户 A 需要从外部连接到内部的服务器 C。

方法：用户 A 通过 ssh 协议连接到服务器 B 上，再通过服务器 B 做跳板，连接至服务器 C。

```ssh -L 2222:192.168.75.123:22 -fN 192.168.75.122```

## 远程转发

```shell
ssh -R sshserverport:remotehost:remotehostport sshserver

说明：
sshserverport     被转发机器开启的端口号
remotehost    　  最终连接机器的IP地址
remotehostport    最终连接机器的端口号
sshserver         被转发机器的IP地址

选项：
-f 后台启用
-N 不打开远程shell，处于等待状态（不加-N则直接登录进去）
-g 启用网关功能
```

![remote](https://github.com/zli42/cheatsheets/assets/30396815/0a85d45b-6824-4a66-91e5-2f6e9cdd3539)

场景：内部服务器 C 只允许 ssh 服务器 B 访问，不允许外部直接访问，有一个用户 A 需要从外部连接到内部的服务器 C。

方法：服务器 B 访问用户 A，给 A 用户转发。

```ssh -R 2222:192.168.75.123:22 -fN 192.168.75.121```
