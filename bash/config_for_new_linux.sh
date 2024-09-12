#!/bin/bash
filename="/etc/profile.d/custom_proxy.sh"
content="这是文件中的第一行。"
# 检查文件是否存在
if [ ! -f "$filename" ]; then
    # 如果文件不存在，则创建文件并写入内容
    echo "文件 '$filename' 不存在，正在创建..."

    # 设置代理
    cat <<EOF >  "$filename"
export proxy="http://clash:12321@istore.name:7890"
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