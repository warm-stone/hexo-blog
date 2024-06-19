---
title: istore安装
date: 2024-06-20 01:04:19
categories:
  - 软路由
tags:
  - istore
---

[工控机AllInOne——篇5，pve安装istoreos_Harold_96_lxw的博客-CSDN博客](https://blog.csdn.net/weixin_38168694/article/details/130544422)

# 问题

1. img文件安装问题  
    需要cmd引入磁盘  
    ```shell
    qm importdisk 100<虚拟机号> <磁盘文件路径> local-lvm
    ```

# network文件

```config
config interface 'loopback'
        option device 'lo'
        option proto 'static'
        option ipaddr '127.0.0.1'
        option netmask '255.0.0.0'

config globals 'globals'
        option ula_prefix 'fdc9:6f90:39f6::/48'

config device
        option name 'br-lan'
        option type 'bridge'
        list ports 'eth0'

config interface 'lan'
        option device 'br-lan'
        option proto 'static'
        option ipaddr '192.168.100.1'
        option netmask '255.255.255.0'
        option ip6assign '60'

config interface 'wan'
        option proto 'dhcp'
        option device 'eth1'

config interface 'lan1'
        option proto 'static'
        option device 'eth3'
        option ipaddr '192.168.101.1'
```