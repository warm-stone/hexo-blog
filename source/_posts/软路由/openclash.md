---
title: openclash
date: 2024-06-20 01:09:22
categories:
  - 软路由
tags:
  - clash
---

安装包时curl会遇到问题，需要禁用源下载配置的crul

修复问题：

```shell
opkg update
opkg install libcurl4
```


[luci-app-openclash 使用说明，配置指南 - 爱一枝梅 (iyzm.net)](https://iyzm.net/openwrt/1445.html)