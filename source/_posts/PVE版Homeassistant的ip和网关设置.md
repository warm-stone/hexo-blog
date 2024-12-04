---
title: PVE版Homeassistant的ip和网关设置
date: 2024-12-04 23:06:52
categories:
  - home assistant
tags:
  - home assistant
---


# PVE版Homeassistant的ip和网关设置

[PVE版Homeassistant的ip和网关设置 - 天涯笔记](https://www.ymyc.site/archives/439/)


```bash
login  #命令行输入login
nmcli dev status   #查看当前网络
```

![](https://www.ymyc.site/usr/uploads/2024/06/145159119.png)[https://www.ymyc.site/usr/uploads/2024/06/145159119.png](https://www.ymyc.site/usr/uploads/2024/06/145159119.png)

```bash
nmcli con edit "Supervisor enp6s18"   #改为自己的网口名字
```

![](https://www.ymyc.site/usr/uploads/2024/06/1073460911.png)[https://www.ymyc.site/usr/uploads/2024/06/1073460911.png](https://www.ymyc.site/usr/uploads/2024/06/1073460911.png)

```bash
print ipv4  #查看网络配置
set ipv4.addresses 192.168.31.205/24 # 设置ip
set ipv4.dns 192.168.31.10  # 设置DNS
set ipv4.gateway 192.168.31.10  # 设置网关
print ipv4 #查看修改后的网络配置
save #保存配置
quit #退出配置
```

![](https://www.ymyc.site/usr/uploads/2024/06/3762396971.png)[https://www.ymyc.site/usr/uploads/2024/06/3762396971.png](https://www.ymyc.site/usr/uploads/2024/06/3762396971.png)

```bash
nmcli con reload  #启用新的网络配置
```