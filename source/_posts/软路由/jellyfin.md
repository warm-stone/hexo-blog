---
title: jellyfin
date: 2024-06-20 00:46:17
categories:
  - 软路由
tags:
  - 软路由
  - 家庭影院
---

资源刮削

https://mirror.ghproxy.com/https://github.com/cxfksword/jellyfin-plugin-metashark/releases/download/manifest/manifest_cn.json


硬件解码

[N5105 4口2.5g V3 Intel i225 PVE7.2下的jellyfin硬解设置 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/580600848)

首先：PVE7.2 的内核需要更新

1、更新PVE内核到5.19（2022-9-13官网更新）

如果你的PVE是新安装的，需要把自带的企业源更改掉，默认是需要订阅的：

```text
#删除默认的企业源
rm /etc/apt/sources.list.d/pve-enterprise.list
# 添加官方，非订阅源
echo 'deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription' >> /etc/apt/sources.list.d/pve-no-subscription.list
```

开始更新内核：（2022-9-13官网更新）

```text
apt update
apt install pve-kernel-5.19
reboot
```

查看当前使用内核

```text
uname -a
```

2、补全PVE缺少的915 guc huc dmc固件

```text
mkdir -p /lib/firmware/i915 && cd /lib/firmware/i915
curl -LO https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/ehl_guc_70.1.1.bin
curl -LO https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/ehl_huc_9.0.0.bin
curl -LO https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/icl_dmc_ver1_09.bin
```

3、lxc模板安装debian 11，完成后不要启动

![](https://pic2.zhimg.com/80/v2-041fdaf6e5551baf30e00082392f2b2d_720w.webp)

![](https://pic1.zhimg.com/80/v2-7dfe53119a7678365fb936a456a22898_720w.webp)

![](https://pic2.zhimg.com/80/v2-f4faaf69c7e8a20e8cd9f2bbda8cbdf9_720w.webp)

4、在宿主PVE节点下指派核显给lxc下的debian（可以用finalshell或者PVE自己的shell命令工具）

查看核显（PVE宿主机的核显）

```text
ls -l /dev/dri
```

正常情况下，你会看到反馈：

```text
total 0
drwxrwxrwx 2 root root         80 Nov  4 16:28 by-path
crwxrwxrwx 1 root video  226,   0 Nov  4 16:28 card0
crwxrwxrwx 1 root render 226, 128 Nov  4 16:28 renderD128
```

编辑LXC容器的config文件：

```text
nano /etc/pve/lxc/101.conf  #这里101.conf的101是根据你自己的虚拟机序号来的，如下图，你自己是多少就改成多少。
```

![](https://pic4.zhimg.com/80/v2-bbac35898eee8ea8a7ae5d9500ebbc63_720w.webp)

```text
#在打开的101.conf文件的最下方添加以下命令，把核显赋权给虚拟机
lxc.cgroup2.devices.allow: c 226:0 rwm
lxc.cgroup2.devices.allow: c 226:128 rwm
lxc.cgroup2.devices.allow: c 29:0 rwm
lxc.mount.entry: /dev/dri dev/dri none bind,optional,create=dir
lxc.mount.entry: /dev/fb0 dev/fb0 none bind,optional,create=file
lxc.apparmor.profile: unconfined
```

编辑 i915.conf文件，打开intle低压cpu的硬解参数

```text
nano /etc/modprobe.d/i915.conf

#打开后是空文件，直接复制黏贴一下内容
options i915 enable_guc=3   #这里的值设置成2也可以
ctrl+x，y，enter            #nano的保存退出
```

5、PVE开机自动赋权给核显及解码器

```text
nano /lib/systemd/system/rc-local.service
```

文件尾部加入

```text
[Install]
WantedBy=multi-user.target
```

创建开始脚本

```text
cat <<EOF >/etc/rc.local
#!/bin/sh -e
#
#rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits
#
# By default this script does nothing.**
chmod 777 /dev/dri/*
exit 0
EOF
```

给脚本赋权限

```text
chmod +x /etc/rc.local
```

然后启动服务

```text
systemctl enable rc-local.service
```

6，接着开启LXC的虚拟机（用PVE自带的Shell工具，输入刚才的root账号和密码登录）

检查核显有没有正确的传递过来：

```text
ls -l /dev/dri
```

如果看到和宿主机PVE一样的代码：那就说明核显已经顺利的接入进来了，为下一步开启硬解打开了大门

```text
total 0
drwxrwxrwx 2 root root         80 Nov  4 16:28 by-path
crwxrwxrwx 1 root video  226,   0 Nov  4 16:28 card0
crwxrwxrwx 1 root render 226, 128 Nov  4 16:28 renderD128
```

升级一下Debian的系统

```text
apt update
apt upgrade -y
```

7，开始安装jellyfin

```text
apt install extrepo
extrepo enable jellyfin
apt update
apt install jellyfin
#查看
service jellyfin status
#重启
systemctl restart jellyfin
#停止
/etc/init.d/jellyfin stop
```

这个时候，浏览器输入你的LXC虚拟机的IP地址+8096的端口号，就可以看到jellyfin的登录界面了，第一次登录需要设置管理员的用户名和密码

![](https://pic2.zhimg.com/80/v2-0f9c54da000d6b2a3e04169ae15602fd_720w.webp)

8，到这边开始，jellyfin的安装和硬解的准备工作都已经完成。

接着开始挂载远程NAS的媒体文件夹，为jellyfin添加媒体资料库，这里面有最重要的一点，**先把你的LXC虚拟机给关了，要不然试了好几次，容器启动不了了。**

**关机Debian虚拟机。**

9，开始做媒体资料库的映射，这里分两步走：

a，先把NAS里的媒体库映射到PVE的宿主机里

![](https://pic3.zhimg.com/80/v2-e7082377ab90a5cff2c3616ed9e1cb4e_720w.webp)

b，接着把宿主机挂载的远程NAS媒体文件夹映射到LXC的Debian虚拟机里面。用一条命令来实现：（这是在PVE的Shell里面进行的）

```text
pct set 101 -mp0 /mnt/pve/media,mp=/mnt/media

#稍微解释一下，这里的101就是你之前虚拟机的号码，上面已经讲过了。后的-mp0是命令，做映射。/mnt/pve/media是PVE挂载的NAS文件夹，
#/mnt/media是映射到Debian的文件夹的位置。
#这条命令，相当于是在101.conf的文件里添加了一条 -mp0 /mnt/pve/media,mp=/mnt/media 启动命令
#可以nano /etc/pve/lxc/101.conf查看一下
```

c，检查没问题后，开机Debian

进入Shell，输入root用户名和密码

```text
cd /mnt            #进入mnt文件夹
ls                 #查看media文件夹有没有被正确的映射过来
ls -l /dev/dri     #查看核显有没有正确的映射过来
```

10，一切都没有问题

登录Jellyfin后台 Debian的IP+8096端口号，输入刚才设置的用户名+密码

开始Jellyfin的配置，

此文略过了，记得在播放设置里打开硬件解码，选择QSV

![](https://pic1.zhimg.com/80/v2-aa5132a847a9dc7679087e5fab193da0_720w.webp)

有问题可以发邮件咨询：[szbaohuang@163.com](mailto:szbaohuang@163.com)