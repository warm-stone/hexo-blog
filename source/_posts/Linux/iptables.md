---
title: iptables
date: 2024-11-21 23:13:27
categories:
  - Linux
tags:
  - Linux
  - iptables
  - 网络
  - NAT
---

[Debian下iptables规则重启失效问题的解决方法-腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/1142130)

[docker容器内部无法访问外网IPV6 · Issue #1511 · istoreos/istoreos](https://github.com/istoreos/istoreos/issues/1511)


# 持久化


Debian系统默认不会保存iptables规则，重启后所有设置过的iptables会失效。解决方法是：设置好iptables规则后，使用`iptables-save`保存规则到文件；然后设置开机时使用`iptables-restore`导入这个文件。

注意 ipv6 需要使用 `ip6tables-save` `ip6tables-restore`替换

具体执行命令：

```bash
touch /etc/network/if-pre-up.d/iptables

chmod +x /etc/network/if-pre-up.d/iptables
```

然后编辑这个文件：

```bash
vim /etc/network/if-pre-up.d/iptables
```

输入以下内容：

```bash
#!/bin/sh

/sbin/iptables-restore < /etc/iptables.conf
/sbin/ip6tables-restore < /etc/ip6tables.conf
```

然后，配置iptables规则。我自己设置的规则是一个端口转发（在单IP独服上开小鸡用）：

iptables -t nat -A POSTROUTING -s '10.20.20.20/24' -o vmbr0 -j MASQUERADE

iptables -t nat -A PREROUTING -i vmbr0 -p tcp --dport 7894 -j DNAT --to 10.20.20.100:3389

配置完毕后，把规则保存到文件：

```bash
iptables-save > /etc/iptables.conf
ip6tables-save > /etc/ip6tables.conf
```

这样设置，重启系统iptables规则就不会再失效了。


# 允许NAT转发


```bash
ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
ip6tables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
```


这两条命令是用于配置Linux系统中的`iptables`防火墙规则的。`iptables`是一个用户空间的应用程序，用于配置Linux内核的网络包过滤规则表。下面是这两条命令的具体作用：

1. `ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE`

    * 这条命令用于添加一个`nat`表中的`POSTROUTING`链的规则。
    * `-t nat` 指定了要操作的表是`nat`表，这个表用于网络地址转换（NAT）。
    * `-A POSTROUTING` 表示将规则添加到`POSTROUTING`链，这个链用于处理即将离开本机的包。
    * `-o eth0` 指定了输出接口为`eth0`，即所有从`eth0`接口出去的包都会受到这条规则的影响。
    * `-j MASQUERADE` 表示如果匹配这条规则，那么执行`MASQUERADE`操作，这是一种NAT操作，用于动态地将出站连接的源地址替换为出口接口的地址。这通常用于当服务器有多个网络接口，并且需要对外隐藏内部网络结构时。
2. `ip6tables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT`

    * 这条命令用于添加一个`FORWARD`链的规则，这个链用于处理经过本机的包（即转发的包）。
    * `-A FORWARD` 表示将规则添加到`FORWARD`链。
    * `-m conntrack` 表示使用`conntrack`模块，这个模块用于跟踪网络连接的状态。
    * `--ctstate RELATED,ESTABLISHED` 指定了连接状态，`RELATED`表示与已建立的连接相关的包，`ESTABLISHED`表示已建立的连接的包。
    * `-j ACCEPT` 表示如果匹配这条规则，那么执行`ACCEPT`操作，即接受这些包。

总的来说，第一条命令用于设置源NAT，使得从`eth0`接口出去的包的源地址被替换为`eth0`的地址，通常用于动态IP环境。第二条命令用于允许所有与已建立或相关联的连接的转发流量，这是实现网络地址转换和透明代理的一部分。这些规则通常用于路由器或防火墙设备上，以管理进出网络的流量。