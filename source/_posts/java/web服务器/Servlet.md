---
title: Servlet
date: 2024-07-02 23:01:14
categories:
  - java
  - web服务器
tags:
  - java
  - servlet
---

概念：运行在服务器端的的小程序

* Servlet就是一个接口，定义了被web容器识别的规则


### 快速入门

### 数据流转过程

1. 服务器接收到客户端请求，解析URL路径，获取访问的Servlet资源路径
2. 在`web.xml`中的`url-pattern`查找相应路径，并找到相应类
3. 执行类的响应方法


### Servelet声明周期

Servlet为单例，定义成员变量可能有线程安全问题

```java
// 初始化，执行一次  
void init(ServletConfig var1) throws ServletException;
// 获取配置，可不实现
ServletConfig getServletConfig();
// 提供服务，多次执行
void service(ServletRequest var1, ServletResponse var2) throws ServletException, IOException;
// 获取服务信息，可不实现
String getServletInfo();
// 销毁方法，容器被正常关闭时执行
void destroy();
```


### Servlet3.0

优势：

* 支持注解配置


步骤：

1. 创建javaEE项目，选择`Servlet3.0`以上版本，可以不创建`web.xml`
2. 实现Servlet接口
3. 使用`@webServlet`进行配置

    ```java
    @WebServlet("/servlet3demo")
    ```
4. Servlet相关配置

    1. urlPatterns: 可以配置多个

        ```java
        @WebServlet({"/servlet3demo","/demo"})
        ```
    2. 路径定义规则

        1. `/xxx`直接路径
        2. `/xxx/xxx` 多层路径
        3. `*.xxx` 带.xxx的路径


#### Servlet体系结构

`Servlet`-- 接口

|

`GenericServlet`-- 抽象类

|

`HttpServlet`-- 抽象类

1. `GenericServlet`

   将`Servlet`其他方法做了默认实现，`service()`方法抽象，需要实现
2. `HttpServlet`  对http协议的封装实现，简化了操作

   覆写`doGet()`,`doPost()`等方法执行相应http操作