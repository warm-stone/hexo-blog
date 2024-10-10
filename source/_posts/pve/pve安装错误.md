---
title: pve安装错误
date: 2024-06-20 01:07:26
categories:
  - pve
tags:
  - 官方手册
---

官方手册  
https://pve-doc-cn.readthedocs.io/zh-cn/latest/

# 安装问题

来源：https://mengkai.fun/archives/1717297733491  

报错
```
loading drivers:nvidiafb ahci mac_hid
```
显卡驱动错误，只能使用命令行安装  
官方解决方案

> On the Proxmox VE bootloader menu, navigate to Install Proxmox VE (Terminal UI) and press e to edit the entry. Using the arrow keys, navigate to the line starting with linux, move the cursor to the end of that line and add the parameter nomodeset, separated by a space from the pre-existing last parameter.

在Proxmox VE引导程序菜单上，导航到安装_Proxmox VE (Terminal UI)_）， 按e编辑条目。使用箭头键，导航到起始行 在Linux中，将光标移动到该行的末尾，并添加 参数 nomodeset（记得前面留空格），与预先存在的last用空格分隔 参数.

添加后按CTRL+X重新安装