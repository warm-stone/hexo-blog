---
title: Bootstrap
date: 2024-06-20 01:50:46
categories:
   - web 前端
tags:
---

[Bootstrap中文网 (bootcss.com)](https://www.bootcss.com/)

前端框架，来自Twitter，基于HTML，css，JavaScript

优势：

1. 定义了许多css样式和js插件，开发人员可以直接调用得到丰富的页面效果
2. 响应式布局

   同一套页面代码可以适应不同尺寸的屏幕

## 快速入门

1. 下载
2. 项目中引入bootstrap文件
3. 基本模板

    ```html
    <!doctype html>
    <html lang="zh-CN">
      <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
        <title>Bootstrap 101 Template</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">

        <!-- HTML5 shim 和 Respond.js 是为了让 IE8 支持 HTML5 元素和媒体查询（media queries）功能 -->
        <!-- 警告：通过 file:// 协议（就是直接将 html 页面拖拽到浏览器中）访问页面时 Respond.js 不起作用 -->
        <!--[if lt IE 9]>
          <script src="https://fastly.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
          <script src="https://fastly.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>
        <![endif]-->
      </head>
      <body>
        <h1>你好，世界！</h1>

        <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
        <script src="https://fastly.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
        <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
      </body>
    </html>
    ```


## 响应式布局

概念：同一套页面代码适配不同分辨率不同尺寸的设备

实现：栅格系统，将一行平均分为12个格子，可以指定元素占几个格子


使用步骤：

1. 定义容器

    * **容器分类**

        1. `container`: 两边根据不同设备留白
        2. `container-fluid`： 固定100%宽度
        3. `col` ：列可以再作为容器，同样12等分
2. 定义行
3. 定义元素   样式：`col-设备代号-格子数目`

    1. `xs`: 超小屏幕
    2. `sm`: 小屏幕
    3. `md`: **中等屏幕** 一般使用此类别较多，更小设备使其独自占用一行
    4. `lg`: 大屏幕

   > *注：*
   >
   > 1. 具体设备信息查看下方表格
   >
   > 2. 每行最多12个格子，超过则自动换行
   > 3. 栅格属性向上兼容，超小屏幕配置适用于所有规格屏幕
   > 4. 设备宽度小于设置的栅格属性，则一列占用一行
>

* “行（row）”必须包含在 `.container` （固定宽度）或 `.container-fluid` （100% 宽度）中，以便为其赋予合适的排列（aligment）和内补（padding）。
* 通过“行（row）”在水平方向创建一组“列（column）”。
* 你的内容应当放置于“列（column）”内，并且，只有“列（column）”可以作为行（row）”的直接子元素。
* 类似 `.row` 和 `.col-xs-4` 这种预定义的类，可以用来快速创建栅格布局。Bootstrap 源码中定义的 mixin 也可以用来创建语义化的布局。
* 通过为“列（column）”设置 `padding` 属性，从而创建列与列之间的间隔（gutter）。通过为 `.row` 元素设置负值 `margin` 从而抵消掉为 `.container` 元素设置的 `padding`，也就间接为“行（row）”所包含的“列（column）”抵消掉了`padding`。
* 负值的 margin就是下面的示例为什么是向外突出的原因。在栅格列中的内容排成一行。
* 栅格系统中的列是通过指定1到12的值来表示其跨越的范围。例如，三个等宽的列可以使用三个 `.col-xs-4` 来创建。
* 如果一“行（row）”中包含了的“列（column）”大于 12，多余的“列（column）”所在的元素将被作为一个整体另起一行排列。
* 栅格类适用于与屏幕宽度大于或等于分界点大小的设备 ， 并且针对小屏幕设备覆盖栅格类。 因此，在元素上应用任何 `.col-md-*` 栅格类适用于与屏幕宽度大于或等于分界点大小的设备 ， 并且针对小屏幕设备覆盖栅格类。 因此，在元素上应用任何 `.col-lg-*` 不存在， 也影响大屏幕设备。


通过下表可以详细查看 Bootstrap 的栅格系统是如何在多种屏幕设备上工作的。

|                         |   超小屏幕 手机 (<768px)   |                 小屏幕 平板 (≥768px)                 | 中等屏幕 桌面显示器 (≥992px) | 大屏幕 大桌面显示器 (≥1200px) |
| ------------------------- | :--------------------------: | :-----------------------------------------------------: | :-----------------------------: | :------------------------------: |
| 栅格系统行为            |        总是水平排列        | 开始是堆叠在一起的，当大于这些阈值时将变为水平排列C<br /> |                                |  |
| `.container` 最大宽度 |       None （自动）       |                         750px                         |             970px             |             1170px             |
| 类前缀                  |        `.col-xs-`        |                     `.col-sm-`                     |         `.col-md-`         |          `.col-lg-`          |
| 列（column）数          |            12<br />            |                              |  |  |
| 最大列（column）宽      |            自动            |                         ~62px                         |             ~81px             |             ~97px             |
| 槽（gutter）宽          | 30px （每列左右均有 15px） |                                                      |                              |                                |
| 可嵌套                  |            是<br />            |                              |  |  |
| 偏移（Offsets）         |            是<br />            |                              |  |  |
| 列排序                  |            是<br />            |                              |  |  |


## css样式和js插件

全局css样式

1. 按钮

   常用样式

    ```html
    <!-- Standard button -->
    <button type="button" class="btn btn-default">（默认样式）Default</button>

    <!-- Provides extra visual weight and identifies the primary action in a set of buttons -->
    <button type="button" class="btn btn-primary">（首选项）Primary</button>

    <!-- Indicates a successful or positive action -->
    <button type="button" class="btn btn-success">（成功）Success</button>

    <!-- Contextual button for informational alert messages -->
    <button type="button" class="btn btn-info">（一般信息）Info</button>

    <!-- Indicates caution should be taken with this action -->
    <button type="button" class="btn btn-warning">（警告）Warning</button>

    <!-- Indicates a dangerous or potentially negative action -->
    <button type="button" class="btn btn-danger">（危险）Danger</button>

    <!-- Deemphasize a button by making it look like a link while maintaining button behavior -->
    <button type="button" class="btn btn-link">（链接）Link</button>
    ```
2. 图片

   响应式

   *响应式会受图片本身像素影响，超过图片本身像素大小后不能够再放大*

    ```js
    <img src="..." class="img-responsive" alt="Responsive image">
    ```

   形状

    ```js
    <img src="..." alt="..." class="img-rounded">
    <img src="..." alt="..." class="img-circle">
    <img src="..." alt="..." class="img-thumbnail">
    ```
3. 表格

   为任意 `<table>` 标签添加 `.table` 类可以为其赋予基本的样式 — 少量的内补（padding）和水平方向的分隔线。

   通过 `.table-striped` 类可以给 `<tbody>` 之内的每一行增加斑马条纹样式。

   添加 `.table-bordered` 类为表格和其中的每个单元格增加边框。

   通过添加 `.table-hover` 类可以让 `<tbody>` 中的每一行对鼠标悬停状态作出响应。

   通过添加 `.table-condensed` 类可以让表格更加紧凑，单元格中的内补（padding）均会减半。
4. 表单

组件

1. 导航条
2. 分页条

插件：

* 轮播图  Carousel