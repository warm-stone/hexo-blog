---
title: HTTP
date: 2024-07-02 22:30:25
categories:
  - java
  - web服务器
tags:
  - java
  - http
---
### 特点：

1. 基于TCP/IP协议
2. 默认端口80
3. 基于请求/相应模型：一次请求对应一次相应
4. 无状态通信，每次请求间相互独立，不能交互数据

### 版本

1.0：每次请求完成后断开连接，下次请求建立新连接

1.1：复用连接


### 请求消息数据格式

1. 请求行

   > 请求方式    请求URL   请求协议/版本
   >
   > 如
   >
   > POST /login.html HTTP/1.1
>
2. 请求头

   > 请求头名称：请求头值
   >

   常见头：

    1. User-Agent: 标识浏览器信息
    2. Regerer: 标识跳转来源
    3. Accept: 可接收内容类型
    4. Connection: 连接类型
3. 请求空行

   > 空行，用于分隔请求头和请求体
>
4. 请求体

   规定Post类型请求允许请求体，实际可自行操作（部分框架不支持）


## 请求与相应

1. Request和Response对象是由服务器创建的，框架封装后提供给开发人员使用
2. request对象获取请求消息，response对象来设置相应消息

### 请求体Request

1. 请求体体系：

   ServletRequest    -- 接口

        |

   HttpServletRequest -- 接口

        |

   org.apache.catalina.connector.RequestFacede  -- 类（tomcat）
2. 功能

    1. 获取请求数据

        1. 请求行数据

           请求行

           `GET /day14/demo1?name=lisi HTTP/1.1`

            1. 获取请求方式`GET`

               `String getMethod()`
            2. 获取虚拟目录 `/day14`

               `String getContextPath()`
            3. 获取Servlet路径 `/demo1`

               `String getServletPath()`
            4. 获取get方式请求参数 `name=lisi`

               `String getQueryString()`
            5. 获取请求URI

                * `String getRequestURI()`  `/day14/demo1`
                * `StringBuffer getRequesURL()`  `http://locahost/day14/demo1`
            6. 获取协议版本

               `String getProtocol()`
            7. 获取客户机IP

               `String getRemoteAddr()`
        2. 请求头数据

            1. `String getHeader(String name) `

               通过头名称获取值
            2. `Enumeration<String> getHeaderNames()`

               获取所有请求头名称
        3. 请求体数据

           步骤：

            1. 获取流对象   **一般读取完毕不关闭流****，由容器控制**

                * BufferReader getReader() : 获取字符输入流 ，只能操作字符数据
                * ServletInputStream getInputStream() : 获取字节数据，可以操作所有类型数据
            2. 从流对象中读取数据
    2. 其他

       中文乱码：以HTML编码标识类型进行解码

       `request.setCharacterEncoding("utf-8")`

        1. 获取请求参数通用方式   **同时适用于get和post方式**

            1. `String getParamter(String name)`

               根据参数名称获取参数值
            2. `String[] getParameterValues(String name)`

               根据参数名称获取参数值，多用于复选框
            3. `Enumeration<String> getParameterNames()`

               获取所有请求的参数名称
            4. `Map<String, String[]> getParameterMap()`

               获取参数map
        2. 请求转发

           Servlet访问其他Servlet

           步骤：

            1. 通过request对象获取请求转发器对象

               `RequestDispatcher getRequestDispatcher(String path)`
            2. 使用dispatcher进行转发

               `void forward(ServletRequest request, ServletResponse response)`

           特点：

            1. 浏览器地址栏路径不发生变化
            2. 浏览器只进行了一次请求
            3. 只能转发到容器内部资源中
        3. 共享数据

            * **域对象**：一个有作用范围的对象，可以在范围内共享数据
            * requst域：代表一次请求的范围，一般用于请求转发的资源共享处理
            * 方法：

                1. `void setAttribute(String name, Object obj)`
                2. `void getAttribute(String name)`
                3. `void removeAttribute(String name)`
        4. 获取ServletContext

           request获取servletContext方法

           `ServletContext getServletcontext()`
