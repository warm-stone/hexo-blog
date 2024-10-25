---
title: linux网速测试
date: 2024-10-23 00:35:42
categories:
  - Linux
tags:
  - Linux
  - 网络
---

原文链接：https://blog.csdn.net/m0_37814112/article/details/120066167

一、背景
需要对服务器的内网上下行带宽进行测试，便于判断当前带宽是否符合业务场景需求，在网上找到了iperf3工具。

iperf3是用来测量一个网络最大带宽的工具。
它支持调节各种参数比如发送持续时间，
发送/接收缓存，
通信协议。
每次测试，它都会报告网络带宽，丢包率和其他参数。

二、工具安装
使用iperf3工具测试服务器带宽，它分为服务端与客户端，两边都要安装iperf3工具。

说明：linux环境安装

1. 安装

    ```java
    yum -y install epel-release
    yum install iperf3
    ```
2. windows环境安装

   iperf3 windows版下载
   https://iperf.fr/download/windows/iperf-3.1.3-win64.zip


三、工具测试


iperf3参数详解

> -s 在服务端模式下运行
> -D 作为守护程序运行
> -d 进行双向测试
> -c 在客户端模式下运行，连接server端地址
> -p 指定端口（要和服务器端一致）
> -B 绑定客户端的ip地址
> -4 指定ipv4
> -f 格式化带宽数输出
> -n 指定传输的字节数
> -b 使用带宽数量
> -u 指定udp协议
> -t 以秒为单位指定传输时间，默认10秒
> --get-server-output 获取来自服务器端的结果


测试网络吞吐量

```java
#server端（192.168.1.212）
iperf3 -p 2228 -s -D

#client端（192.168.1.165）
iperf3 -c 192.168.1.212 -p 2228
————————————————
```