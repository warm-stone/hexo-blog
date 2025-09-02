---
title: SQL
date: 2024-07-02 22:06:27
categories:
  - 数据库
tags:
  - SQL
---
Structured Query Language,结构化查询语言

大部分的SQL对数据库是通用的，少部分有自定义的用法

@[TOC]

# MySql

语句不区分大小写，关键字建议大写

* 注释：

    * 单行注释 使用横线+空格 或者"#"，如"-- 注释内容", "\#注释内容"
    * 多行注释 /* */

SQL分类：

1. 数据查询语言（DQL）
   数据查询语言（Data Query Language, DQL）是SQL语言中，负责进行数据查询而不会对数据本身进行修改的语句，这是最基本的SQL语句。保留字SELECT是DQL（也是所有SQL）用得最多的动词，其他DQL常用的保留字有FROM，WHERE，GROUP BY，HAVING和ORDER BY。这些DQL保留字常与其他类型的SQL语句一起使用。

2. 数据定义语言（DDL）
   数据定义语言 (Data Definition Language, DDL) 是SQL语言集中，负责数据结构定义与数据库对象定义的语言，由CREATE、ALTER与DROP三个语法所组成，最早是由 Codasyl (Conference on Data Systems Languages) 数据模型开始，现在被纳入 SQL 指令中作为其中一个子集。

3. 数据操纵语言（DML）
   数据操纵语言（Data Manipulation Language, DML）是SQL语言中，负责对数据库对象运行数据访问工作的指令集，以INSERT、UPDATE、DELETE三种指令为核心，分别代表插入、更新与删除。

4. 据控制语言（DCL）
   数据控制语言 (Data Control Language) 在SQL语言中，是一种可对数据访问权进行控制的指令，它可以控制特定用户账户对数据表、查看表、预存程序、用户自定义函数等数据库对象的控制权。由 GRANT 和 REVOKE 两个指令组成。DCL以控制用户的访问权限为主，GRANT为授权语句，对应的REVOKE是撤销授权语句。

5. *指针控制语言（CCL）* **非公认分类**
   它的语句，像DECLARE CURSOR，FETCH INTO和UPDATE WHERE CURRENT用于对一个或多个表单独行的操作。

6. *事务处理语言（TPL）*非公认分类
   它的语句能确保被DML语句影响的表的所有行及时得以更新。TPL语句包括BEGIN TRANSACTION，COMMIT和ROLLBACK。<br />

![image.png](./img/数据库连接示意.png)


## DDL：操作数据库

**操作数据库**：CRUD

1. C：Create 创建

   不存在则创建数据库并指定字符集

    ```sql
    create database if not exists dbname [character set gbk]
    ```
2. R：Retrieve 查询

    * SHOW DATABASES： 查看所有数据库
    * show create database dbname：查看数据库建表语句
3. U：Update 修改

    * alter database 数据库名称 character set 字符集
4. D：Delete 删除

   drop database if exists dbname
5. 使用数据库

    *  select database()

   查询在使用的的数据库
    * use dbname

      使用某数据库


**操作表**

1. C：Create 创建

    1. 语法：

        ```sql
        CREATE TABLE 表名（
         列名1 数据类型1，
         列名2 数据类型2，
        ...
        );

        ```
    2. 数据类型：

       > 1. int 整数类型
            >
            >     age int
       > 2. double 小数类型
            >
            >     score double(5, 2) -- 共5位，小数后2位
       > 3. date 日期类型， 格式 yyyy-MM-dd
       > 4. datetime 日期，格式 yyyy-MMdd HH:mm:ss
       > 5. timestamp 时间戳，格式 yyyy-MMdd HH:mm:ss，不赋值默认为当前系统时间
       > 6. varchar 字符串，长度为字符，与字节无关
            >
            >     name varchar(20)
            >
            >     -- 张三 2字符 ， zhangsan 8字符
    >
    3. 示例

        ```sql
        CREATE TABLE student(
         id int,
         name varchar(32),
         age int,
         score double(4,1),
         birthday date,
         insert_time timestamp
        );
        ```
    4. 复制表

        ```sql
         create table stu like student;
        ```
2. R：Retrieve 查询

    * SHOW TABLES： 查询所有表
    * desc <table_name>：查看表详情
    * **show create table <table_name>**
