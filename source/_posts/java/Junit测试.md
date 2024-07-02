---
title: Junit测试
date: 2024-07-02 23:15:25
categories:
  - java
tags:
  - java
---

建议：

* 测试类名：测试类名+Test命名
* 包名：xxxx.xxx.xx.test
* 方法名：test+"_"+测试方法名+"_"+case名 如 test_add_null_param
* 无返回值，无入参

> 1. 添加Junit依赖
>
> 2. 给方法加**@Test**注解运行


注解：

* @Test

  测试方法注解
* @Before

  每次测试前
* @After

  每次测试后
* @BeforeClass

  测试类准备
* @AfterClass

  测试类清理



```java
package com.javalearn.junit;


import org.junit.*;

public class MyMathTest {

    @BeforeClass
    public static void  beforeClass(){
        System.out.println("@BeforeClass");
    }

    @AfterClass
    public static void afterClass(){
        System.out.println("@AfterClass");
    }


    @Before
    public void beforeTest()
    {
        System.out.println("@Before");
    }

    @After
    public void after(){
        System.out.println("@After");
    }

    @Test
    public void test_1() {
        System.out.println("测试一");
    }

    @Test
    public void test_2() {
        System.out.println("测试二");
    }
}
```


输出：

> @BeforeClass
> @Before
> 测试一
> @After
> @Before
> 测试二
> @After
> @AfterClass
