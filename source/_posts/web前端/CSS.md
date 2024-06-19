---
title: CSS
date: 2024-06-20 01:51:46
categories:
  - web 前端
tags:
---

层叠样式表(英文全称：Cascading Style Sheets)是一种用来表现[HTML](https://baike.baidu.com/item/HTML)（[标准通用标记语言](https://baike.baidu.com/item/%E6%A0%87%E5%87%86%E9%80%9A%E7%94%A8%E6%A0%87%E8%AE%B0%E8%AF%AD%E8%A8%80/6805073)的一个应用）或[XML](https://baike.baidu.com/item/XML)（标准通用标记语言的一个子集）等文件样式的计算机语言。CSS不仅可以静态地修饰网页，还可以配合各种脚本语言动态地对网页各元素进行格式化。


CSS控制样式优势

1. 功能强大
2. 将内容展示与样式控制分离

    1. 解耦
    2. 让分工合作更容易
    3. 提高开发效率

CSS使用

1. 内联样式

   在标签内使用styles属性指定css代码

    ```html
    <div style="color:red;">hello css</div>
    ```
2. 内部样式

   在`head`标签内使用`style`标签，标签内容即css代码

   定义后当前页面`div`内所有内容应用格式

    ```html
        <style>
            div{
                color: red;
            }
        </style>
    ```
3. 外部样式

    1. 定义css资源文件
    2. `head`标签内使用`link`标签引入外部资源（或使用style标签 @import引用)


### css语法

格式：

```css
<选择器>{
	<属性1>:<属性值1>;
	<属性2>:<属性值2>;
	...
}
```

### 选择器

选择器：筛选具有相似特征的元素

分类：

1. 基本选择器

    1. id选择器（优先级最高）

       `#<id>{...}`
    2. 类选择器（优先级中等）

       `.<class名>{...}`
    3. 元素选择器（优先级最低）

       `<标签>{...}`
2. 扩展选择器

    1. \* ：选择所有元素

       `*{...}`
    2. 并集选择器   选择几种选择器这

       `选择器1，选择器2{}`
    3. 子选择器  选择选择器1下的选择器2

       `选择器1 选择器2{}`
    4. 父选择器 选择包含选择器2的选择器1

       `选择器1 > 选择器2{}`
    5. 属性选择器：选择元素名称，属性名=属性值

       `选择器1\[属性=属性值\]{}`
    6. 伪类选择器：选择一些元素具有的状态

       `<元素>:<状态>{}`

       <a>超链接标签

        * link: 初始化
        * visited: 访问过
        * active: 正在访问
        * hover: 鼠标悬停

        ```css
        a:link{
        	color:green;
        }
        ```


### 属性

1. 字体文本

    * front-size：字体大小
    * color：颜色
    * text-align：对齐方式
    * line-height：行高
2. 背景

   background

    ```css
    background: url(<图片地址>) no-repeat center
    ```
3. 边框

   border

    ```css
    border: 1px solid red
    ```
4. 尺寸

    * width: 宽度
    * height: 高度
5. 盒子模型

    * `margin`: 外边距
    * `padding`: 内边距

      默认会影响盒子大小

      使用`box-sizing： border-box`固定盒子大小
    *   `float`: 浮动