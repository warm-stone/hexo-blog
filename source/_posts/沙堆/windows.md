---
title: windows
date: 2024-06-20 01:53:56
categories:
tags:
---

### 快捷键

* windows+[0-9]

  快捷打开任务栏相关应用

  ctrl + shift + [0-9] 以**管理员**权限打开

* ctrl + windows + [方向键]

  切换桌面
* windows + l

  锁屏
* windows + r

  运行
* windows + d

  显示桌面
* windows + e

  文件资源管理器


### 查看端口占用

使用以下命令找到占用线程的PID，进入任务管理器确定占用程序

```shell
netstat -ano
netstat -aon|findstr "8081"

tasklist|findstr "9088"
```



# 环境变量

**立即启用方法**

打开新的terminal即可