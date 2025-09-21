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
2. `quickstart`修改`ip`地址不生效,可能是脚本绑定设备错误，去配置文件修改 `/etc/network/` `/etc/config/`
3. 通信问题注意仔细检查防火墙
4. clash 使用 `nftables`
5. 不要更新 `curl`，包已经被绑定了