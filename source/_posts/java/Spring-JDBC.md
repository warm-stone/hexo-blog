---
title: Spring JDBC
date: 2024-07-02 23:03:17
categories:
  - java
tags:
  - java
---

定义：spring对jdbc简单封装，提供了JDBCTemplate，简化JDBC开发。

**使用步骤：**

1. 导入jar包


    ```xml
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-jdbc</artifactId>
                <version>5.3.17</version>
            </dependency>
    ```
2. 创建JDBCTemplate对象。依赖于DataSource
3. 调用JdbcTemplate方法完成CRUD操作

   重点方法：

    * `update()`
    * `queryForMap()`

      查询结果长度只能为1
    * `queryForList()`

      返回List<Map<xx,xx>>
    * `query()`

      返回List<..>，需要额外传入**RowMapper**以映射对象字段与ResultSet

      字段与数据库列名相同可以使用默认实现BeanPropertyRowMapper
    * `queryForObject()`

      返回单个结果，可以用于查询总记录数等

4. 示例

    ```java
    public class JdbcTemplateDemo {
        public static void main(String[] args) throws Exception {

            ClassLoader classLoader = JdbcTemplateDemo.class.getClassLoader();
            InputStream resourceAsStream = classLoader.getResourceAsStream("druid.properties");
            Properties properties = new Properties();
            properties.load(resourceAsStream);
            if (resourceAsStream != null) {
                resourceAsStream.close();
            }
            DataSource dataSource = DruidDataSourceFactory.createDataSource(properties);
            JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

            int update = jdbcTemplate.update("update student set score = 99 where id = ?", 1);
            System.out.println(update);
        }
    }
    ```
