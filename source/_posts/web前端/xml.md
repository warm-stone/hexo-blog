---
title: xml
date: 2024-06-20 01:50:04
categories:
  - web 前端
tags:
---

[XML系列教程 (w3school.com.cn)](https://www.w3school.com.cn/x.asp)

与HTML区别

1. XML标签都是自定义的，HTML标签都是预定义的
2. XML语法更严格
3. XML用于存储数据，HTML用于展示数据

### 功能

存储数据

1. 配置文件
2. 在网络中传输

### 语法

1. 文档后缀名为 `xml`
2. **第一行**必须为文档声明
3. 有且仅有一个根标签
4. 属性值需要用引号包裹
5. 标签需要正常关闭
6. 标签名称区分大小写

### 组成部分

1. 文档声明

    1. 格式 `<?xml 属性列表 ?>`
    2. 属性列表

        1. version: 版本号，必须属性
        2. encoding: 编码方式，默认 `ISO-8859-1`
        3. standalone:

           是否独立

           yes 不依赖其他文件

           no 依赖其他文件
2. 指令  结合CSS使用

   以下代码会尝试查找a.css来添加样式

    ```xml
    <?xml-stylesheet type="text/css" herf="a.css" ?>
    ```
3. 标签

    1. 不能以数字或符号开头
    2. 不能以字母xml、Xml、XML开头
    3. 不能包含空格
4. 属性

   id属性唯一（存疑）
5. 文本

   CDATE区   区域内数据会被识别为纯文本

    ```xml
    <![CDATA[
    	数据
    ]]>
    ```

# 约束

分类：

1. DTD

   简单的约束技术
2. Schema

   复杂的约束技术

### DTD

1. 内部dtd：约束规则定义在xml文件中

    ```xml
    <!DOCTYPE 根标签名 [
    	约束内容
    ]>
    ```


    ![image.png](assets/image-20220412225315-3wgb54x.png)
2. 外部dtd：约束规则单独编写文档

    1. 本地引用：

        ```xml
        <!DOCTYPE 根标签名 SYSTEM "dtd文件位置">

        ```
    2. 网络引用：

        ```xml
        <!DOCTYPE 根标签名 PUBLIC "dtd文件名" "dtd文件url">
        ```


### Schema

* xsi: schema执行实例

* schemaLocation: <URI1> <URI2>

  URI1 ：前缀

  URI2： 约束地址
* xmlns:<命名空间>:<URI1>

  用于确定标签属于哪个命名空间，来确定唯一的标签


![image.png](assets/image-20220412231127-r2gwtmn.png)