3. U：Update 修改

    1. 修改表名

        ```sql
        alter table <table_name> rename to <new_table_name>;
        ```
    2. 修改表字符集

        ```sql
        alter table <table_name> character set <字符集名称>;
        ```
    3. 添加列

        ```sql
        alter table <table_name> add <列名> <数据类型>;
        ```
    4. 修改列名称、类型

        ```sql
        alter table <table_name> change <列名> <新列名> <新数据类型>;
        alter table <table_name> modify <列名> <新数据类型>;
        ```

       上面可以发现modify和change都可以修改表的定义，但是change却需要写两次列名，不是很方便。但是change的优点是可以修改列名称，modify则不能
    5. 删除列

        ```sql
        alter table <table_name> drop <列名>;
        ```
4. D：Delete 删除

    ```sql
    drop table if exist <table_name> ;
    ```
5. 使用数据库

**代码示例：**

* 查询所有数据库

  ```sql
  mysql> SHOW DATABASES;
  +--------------------+
  | Database           |
  +--------------------+
  | information_schema | // 存储视图等
  | mysql              | // 数据库核心数据
  | performance_schema | // 新能数据
  | sakila             |
  | sys                |
  | world              |
  +--------------------+
  ```

* 查询建表语句

  ```sql
  mysql> show create database mysql
      -> ;
  +----------+---------------------------------------------------------------------------------------------------------------------------------+
  | Database | Create Database                                                                                                                 |
  +----------+---------------------------------------------------------------------------------------------------------------------------------+
  | mysql    | CREATE DATABASE `mysql` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */ |
  +----------+---------------------------------------------------------------------------------------------------------------------------------+
  1 row in set (0.00 sec)
  ```

* 不存在则创建数据库

  ```sql
  create database if not exists dbname
  ```

* 创建数据库并设置**字符集**

  ```sql
  create database if not exists dbname character set gbk
  ```

### 约束

概念：对表中的数据进行限定，保证数据的正确性、有效性、完整性。

分类：

1. 主键约束：primary key
2. 非空约束：not null
3. 唯一约束：unique
4. 外键约束：foreign key


#### 非空约束：not null

1. 创建表时添加约束

    ```sql
    CREATE TABLE stu(
    	id INT,
    	name VARCHAR(20) NOT NULL -- name非空
    );
    ```
2. 添加约束

    ```sql
    ALTER TABLE stu MODIFY <列名> VARCHAR(20) NOT NULL;
    ```
3. 删除约束

    ```sql
    ALTER TABLE stu MODIFY <列名> VARCHAR(20);
    ```


#### 唯一约束： unique，列值不能重复

1. 创建表是添加唯一约束

    ```sql
    CREATE TABLE stu(
    	id INT,
    	phone_number VARCHAR(20) UNIQUE -- 唯一
    );
    ```
2. 添加约束

    ```sql
    ALTER TABLE stu MODIFY <列名> VARCHAR(20) UNIQUE;
    ```
3. **删除唯一约束**，即删除唯一索引

    ```sql
    ALTER TABLE stu DROP INDEX phone_number;
    ```

4. **注意：唯一约束可以插入null，但该列中仅能有一个null**

#### 主键约束：primary key

1. 注意：

    1. 主键非空且唯一
    2. 一张表只可以定义一个主键
    3. 主键即表中记录的唯一标识
2. 创建表时添加主键

    ```sql
    CREATE TABLE stu(
    	id INT PRIMARY KEY, -- 主键
    	name VARCHAR(20)
    );

    CREATE TABLE stu(
    	id INT , -- 主键
    	name VARCHAR(20), 
    	PRIMARY KEY (id, name) -- 联合主键
    );
    ```

   l
3. 添加主键

    ```sql
    ALTER TABLE stu MODIFY <列名> INT PRIMARY KEY;
    ```
4. 删除主键

    ```sql
    ALTER TABLE stu DROP PRIMARY KEY; -- 删除主键
    ```
