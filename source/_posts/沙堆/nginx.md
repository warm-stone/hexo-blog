---
title: nginx
date: 2024-10-26 23:51:47
categories:
tags:
  - nginx
---

#### 启动、停止和重新加载配置

要启动 nginx，请运行可执行文件。 nginx 启动后，可以通过调用可执行文件来控制它 替换为参数。 使用以下语法：`-s`

```
nginx -s signal
```

其中 *signal* 可以是以下值之一：

* `stop`— 快速关机
* `quit`— 优雅关闭
* `reload`— 重新加载配置文件
* `reopen`— 重新打开日志文件