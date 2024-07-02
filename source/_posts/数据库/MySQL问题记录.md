---
title: MySQL问题记录
date: 2024-07-02 22:10:53
categories:
  - 数据库
tags:
  - MySQL
---
# 时间查询与设置时间不同

时区问题

解决方法：

1. 临时更改服务

```sql
set global time_zone = '+8:00'; ##修改mysql全局时区为北京时间，即我们所在的东8区
set time_zone = '+8:00'; ##修改当前会话时区
flush privileges; #立即生效
```

2. 更改配置

```sql
vim /etc/my.cnf  在[mysqld]区域中加上

default-time_zone = '+8:00'

/etc/init.d/mysqld restart ##重启mysql使新时区生效
```

3.

这里，以php为例，在mysql_connect()下使用:

mysql_query("SET time_zone = '+8:00'")