5. 自动增长

   概念：如果某一列是数值类型的，使用**auto_increment**可以实现自动增长

    1. 在创建表时实现主键自动增长

        ```sql
        CREATE TABLE stu(
        	id INT PRIMARY KEY AUTO_INCREMENT, -- 主键
        	name VARCHAR(20)
        );
        ```
    2. 删除自增

        ```sql
        ALTER TABLE stu MODIFY id INT; -- 不能跟着PRIMARY KEY，会报多主键错误
        ```
    3. 添加自增

        ```sql
        ALTER TABLE stu MODIFY id INT AUTO_INCREMENT; 
        ```

#### 外键约束：foreign key

1. 在创建表时，添加外键

    ```sql
    CREATE TABLE 表名（
    	...
    	外键列名称
    	[constraint 外键名称] foreign key (外键列名称) references 主表名称(主表列名称)
    );
    示例：
    CREATE TABLE employee (
    	id INT PRIMARY KEY AUTO_INCREMENT, -- 主键
    	name VARCHAR(20),
    	dep_id INT, -- 部门id
    	CONSTRAINT employee_dep_fk FOREIGN KEY (dep_id) REFERENCES department(id)
    );
    ```
2. 删除外键

    ```sql
    ALTER TABLE employee DROP FOREIGN KEY employee_dep_fk;
    ```
3. 添加外键

    ```sql
    ALTER TABLE employee ADD CONSTRAINT employee_dep_fk FOREIGN KEY (dep_id) REFERENCES department(id)
    ```

4. 级联操作

    1. 级联更新

        ```sql
        ALTER TABLE employee ADD CONSTRAINT employee_dep_fk FOREIGN KEY (dep_id) 
        REFERENCES department(id) ON UPDATE CASCADE; -- 主键更新，外键跟随更新
        ```

    2. 级联更新+级联删除

        ```sql
        ALTER TABLE employee ADD CONSTRAINT employee_dep_fk FOREIGN KEY (dep_id) 
        REFERENCES department(id) 
        ON UPDATE CASCADE ON DELETE CASCADE; -- 主键更新，外键跟随更新,主键删除，外键跟随删除
        ```

## DCL: 管理用户，授权

### 管理用户

1. 查询用户

    ```sql
    use mysql;
    select * from user;
    ```
2. 添加用户

   **host通配符：%表示可以在任意主机登录**

    ```sql
    create user <用户名>@<主机名> identified by <密码>;
    ```
3. 删除用户

    ```sql
    drop user <用户名>@<主机名>;
    ```
4. 修改用户密码

    ```sql
    update user set password = Password(<密码>) where user = <用户名> and host = <主机名>; -- 旧版
    set password for <用户名>@<主机名> = password(<密码>); -- 通用
    ```

   MySQL忘记root密码：

   > 1. 停止MySQL服务
        >
        >     ```shell
    >     # 关闭服务
    >     net stop <数据库服务名>
    >     ```
   > 2. 使用无验证方式启动MySQL
        >
        >     ```shell
    >     mysqld --skip-grand-tables;
    >     ```
   > 3. 无密码登录
        >
        >     ```shell
    >     mysql  # 无验证则直接登录
    >     ```
>


### 授权

1. 查询权限

    ```sql
    show grants for <用户名>@<主机名>
    ```
2. 授予权限

    ```sql
    grant <权限列表> on 数据库名.表名 to <用户名>@<主机名>
    ```
3. 撤销权限

    ```sql
    revoke <权限列表> on 数据库名.表名 from <用户名>@<主机名>
    ```
4. 权限列表

    * SELECT
    * UPDATE
    * INSERT
    * DELETE
    * CREATE
    * DROP
    * REFERENCES
    * INDEX
    * ALTER
    * CREATE VIEW
    * SHOW VIEW
    * TRIGGER

    * ALL

      所有权限

   *注：上述权权限为部分内容，许多部分系统操作权限未列出*
5. 数据库、表名通配符

   \*.\*：表示所有表、所有数据库

## DML：增删改查数据

1. 添加数据

    * 语法

      ```sql
      insert into 表名(列名1, 列名2...) values (值1, 值2...);
      ```
    * 注意：

        1. 列名与值一一对应
        2. 表名后无列名，根据定义顺序给所有列赋值
        3. **除数字类型**，其他类型均用引号（单双引号均可）引起来
2. 删除数据

    ```sql
    delete from 表名 [where 条件]

    truncate table 表名 -- 删除表，并创建相同表结构的表，删除较为高效
    ```
