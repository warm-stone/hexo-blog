---
title: HTML
date: 2024-06-20 01:52:24
categories:
  - web 前端
tags:
---

Hyper Text Markup Language

[HTML 标签参考手册 (w3school.com.cn)](https://www.w3school.com.cn/tags/index.asp)

## 快速入门

1. html文档后缀名 ：`html`,`htm`
2. 标签

    1. 围堵标签：有开始标签和结束标签
    2. 自闭和标签。 如`<br/>`
3. 标签可以嵌套，后开先闭
4. 开始标签中可以定义属性。属性由键值对构成，值需要使用引号（**单双均可**）引起来
5. html标签不区分大小写，建议使用小写

### 标签

1. 文本标签：基本标签

    * `html`

      html文档的根标签
    * `head`

      头标签。用于指定HTML文档的一些属性，引用外部资源
    * `title`

      标题
    * `body`

      文档题
    * `<!DOCTYPE html>`
2. 文本标签

    * 注释

      ```html
      <!-- 注释内容 -->
      ```
    * `<br />`

      换行
    * h1 - h6

      各级标题
    * `<p>`

      段落标签
    * `<hr>`

      h4后均不再使用，浏览器兼容可以识别属性

        * corlor：颜色
        * width：宽度
        * size：高度
        * align：对齐

          center, left, right
    * `<b>` 加粗
    * `<i>` 斜体
    * `<font>`

        * color：颜色
        * size：大小
        * face：字体
    * `<center>`

      文本居中
3. 图片标签

   `<img>`:

   src ：指定图片路径
4. 列表标签

    * `<ol>`：有序列表

    * `<ul>`：无序列表

   `<li>`：列表项
5. 链接标签

    * `<a>`：超链接

      属性：

        *  href ：指定访问URL

        * target

          _self：当前页面打开

          _blank：新页面打开

      内容：

        * 网址
        * 本站资源：直接引用相对刘静资源
        * mailto：邮件
6. `<span>`

   没有任何样式，文本信息在一行显示，行内标签，内联标签
7. `<div>`

   没有任何样式，每个div占满一行。块级标签
8. 语义化标签：h5为了提高程序可读性提供了一些标签，没有任何样式，仅为了方便阅读和编写代码

    1. `<header>`
    2. `<footer>`
9. 表格标签

    * `table`：定义表
    * `tr`：行
    * `td`：单元格

      合并单元格用属性：

      `colspan`：指示单元格所占行数

      `rowspan`：指示单元格所占列数


    下方无样式，仅为方便阅读和编写代码

    * `thead`：表头
    * `tbody`：表体
    * `tfoot`：表脚
10. `form` **表单**，用于定义数据采集的范围

    * 属性：

        * action：指定提交的URL
        * method：指定提交方式

            * get

                * 请求参数会显示在地址栏中
                * 请求参数大小有限制
                * 不安全

            * post

                * 请求参数在请求体里
                * 参数大小无限制
                * 相对较为安全
        * name：指定名称，被提交的项必须有此属性

    1. `input`

       属性：

        * `type`

            * `text`：文本
            * `password`：密码
            * `radio`：单选框

              `name`相同为一个选择组

              使用`value`确定被选中后的内容

              使用`checked`属性默认选中
            * `checkbox`：多选框

              name相同为一个选择组

              使用`value`确定被选中后的内容

              使用`checked`属性默认选中
            * placeholder：指定输入框的提示信息
            * `file`：文件
            * `hidden`：隐藏域，用于提交隐藏信息
            * `submit`：提交
            * `button`：按钮
            * `img`：图片，可以使用scr属性设置图片
            * `color`：拾色器
            * `date`：日期
            * `datetime-local`：时间日期
            * `email`：邮箱
            * `number`：数字
    2. `lable`

       layle的for属性一般会和input的id属性值对应。使用后点击label区域input会获取焦点
    3. `select`：下拉列表

       option设置子项，selcted默认选中
    4. `textarea`：文本域

       cos指定每行字符数

       rows指定默认多少行

form示例

```html
<!DOCTYPE html>
<html lang="ch" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<form action="#" method="get">
    <label for="username">用户</label>
    <input id="username" name="username" type="text"/>
    <br/>
    <label for="pass">密码</label>
    <input id="pass" name="pass" type="password"/>
    <br/>
    <label>
        文件：
        <input type="file" name="file"/>
    </label>
    <br/>
    <label>
        生日：
        <input type="date" name="file"/>
    </label>
    <br/>
    <input type="hidden" name="msg" value="123"/>
    <label>
        省份：
        <select name="province">
            <option>--请选择--</option>
            <option value="1">北京</option>
            <option value="2">上海</option>
        </select>
    </label>
    <br/>
    <label>
        自我描述：
        <textarea name="des" cols="20" rows="5"></textarea>
    </label>
    <br/>
    <input type="submit" value="登录"/>
    <br/>
    <input type="button" value="按钮">
    <br/>
    <input type="image" src="Snipaste_2022-03-25_00-05-10.png">
</form>
</body>
</html>
```

color取值：

1. red, green, blue
2. rgb(value1, value2, value3)：取值1-255
3. #value1,value2,value3, 取值00-FF，如 #FF00FF （推荐）

width取值：

1. 数值：width=‘20’,单位默认px
2. 数值%：标识占比


### 事件

[HTML 事件参考手册 (w3school.com.cn)](https://www.w3school.com.cn/tags/html_ref_eventattributes.asp)

1. 点击事件

    1. onclick: 单击

       通过入参获取按下的按钮

        ```javascript
        document.getElementbById("id").onclick = function(){
        	...
        }
        ```

        ```javascript
        document.getElementbById("id").onclick = function(event){
        	// 获取鼠标点击按键
        	var bt = event.button;
        }
        ```
    2. ondbclick: 双击
2. 焦点事件

    1. onblur: 失去焦点
    2. onfocus: 获得焦点
3. 加载事件

   onload: 页面或图像加载完成

    ```javascript
    window.onload = function() {
    	// 一般绑定事件等操作需要加载完成后运行
    }
    ```
4. 鼠标事件

    1. onmousedown: 鼠标被按下
    2. onmouseup: 鼠标被松开
    3. onmousemove: 鼠标被移动
    4. onmouseover: 鼠标移动到元素上
5. 键盘事件

    1. onkeydown: 按键被按下
    2. onkeyup: 按键抬起
    3. onkeypress: 按键点击
6. 选择和改变

    1. onchange: 域的内容被改变
    2. onselect: 文本被选中
7. 表单事件

    1. onsubmit: 确认按钮被点击

       返回false可以阻止表单提交
    2. onreset: 充值按钮被点击