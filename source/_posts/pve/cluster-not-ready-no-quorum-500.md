---
title: cluster not ready - no quorum? (500)
date: 2024-10-09 02:00:28
categories:
  - pve
tags:
  - pve
---
### 问题解释  

集群节点离线导致投票数目不足，导致无法进行操作

### 解决  

添加自定义服务，执行脚本

服务文件 `/etc/systemd/system/my-script.service`

```conf
[Unit]
Description=My custom script
Wants=corosync.service # 依赖服务
Wants=pve-cluster.service
Wants=pvedaemon.service
Wants=pveproxy.service
After=corosync.service
After=pve-cluster.service
After=pvedaemon.service
After=pveproxy.service

[Service]
ExecStart=/usr/local/bin/my-script.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target

```

脚本文件 ` /usr/local/bin/my-script.sh`
```shell
#!/bin/sh

pvecm expected 1

exit 0

```