3. 修改数据

   语法

    ```sql
    update 表名 set 列名1 = 值1, 列名2 = 值2 ... [where 条件];
    ```


## DQL：查询表中的数据

1. 语法

    ```sql
    select
    	字段列表
    from
    	标名列表
    [where
    	条件列表]
    [group by
    	分组字段]
    [having
    	分组后的条件]
    [order by
    	排序字段]
    [limit
    	分页限定]
    ```

2. 基础查询

    1. 去重 distinct

        ```sql
        select distinct 字段1,字段2 from 表名 -- 记录结果集相同则会被去重
        ```
    2. 计算列

        * 可以使用四则运算计算列值
        * null操作函数  **ifnull** 字段为空的返回默认值

          ```sql
          ifnull(字段名，默认值) --
          ```
    3. 别名

       列名后加 “as 别名” ，as可省略

3. 条件查询

    1. where 后接条件
    2. 运算符

        * \> , < , >=,  <= , = , <>
        * BETEWEEN .. AND ..
        * IN (集合)
        * LIKE

          > 占位符
          >
          > * _：单个字符
          > * %：多个字符
          >
          > 部分可匹配
          >
          > 马%  ：马云，马化腾
          >
          > _化%  ：马化腾
          >
          > ___ : 马化腾 （三个字）
        >
        * IS NULL
        * AND 或 &&
        * OR 或 ||
        * not 或 !

   部分等价SQL：

    ```sql
    select * from student where age >= 20 and age <= 30;
    select * from student where age >= 20 && age <= 30;
    select * from student where age between 20 and 30;

    select * from student where age = 18 or age = 19;
    select * from student where age in (18, 19);




    ```

   查询空

    ```sql
    select * from student where english is null;
    select * from student where english is not null;
    ```

4. 排序查询

    * 语法： order by + 子句

      ```sql
      order by 排序字段1 排序方式1，排序方式2 排序方式2
      ```
    * 排序方式

      ASC：升序，默认

      DESC ：降序

   注意：多个排序条件时，前边条件相同，后边才生效
5. 聚合查询：将一列作为一个整体，进行纵向计算

    1. count：计算数量

        1. 一般选择非空列：主键
        2. count(*)
    2. max：计算最大值
    3. min：计算最小值
    4. sum：计算和
    5. avg：计算平均值

   注意：聚合函数会排除null值，如**count中不会包含null值**，**avg不会平均null**

   解决方式：

    1. 选择非空的列

    2. ifnull函数处理null值
6. 分组查询

    1. 语法：group by + 分组字段
    2. 注意：

        1. 分组后查询的字段仅可以为分组字段、聚合函数，其他字段MySQL不会报错，但没有意义
        2. where和having区别

            1. where在分组前进行限定，不满足条件则不参与分组；having在分组之后进行限定不满足条件则不会被查询到；
            2. where 后不可以跟聚合函数，having可以进行聚合函数的判断

   示例代码：

    ```sql
    select sex, avg(math), count(id) 人数
    from student 
    where math > 70
    group by sex
    having 人数> 2;
    ```
7. 分页查询

    1. 语法 **limit****方法为MySQL特有**

        ```sql
        limit 开始索引，每页条数
        ```

       > 开始索引 = （当前页码 - 1） *  每页条数
>


### 多表查询

笛卡尔积：有两个集合A，B，去两集合的所有组成情况的集合，称之为笛卡尔积

多表查询：

1. 内连接查询

    1. 隐式内连接

        ```sql
        SELECT
        	ti.id
        	,ti.name
        	,t2.id
        	,t2.name
        FROM
        	t1
        	,t2
        WHERE
        	t1.t2_id = t2.id;
        ```
    2. 显示内连接

        ```sql
        SELECT
        	ti.id
        	,ti.name
        	,t2.id
        	,t2.name
        FROM
        	t1
        [INNER] JOIN t2 ON t2.id = t1.t2_id; -- INNER关键字可省略，默认即为内连接
        ```
