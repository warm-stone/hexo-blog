---
title: JavaScript
date: 2024-06-20 01:51:18
categories:
  - web 前端
tags:
---

[JavaScript 教程 (w3school.com.cn)](https://www.w3school.com.cn/js/index.asp)

## ECMAScript

### 基本语法

1. 与html结合方式

   **注意：script可以定义再任何位置，但是会按顺序执行，一般会放在最后**

    1. 内部JS

       `script`标签内编写js代码
    2. 外部JS

       `scrip`属性`src`引入js文件
2. 注释

    1. 单行注释 : //
    2. 多行注释: /*   */
3. 数据类型

    1. 原始数据类型

        1. number

            * 整数
            * 小数
            * NaN
        2. string: 字符、字符串
        3. boolean
        4. null
        5. undefined : 变量未初始化值默认为此值
    2. 引用数据类型：对象
4. 变量

   弱类型语言：变量存放任意类型的变量

   语法：

    ```js
    var a = 3;
    document.write(a+"<br>")
    a = "abc";
    document.write(a+"<br>")
    ```
5. 运算符

    1. 一元运算符

       ++，--
    2. 算数运算符

       +，-，*，/，%。。。
    3. 赋值运算符
    4. =，+=，-= 。。。
    5. 比较运算符

       \>, <, >=, <=, ==, ===（全等于）

       > 字符串比较从左到右按位比较
       >
       > ==类型不同先转换类型，后比较
       >
       > ===类型不同直接返回false
    >
    6. 逻辑运算符

       &&，||， ！
    7. 三元运算符

       ?  :

   **注意：运算符不符合条件时会自动进行转换**

   **转number规则：**

    1. string转number：按照字面值转，字面非数字则转为NaN
    2. boolean转number：true为1，false为0

   **转boolean规则：**

    1. number：0，NaN为假，其他为真
    2. string：除空字符串，其他为真
    3. null, undifined：false
    4. object：true
6. 流程控制

    1. `if... else`
    2. `switch`

       java中switch仅可以接收原始数据类型、枚举和string，js中可以接收任意类型
    3. `while`
    4. `do.. while`
    5. `for`
7. JS特殊语法（不建议使用）

    1. 语句以`;`结束，也可以以`\n`结束
    2. `var`定义变量，不使用`var`为全局变量


### 基本对象

> Function
>
> Array
>
> Boolean
>
> Date
>
> Math
>
> Number
>
> String
>
> RegExp
>
> Global

#### Function对象

1. 创建

   方法1：

    ```js
    var fun = new Function(<形参列表>, <方法体>);`
    ```

   方法2：

    ```js
    function <方法名>(<参数列表>) { <方法体>}
    // 如
    function fun(a, b) {
    	alert(a + b);
    }
    ```

   方法3：

    ```js
    var <方法名> = function (<参数列表>){ <方法体>}
    // 如
    var fun3 = function (a, b) {
    	alert(a + b);
    }
    ```
2. 属性

    * length : 参数个数
3. 特点

    1. 方法定义时形参无类型标注，返回值无类型标注

    2. 方法是对象，相同方法名的方法，后边会覆盖掉前边
    3. 方法调用仅与方法名有关，找到方法名即调用成功
    4. 方法声明中有一个内置隐藏数组对象`arguments`，可以通过该关键字访问访问所有入参
4. 调用

    ```js
    <方法名>（<实参列表>)
    ```


#### Array对象

1. 创建

    ```js
    var arr = new Array(<元素列表>);

    var arr2 = new Array(<默认长度>);

    var arr3 = new [<元素列表>); 
    ```
2. 方法

    * join

      拼接元素返回字符串，入参为连接字符串，默认`,`
    * push

      尾部添加元素
    *
3. 属性

    * length : 数组长度
4. 特点

    1. 元素类型可变
    2. 数组长度可变


#### Date对象

1. 创建

    ```js
    var data = new Date()
    ```
2. 方法

    * toLocalString()

      返回对象的当前系统配置的格式的字符串
    * getTime

      时间戳


#### Math

1. 创建

   不需要创建，直接使用
2. 方法

    * random :

      返回[0,1)区间内的随机数
    * ceil

      对数进行向上舍入
    * floor

      向下舍入
    * round

      四舍五入
3. 属性

    * PI   圆周率


#### RegExp

1. 正则表达式

    1. 单个字符`[]`
    2. 量词符号

        * ？: 0次或1次

        * \* :  0次或多次\+ : 0次或一次
        * \+ : 0次或一次
        * {m, n} : 表示m-n次之间，{m,}表示最少m次，{,n}表示最多n次
    3. 位置

        * ^ : 开始
        * $ : 结尾
2. 创建正则对象

    ```js
    var reg = new RegExp(<表达式>);

    var reg2 = /<表达式>/;
    ```
3. 方法

    * test

      验证字符串是否匹配成功


#### Global

1. 特点：全局对象，不需要对象就可以使用
2. 方法

    * `encodeURI `: URI编码
    * `decodeURI `: URI解码
    * `encodeURIComponent `: URI编码

      斜线等特殊字符也进行编码
    * `decodeURIComponent `: URI解码
    * `parseInt`

      可以识别字符串的前缀数字并返回，非数字开头为`NaN`
    * `isNaN`

      判断是否为`NaN`
    * `eval`

      将js字符串，转为脚本执行

## BOM

概念：Browser Object Model 浏览器对象模型

组成：

* window : 窗口
* navigator : 浏览器对象
* screen : 显示器对象
* location : 地址栏对象
* history : 历史记录

### window

1. 方法

    1. 弹窗方法

        1. `alter` 一个带确认按钮的警告框
        2. `confirm` 一个带确认和取消按钮的确认框，返回用户按了哪个按钮
        3. `prompt` 输入框，返回用户输入值
    2. 打开关闭方法

        1. `open`  打开新窗口，入参为新窗口地址，返回打开的窗口对象
        2. `close` 关闭窗口
    3. 定时器方法

        1. `setTimeout`

           参数1：js代码或方法

           参数2：时间毫秒值

           返回：定时器标识
        2. `clearTimeout`

           参数：定时器标
        3. `setInterval`

           参数1：js代码或方法

           参数2：时间毫秒值

           返回：定时器标识
        4. `clearInterval`

           参数：定时器标
2. 属性

    * window : 窗口
    * navigator : 浏览器对象
    * screen : 显示器对象
    * location : 地址栏对象
    * history : 历史记录
    * document : dom对象
3. 特点

    1. 不需要创建，直接使用`window`使用
    2. `window`可以省略，`alert`方法即window对象的方法


### location

1. 获取、

    ```js
    window.locaiton;

    location;
    ```
2. 方法

    * `reload`: 刷新
3. 属性

    * `href`: 地址


### history

1. 获取

    ```js
    window.history;

    history;
    ```
2. 方法

    * `back`: 后退
    * `forward`:前进
    * `go`: 去特定页面，参数为正数表示前进n个记录，为负数为后退n个记录
3. 属性

    * length: 返回当前窗口历史列表中的URL数量

## DOM

组成：

* 核心DOM

    * Document对象
    * Element对象
    * Attribute对象
    * Comment对象
    * Node节点对象，上述对象均继承自此对象
* XML DOM
* HTML DOM


功能：控制HTML文档内容

1. 通过id获取元素对象并修改内容
2. **改变标签内内容** ：`innerHTML`

```js
var item = document.getElementById(<id>)；
item.src = "..."; 
item.innerHTML = "<div>新子节点</div>"; // 改变标签内内容
```

### 事件

**绑定事件：**

1. 使用`onclick`属性

    * 直接在标签内设置
    * 在js中获取元素，然后设置属性


### 核心DOM模型

1. 获取

    1. window.document
    2. document
2. 方法

    1. 获取Element对象

        1. `getElementById()` :根据id属性获取元素对象
        2. `getElementsByTagName() `: 根据tag（标签，尖括号头）获取元素对象，返回数组
        3. `getElementsByClassName()` : 根据class返回元素对象，返回数组
        4. `getElementsByName()` : 根据name获取元素对象，返回数组
    2. 创建DOM对象

        1. `createAttribute(name)`
        2. `createComment()`
        3. `createElement()`
        4. `createTextNode()`

    ```js
    // 创建table元素
    var table = document.createElement("table");

    // 获取所有div
    var divs = document.getElementsByTagName("div");
    ```
3. 属性


### Element

1. 获取

   通过document获取
2. 方法

    1. `removeAttribute`删除属性
    2. `setAttribute`设置属性

       参数1：属性名

       参数2：属性值


### Node

1. 特点

   所有DOM对象均可以看作node
2. 方法

    * CURD dom数

        * `appendChild`: 向节点子节点列表添加节点
        * `removeChild`: 删除并返回被指定的子节点
        * `replacechild`: 使用新节点替换子节点
3. 属性

   `parentNode `: 父节点

   `innerHTML`: 内部内容，包含子节点也将以文本的形式被读取


### 控制样式

使用style属性控制

1. 直接使用style

    ```js
    div1.style.border = "1px solid red";
    div1.style.width = "200px";
    div1.style.fontSize = "20px";
    ```

2. 提前定义好css，更改元素相关属性来实现更多样的样式控制