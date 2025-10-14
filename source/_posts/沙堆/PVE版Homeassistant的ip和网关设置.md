---
title: Home assistant 配置
date: 2024-12-04 23:06:52
categories:
  - home assistant
tags:
  - home assistant
---


### PVE版Homeassistant的ip和网关设置

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

### ssh 配置

`home assistant` ssh 配置与其他服务器有所不同，由于插件、加载项众多，为了安全，仅共享`/config` 目录，
所以全局配置需要放入该目录下

注意：`ssh terminal` 加载项的 `.ssh` 文件夹为映射文件夹，不要在其中创建秘钥文件，也不要直接复制其目录

因为某些插件、加载项`/config`目录也无法访问，ssh 操作一般会映射为下面相关操作
https://www.home-assistant.io/integrations/command_line
https://www.home-assistant.io/integrations/shell_command