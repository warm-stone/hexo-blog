---
title: ssh
date: 2024-06-18 00:52:35
categories:
  - Linux
tags:
  - Linux
  - ssh
---

# ssh相关包
作者：Sage涩橘 https://www.bilibili.com/read/cv12542259 出处：bilibili
```
openssh.x86_64                        7.4p1-21.el7                     @anaconda
openssh-clients.x86_64                7.4p1-21.el7                     @anaconda
openssh-server.x86_64                 7.4p1-21.el7                     @anaconda
```
第三个为ssh服务相关

启动服务相关配置
```dsconfig
Port 22
#AddressFamily any
ListenAddress 0.0.0.0 #取消掉前面的注释
ListenAddress ::   #取消掉前面的注释

# Authentication:
#LoginGraceTime 2m
PermitRootLogin yes  #取消掉前面的注释
#StrictModes yes
#MaxAuthTries 6
#MaxSessions 10

# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication yes  #取消掉前面的注释
#PermitEmptyPasswords no
```