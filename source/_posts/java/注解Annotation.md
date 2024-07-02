---
title: 注解Annotation
date: 2024-07-02 23:08:41
categories:
  - java
tags:
  - java
---

说明程序的，给计算机看的

注解，也交元数据。一种代码级别的说明，在JDK1.5之后引入的特性，与类、接口、枚举在同一层次。可以声明在报、类、字段、局部变量、方法参数等前面，用与对象相关元素进行说明。


作用分类：

1. 编写文档：通过相关元数据生成doc文档
2. 代码分析：通过相关元数据对代码进行分析【使用反射】
3. 编译检查：编译器识别相关元数据进行编译检查【如Override】

# JDK预定义注解

* @Override：编译检查，标识方法来自父类或接口定义
* @Deprecated：标识被标识元素以过时，不建议使用被标识元素
* @SuppressWarning：压制警告


# 自定义注解

格式：

public @interface 注解名

注解实际上是继承自java.lang.annotation.Annotation 的接口<br />

如：

```java
public @interface MyAnno {
}
```

实际为

```java
public interface com.javalearn.annotation.MyAnno extends java.lang.annotation.Annotation {
}
```

* 属性： 注解的抽象方法

    1. 要求属性的返回值必须为以下之一：

        * 基本数据类型
        * String
        * 枚举
        * 注解
        * 以上类型的数组
    2. 在使用属性时需要给属性赋值，或在定义时设置默认值
    3. 仅有一个属性需要赋值且属性名为**value**，可以省略赋值时的属性名
    4. **数组**赋值使用大括号{}，数组中仅有一个元素可以省略括号


# 元注解

* @Target

  描述注解能够作用的位置

  ElementType取值：

    * TYPE：可以作用于类上
    * METHOD：方法
    * FIELD：成员变量
    * PARAMETER
    * CONSTRUCTOR
    * LOCAL_VARIABLE
    * ANNOTATION_TYPE
    * PACKAGE
    * TYPE_PARAMETER
    * TYPE_USE
* @Retention

  描述注解被保留的阶段

  RetentionPolicy取值：

    * SOURCE：仅在源代码保留，编译时抛弃
    * CLASS：编译是保留，运行时不载入
    * RUNTIME：保留至运行时，自定义注解一般使用此注解
* @Documented

  描述注解是否被抽取到api文档中
* @Inherited

  描述注解是否被子类继承

# 解析注解

1. 获取注解定义的位置的对象 （Class, Method, Field)
2. 获取指定注解
3. 调用注解方法获取相应值

代码示例：


```java
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
public @interface InvokeInfo {
    String className();
    String methodName();
}


public class AnnoReflectorFrame {

    @InvokeInfo(className = "com.javalearn.reflect.Person", methodName = "staticTest")
    public static void main(String[] args) throws IOException, ClassNotFoundException, NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        // 读取配置文件
/*        Properties properties = new Properties();

        ClassLoader classLoader = AnnoReflectorFrame.class.getClassLoader();
        InputStream inputStream = classLoader.getResourceAsStream("reflect" + File.separator + "reflect.properties");
        properties.load(inputStream);

        String className = properties.getProperty("class");
        String methodName = properties.getProperty("method");*/

        Method main = AnnoReflectorFrame.class.getMethod("main", String[].class);
        InvokeInfo annotation = main.getAnnotation(InvokeInfo.class);
        System.out.println(annotation);

        String className = annotation.className();
        String methodName = annotation.methodName();
        // 加载类并执行方法
        Class<?> cls = Class.forName(className);
        Method declaredMethod = cls.getDeclaredMethod(methodName);
        declaredMethod.invoke(null);

    }
}
```