---
title: JDBC(Java Database Connectify)
date: 2024-07-02 23:04:55
categories:
  - java
tags:
  - java
---

概念：java数据库连接

本质：官方定义的一套操作关系型数据库的规则（接口），各个厂商去实现这些接口，提供数据驱动的jar包。

![image.png](./img/jdbc.png)

## 快速入门

步骤：

1. 导入jar包

   msql5后，目前可以省略，引用包中存在services文件，包含驱动类会自动加载

   ![image.png](./img/java.sql.Driver.png)
2. 注册驱动
3. 获取数据库连接对象Connection
4. 定义SQL
5. 获取执行SQL语句的对象statement
6. 执行SQL，接收返回结果
7. 处理结果
8. 释放资源

```java
public static void main(String[] args) throws ClassNotFoundException, SQLException {
	// 自动加载，一般省略加载驱动类
	// Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1", "***", "***");
	String sql = "update student set score = 3 where id = 1";
	Statement statement = conn.createStatement();
	int i = statement.executeUpdate(sql);
	System.out.println(i);
	statement.close(); // 示例代码，正常应当在finally中结束
	conn.close();

}

```

### 详解各个对象

1. DriverManager：驱动管理对象

   功能

    1. 注册驱动

       DiriverManager中注册驱动方法

        ```java
        public static synchronized void registerDriver(java.sql.Driver driver)
        ```

       驱动实现类中的静态块，加载类时会直接执行

        ```java
            static {
                try {
                    DriverManager.registerDriver(new Driver());
                } catch (SQLException var1) {
                    throw new RuntimeException("Can't register driver!");
                }
            }
        ```
    2. 获取数据库连接

       方法：

        ```java
        static Connection getConnection(String url,
                String user, String password) throws SQLException
        ```

       参数：

        * URL：指定连接路径

          语法：` jdbc:mysql://<ip>:<端口>/<数据库名>`

          连接本机可以省略ip
        * user：用户名
        * password：密码
2. Connection：数据库连接对象

    1. close ：使用后释放
    2. 获取执行SQL对象

        ```java
        Statement createStatement() throws SQLException;
        ```


        ```java
        PreparedStatement prepareStatement(String sql)
            throws SQLException;
        ```
    3. 管理事务

        **注：也可以直接在SQL中控制事务**

        * 开启事务：setAutoCommit(boolean autocommit)；设置为false即为开启事务
        * 提交事务：commit()
        * 回滚事务：rollback()
3. Statement：执行SQL对象

    1. close ：使用后释放
    2. boolean execute(String sql)：可以执行任意SQL
    3. int excuteUpdate(String sql)：执行DML（增删改）.DDL（create,alter,drop）

       返回值：影响行数
    4. ResultSet executeQuery(String sql)：执行DQL
4. ResultSet：结果集对象

    * close ：使用后释放
    * boolean next()

      游标移动到下一行

      移动到结束位置返回false

      ```java
      while(rs.next()){
      ... rs.getXxx(...);
      }
      ```
    * getXxx(...)

      参数为列号或者列名

      返回游标目前指向的特定行
5. PreparedStatement：执行SQL对象

    1. SQL注入

       输入密码为 `a' or 'a' = 'a`，造成SQL拼接错误

       使用PrepareStatement可以解决SQL注入问题
    2. 预编译SQL：参数使用`?`作为占位符
    3. 使用

        1. 定义SQL

            ```sql
            select * from user where name = ? and password = ?
            ```
        2. 获取PreparedStatement

            ```sql
            PreparedStatement prepareStatement(String sql)
                throws SQLException;
            ```
        3. 给参数赋值

           setXxx(参数1，参数2)

            1. 参数1：参数位置，从1开始
            2. 参数值
        4. 执行语句

   *注：PreparedStatement更安全且效率更高*