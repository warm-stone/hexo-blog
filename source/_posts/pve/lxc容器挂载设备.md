---
title: lxc容器挂载设备
date: 2024-09-12 22:06:23
categories:
  - pve
tags:
  - pve
  - lxc
---
# lxc容器内使用宿主机usb设备

宿主机上编辑lxc容器的配置文件 /etc/pve/lxc/101.conf，添加以下内容

```bash
lxc.mount.entry: /dev/video0 dev/video0 none bind,optional,create=file
```

修改usb设备权限

```bash
chmod 666 /dev/video0
```

容器内测试
```bash
apt install fswebcam
fswebcam -r 640x480 --jpeg 85 -D 1 snap.jpg
```

原文链接：https://blog.csdn.net/qf0129/article/details/131398166