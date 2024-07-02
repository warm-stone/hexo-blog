---
title: java
date: 2024-07-02 22:25:05
categories:
  - java
tags:
  - java
---
### 内存分区

String 是否使用new关键字是使用内存区别

1. 静态区
2. 堆

### 集合框架

继承关系了解，每种实现了解

### 并发

![image.png](./img/java并发.png)

### IO框架

![image.png](./img/java_io.png)



# 时间格式化



```sql
// https://blog.csdn.net/qq_27093465/article/details/53034427
    private static void formatDataTest() {
        /*
         * 日期转期望格式的字符串
         */
        //HH 和 hh 的差别：前者是24小时制，后者是12小时制。
        StringBuilder sb = new StringBuilder();
        sb.append("yyyy年MM月dd日 HH:mm:ss")
                .append(" 上下午标志 a")
                .append(" E")
                .append(" 一年中的第D天")
                .append(" 一月中的第F个星期")
                .append(" 一年中的第w个星期")
                .append(" 一月中的第W个星期")
                .append(" Z")
                .append(" z");
        SimpleDateFormat sdf = new SimpleDateFormat(sb.toString());
        String dateString = sdf.format(new Date());
        System.out.println(dateString);
        /*
         * 字符串转日期
         */
        Date date;
        try {
            date = sdf.parse(dateString);
            System.out.println(date);
        } catch (ParseException e) {
            System.out.println(e.getMessage());
        }
    }
```
