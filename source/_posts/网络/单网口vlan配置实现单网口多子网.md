---
title: 单网口vlan配置 实现PVE单网口多子网
date: 2025-10-18 01:46:27
categories:
  - 网络
tags:
  - vlan
  - linux
  - 网桥
---

核心思路是利用VLAN标签区分不同网桥（vmbr0和vmbr1）的二层流量，避免冲突。


### 核心原理
单个物理网卡可以通过**VLAN trunk模式**同时传输多个VLAN的流量（相当于“多路复用”）。我们可以为两个网段（192.168.100.0/24和192.168.66.0/24）分别分配独立的VLAN标签，通过同一物理网卡传输，从而在单网卡PVE上实现两个虚拟网桥的功能。


### 前提条件
- 两台PVE之间通过**同一物理链路连接**（单网卡PVE的唯一网卡与另一台PVE的其中一个网卡通过网线直连，或接入同一台支持VLAN的物理交换机）。
- 物理链路支持VLAN（现代网卡和交换机均支持802.1Q VLAN标签）。


### 具体配置步骤（假设：PVE1有2个网卡，PVE2只有1个网卡）

#### 1. 定义VLAN规划
为两个网段分配VLAN标签（示例）：
- 192.168.100.0/24 对应 VLAN 100（绑定vmbr0）
- 192.168.66.0/24 对应 VLAN 66（绑定vmbr1）


#### 2. 单网卡PVE（PVE2）的配置
PVE2只有1个物理网卡（假设为`enp1s0`），需将其配置为**trunk模式**（允许VLAN 100和VLAN 66的流量通过），并基于VLAN创建两个虚拟网桥。

修改`/etc/network/interfaces`：
```bash
# PVE2（单网卡）的配置
auto enp1s0
iface enp1s0 inet manual  # 物理网卡不配置IP，仅作为trunk传输VLAN流量

# vmbr0对应VLAN 100（192.168.100.0/24网段）
auto vmbr0
iface vmbr0 inet static
    address 192.168.100.2/24  # PVE2在该网段的IP（与PVE1的vmbr0同网段）
    bridge-ports enp1s0.100   # 绑定物理网卡的VLAN 100子接口
    bridge-stp off
    bridge-fd 0

# vmbr1对应VLAN 66（192.168.66.0/24网段）
auto vmbr1
iface vmbr1 inet static
    address 192.168.66.2/24   # PVE2在该网段的IP（与PVE1的vmbr1同网段）
    bridge-ports enp1s0.66    # 绑定物理网卡的VLAN 66子接口
    bridge-stp off
    bridge-fd 0
```

- `enp1s0.100`：物理网卡`enp1s0`的VLAN 100子接口（仅接收/发送带VLAN 100标签的流量）。
- `enp1s0.66`：物理网卡`enp1s0`的VLAN 66子接口（仅接收/发送带VLAN 66标签的流量）。


#### 3. 双网卡PVE（PVE1）的配置
PVE1有2个网卡，可将其中一个网卡绑定到VLAN 100（对应vmbr0），另一个绑定到VLAN 66（对应vmbr1），无需trunk模式（简化配置）。

修改`/etc/network/interfaces`：
```bash
# PVE1（双网卡）的配置
# 网卡1（enp1s0）绑定VLAN 100，对应vmbr0
auto enp1s0
iface enp1s0 inet manual

auto vmbr0
iface vmbr0 inet static
    address 192.168.100.1/24
    bridge-ports enp1s0  # 直接桥接物理网卡（该网卡需只传输VLAN 100流量）
    bridge-stp off
    bridge-fd 0

# 网卡2（enp2s0）绑定VLAN 66，对应vmbr1
auto enp2s0
iface enp2s0 inet manual

auto vmbr1
iface vmbr1 inet static
    address 192.168.66.1/24
    bridge-ports enp2s0  # 直接桥接物理网卡（该网卡需只传输VLAN 66流量）
    bridge-stp off
    bridge-fd 0
```

**关键**：PVE1的两个物理网卡需与PVE2的物理网卡正确连接：
- 若PVE1和PVE2直接连接：PVE1的`enp1s0`（vmbr0）和`enp2s0`（vmbr1）需通过交换机与PVE2的`enp1s0`连接（交换机需配置：PVE1的`enp1s0`端口为VLAN 100 access，`enp2s0`为VLAN 66 access，PVE2的`enp1s0`端口为trunk，允许VLAN 100和66）。
- 若直接用一根网线连接（仅当PVE1用一个网卡同时处理两个VLAN时）：PVE1也需配置trunk（参考PVE2的方式，将一个网卡作为trunk，绑定两个VLAN子接口到vmbr0和vmbr1）。


#### 4. 虚拟机网络配置
- 所有需要接入192.168.100.0/24网段的虚拟机，网络接口绑定到`vmbr0`，并配置该网段IP（如192.168.100.10/24）。
- 所有需要接入192.168.66.0/24网段的虚拟机，网络接口绑定到`vmbr1`，并配置该网段IP（如192.168.66.10/24）。

此时，VLAN会自动隔离两个网段的二层流量，同VLAN（同网段）的虚拟机（无论在PVE1还是PVE2上）可通过二层直接通信。


### 注意事项
1. **VLAN一致性**：两端VLAN标签必须对应（PVE2的VLAN 100对应PVE1的vmbr0，VLAN 66对应vmbr1），否则流量会被丢弃。
2. **交换机配置**：若通过物理交换机连接，需确保交换机端口配置正确（trunk口允许指定VLAN，access口绑定对应VLAN）。
3. **防火墙**：PVE主机和虚拟机的防火墙需允许同网段/VLAN的流量（如ICMP、TCP等）。
4. **链路带宽**：单网卡PVE的两个网段共享物理网卡带宽，若流量大可能导致拥堵（可通过QoS优化）。


综上，通过VLAN隔离单网卡的流量，完全可以实现两台PVE上两个网段的虚拟机互通。