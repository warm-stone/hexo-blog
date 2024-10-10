#!/bin/bash
filename="/etc/profile.d/custom_proxy.sh"
# 检查文件是否存在
if [ ! -f "$filename" ]; then
    # 如果文件不存在，则创建文件并写入内容
    echo "文件 '$filename' 不存在，正在创建..."

    # 设置代理
    cat <<EOF >  "$filename"
export proxy="http://istore.home:7890"
export http_proxy=\$proxy
export https_proxy=\$proxy
EOF
    echo "文件已创建并写入内容。"
else
    # 如果文件存在，则跳过创建
    echo "文件 '$filename' 已存在，跳过创建。"
fi

source "$filename"


# 添加ll别名

echo "Adding alias"
ALIAS="alias ll='ls -l'"
# 检查别名是否已存在于/etc/profile中
if ! grep -q "$ALIAS" /etc/profile; then
    # 如果不存在，则添加别名
    echo "Adding alias to /etc/profile..."
    echo "$ALIAS" | tee -a /etc/profile
    echo "Alias added."
else
    echo "Alias already exists in /etc/profile."
fi

# 使更改立即生效
source /etc/profile
echo "Changes have been applied."

# 添加ssh认证
filename="/root/.ssh/authorized_keys"
pub_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1plgdqzXTGjzDOT9NY0N6jvHD1TMr1N53PUb9Fh8jnF1EaJralYoha5eylEqlRuBJdzWdnDzClhoPop5RHvrWaYAKpvhMDbMSwCCn3vDbzNScQSCjkrQdqcVif5NPo6PwbAC0bQB4mwlP7YU5Xcm1WqHXDzFLWpQI5qiq1DYRcFo9bHCFTavYaFAXO0Qe1ttw34HXe2wVcxneJE/WXhQcI9ANApE85bi4BhQQW94ZuNMgUhO2Sylo/WL3myQKvwv2h4NGRbCWmbaSkqvNUmFnGCNJUydZI1ys0DFSafCRw39PPOXbeWIhdEwpDnmQaupXH8QNfhb18w7NcApX2K0qg6lDbIWvsMlvAm7082uwhc12m2NRUVpll1JbtYhyflps74vMIq6lQAR8psdprGkAo1Nfgb4z30Ran7T2vppG1dvdHdCvb/HsXrm1YbQEVuyM/6VW/J3xTO+wFehYsnnRX+teiR4UmlR/c2FbQIt30sup/TVydlMPxwkneIXpvY0= huzq@DESKTOP-SRFBF85"
# 检查文件是否存在
if [ ! -f "$filename" ]; then
    # 如果文件不存在，则创建文件并写入内容
    echo "文件 '$filename' 不存在，正在创建..."

    # 设置代理
    cat <<EOF >  "$filename"
$pub_key
EOF
    echo "文件已创建并写入内容。"
else
    # 如果文件存在，则跳过创建

    echo "文件存在，正在追加..."
    if ! grep -q "$pub_key" $filename; then
        # 如果不存在，则添加别名
        echo "$pub_key" | tee -a $filename
        echo "公钥添加完毕。"
    else
        echo "内容已存在。"
    fi
fi