2. 外连接查询

    1. 左外连接

       查询左表所有数据，连接右表

        ```sql
        SELECT
        	ti.id
        	,ti.name
        	,t2.id
        	,t2.name
        FROM
        	t1
        LEFT [OUTER] JOIN t2 ON t2.id = t1.t2_id; -- OUTER关键字可省略
        ```
    2. 右外连接

        ```sql
        SELECT
        	ti.id
        	,ti.name
        	,t2.id
        	,t2.name
        FROM
        	t1
        RIGHT [OUTER] JOIN t2 ON t2.id = t1.t2_id; -- OUTER关键字可省略
        ```
3. 子查询

   概念：查询中嵌套查询，成嵌套查询为子查询

    ```sql
    -- 例如查询最高工资员工信息
    SELECT 
    	* 
    FROM 
    	emp 
    WHERE
    	emp.salary = (
    		SELECT MAX(salary) FROM emp
    	);
    ```

   **子查询不同情况**

    1. 子查询结果是单行单列

       子查询可以作为条件，使用运算符直接判断：>, >=, <, <=, =

        ```sql
        SELECT
        	ti.id
        	,ti.name
        FROM
        	t1
        where ti.t2_c > (SELECT ...)
        ```
    2. 结果是多行单列

       子查询可以使用IN操作符处理

        ```sql
        SELECT
        	ti.id
        	,ti.name
        FROM
        	t1
        where ti.t2_c IN (SELECT ...)
        ```
    3. 结果是多行多列

       子查询为多行多列可以被看作**虚拟表**，可以参与查询

        ```sql
        SELECT
        	ti.id
        	,ti.name
        FROM
        	t1
        	,(SELECT ...) t2
        where t1.c1 = t2.c2;
        ```


## 事务

概念：一个包含多个步骤的业务操作被事务管理，要么同时成功，要么同时失败，不会成功一部分。

### 操作：

1. 开启事务： start transaction;
2. 回滚：rollback;
3. 提交：commit；
4. MySQL数据库中事务默认自动提交

   一调DML语句会自动提交一次事务

   事务提交两种方式

    * 自动提交

      默认执行即自动提交
    * 手动提交

      先开启事务，则需要手动提交

   **事务的默认提交方式：**

    * 查看

      ```sql
      SELECT @@autocommit; -- 1 为默认自动提交
      ```
    * 修改

      ```sql
      SET  @@autocommit = 0; -- 修改为默认不提交
      ```

### 事务的四大特征

1. 原子性（Atomicity）

   是不可分割的最小操作单位，要么同时成功，要么同时失败
2. 一致性（Consistency）

   事务操作前后数据库中的数据都是一致的、正确的
3. 隔离性（Isolation）
4. 持久性（Durability）

   事务提交活回滚后，数据库会持久的保存数据，无论断电还是重启，数据库都不会丢失提交操作

### 事务的隔离级别

概念：多个事务之间是隔离的，相互独立的。如果多个书屋操作同一批数据会引发冲突，通过设置不同的事务隔离级别来解决这些冲突。

**事务冲突的类型：**

1. 脏读

   a事务读取到了b事务未提交的数据，b事务可能会将未提交的数据回滚
2. 不可重复读（虚读）

   a事务读取某些数据，b事务操作了该数据并提交了修改，a事务再次读取时与第一次结果不一致
3. 幻读

   不可重复读相似，a事务读取了某个范围内的数据，b事务插入了新的符合a事务选取条件的数据并提交，a事务再次读时发现与第一次读取时结果集不一致；

   通常演示时为a事务修改某表中某范围内数据，b事务插入符合a表筛选条件的数据并提交，a事务再次查询时返现修改范围内仍有数据

**隔离级别：**

1. read uncommitted （读未提交）

   会产生问题：脏读，不可重复读，幻读
2. read committed（读已提交）（Oracle默认）

   会产生问题：不可重复读，幻读
3. repeatable read（可重复度） （MySQL默认）

   会产生问题：幻读
4. serializable（串行化）

   不会产生问题

*注意*：上述隔离级别依次安全性越来越高，效率越来越低

**查询隔离级别：**

```sql
select @@tx_isolation; -- 旧版
select @@transaction_isolation; -- 新版
```

**设置隔离级别：**

```sql
set global transaction isolation level <隔离级别>; -- 断开连接重新连接才会生效

set session transaction isolatin level <隔离级别>; -- 设置当前会话隔离级别
```
