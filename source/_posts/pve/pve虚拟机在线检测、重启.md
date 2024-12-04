---
title: pve虚拟机在线检测、重启
date: 2024-12-04 22:56:04
categories:
  - pve
tags:
  - pve
---

# pve虚拟机在线检测、重启

来源： https://blog.slogra.com/post-806.html  

```bash
vim /usr/local/bin/check_servers.sh
```

```bash
#!/bin/bash

QMPATH="/usr/sbin/qm"
MAX_FAILURES=3  # 连续失败的最大次数
RESET_AFTER_SUCCESS=2  # 连续成功后重置失败计数的阈值

FAILURE_FILE="/path/to/failure_file.txt"  # 存储失败信息的文件路径

declare -A failure_count  # 记录每个虚拟机的连续失败次数

function load_failure_count() {
    if [[ -f "$FAILURE_FILE" ]]; then
        source "$FAILURE_FILE"
    fi
}

function save_failure_count() {
    declare -p failure_count > "$FAILURE_FILE"
}

function check_and_restart() {
    local vm_id="$1"
    local vm_ip="$2"
    local now

    ping -c 4 "$vm_ip" > /dev/null

    if [[ $? != 0 ]]; then
        now=$(date +%s)
        echo "[$now] [NO] id = $vm_id, ip = $vm_ip"

        if [[ -z "${failure_count["$vm_id"]}" ]]; then
            failure_count["$vm_id"]=1  # 初始失败次数为1
        else
            ((failure_count["$vm_id"]++))

            if ((failure_count["$vm_id"] >= MAX_FAILURES)); then
                echo "[$now] [RESTART] Restarting $vm_id after $MAX_FAILURES consecutive failures."
                "$QMPATH" stop "$vm_id"
                "$QMPATH" start "$vm_id"
                failure_count["$vm_id"]=0  # 重置连续失败次数
            fi
        fi
    else
        # 如果ping成功，则重置虚拟机的失败计数
        if [[ -n "${failure_count["$vm_id"]}" && ${failure_count["$vm_id"]} -gt 0 ]]; then
            echo "[$now] [OK] id = $vm_id, ip = $vm_ip"
            failure_count["$vm_id"]=0
        fi
    fi
}

function main() {
    local vm_list="$1"
    local vm_id
    local vm_ip

    load_failure_count

    for each in $vm_list; do
        vm_id=$(echo "$each" | awk -F: '{ print $1 }')
        vm_ip=$(echo "$each" | awk -F: '{ print $2 }')
        check_and_restart "$vm_id" "$vm_ip"
    done

    save_failure_count
}

# 需要检查的虚拟机列表，格式为 vm_id:vm_ip
vm_list="
101:192.168.1.254
102:192.168.1.250
"

main "$vm_list"
```


定时执行

```bash
crontab -e
```

```bash
*/3 * * * * /bin/bash /root/soft_shell/check_servers.sh
```