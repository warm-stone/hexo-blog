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

几篇很好的教程
https://github.com/Aethersailor/Custom_OpenClash_Rules/tree/main/wiki

部分个人观点：
1. 个人习惯不设置`ipv6`代理，仅设置`dns`解析，以提高稳定性
2. `DDNS` 域名污染问题使用自定义规则更灵活，可以解决混合使用 cloudflare `tunnel`、代理等访问问题 


