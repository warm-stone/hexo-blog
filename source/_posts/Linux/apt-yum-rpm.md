---
title: apt yum rpm 对比
date: 2024-06-18 01:09:33
categories:
  - Linux
tags:
  - Linux
  - apt
  - yum
  - rpm
---
### 问题
1. `rpm`存在什么问题？
2. `yum`有什么优势？
3. `apt-get`与`yum`有什么相同之处？

### 经常会看到`yum`、`apt-get`、`rpm`，那么它们是什么？下面介绍一下。

`rpm`是由红帽公司开发的软件包管理方式，使用`rpm`我们可以方便的进行软件的安装、查询、卸载、升级等工作。但是`rpm`软件包之间的依赖性问题往往会很繁琐,尤其是软件由多个`rpm`包组成时。  
`yum`（全称为 Yellow dog Updater, Modified）是一个在Fedora和RedHat以及SUSE中的Shell前端软件包管理器。基於`rpm`包管理，能够从指定的服务器自动下载`rpm`包并且安装，可以自动处理依赖性关系，并且一次安装所有依赖的软体包，无须繁琐地一次次下载、安装。  
`rpm` 是linux的一种软件包名称，以.rmp结尾，安装的时候语法为：`rpm` -ivh，`rpm`包的安装有一个很大的缺点就是文件的关联性太大，有时候装一个软件要安装很多其他的软件包，很麻烦，所以为此RedHat小红帽开发了`yum`安装方法，他可以彻底解决这个关联性的问题，很方便，只要配置两个文件即可安装，安装方法是：`yum` -y install ，`yum`并不是一中包，而是安装包的软件

简单点说, `rpm` 只能安装已经下载到本地机器上的`rpm` 包. `yum`能在线下载并安装`rpm`包,能更新系统,且还能自动处理包与包之间的依赖问题,这个是`rpm` 工具所不具备的。

`yum`与`apt-get`的相同点：  
`apt-get`属于ubuntu、Debian的包管理工具  
`yum`则属于Redhat、Centos包管理工具  

明白了这两点，对于我们使用hadoop、openstack已经没有问题了。更详细参考：

一般来说著名的linux系统基本上分两大类：

1.RedHat系列：Redhat、Centos、Fedora等

2.Debian系列：Debian、Ubuntu等

RedHat 系列
1 常见的安装包格式 `rpm`包,安装`rpm`包的命令是“`rpm` -参数”

2 包管理工具 `yum`

3 支持tar包

Debian系列  

1 常见的安装包格式 deb包,安装deb包的命令是“dpkg -参数”

2 包管理工具 `apt-get`

3 支持tar包

tar 只是一种压缩文件格式，所以，它只是把文件压缩打包而已。
`rpm` 相当于windows中的安装文件，它会自动处理软件包之间的依赖关系。

优缺点来说，`rpm`一般都是预先编译好的文件，它可能已经绑定到某种CPU或者发行版上面了。
tar一般包括编译脚本，你可以在你的环境下编译，所以具有通用性。

如果你的包不想开放源代码，你可以制作成`rpm`，如果开源，用tar更方便了。

tar一般都是源码打包的软件，需要自己解包，然后进行安装三部曲，./configure, make, make install.　来安装软件。

`rpm`是redhat公司的一种软件包管理机制，直接通过`rpm`命令进行安装删除等操作，最大的优点是自己内部自动处理了各种软件包可能的依赖关系。

参考 https://blog.csdn.net/mier9042/article/details/80612707

这样一来就很明显了 初入linux 我们应该选择一个适合自己的阵营

因为VPS大多以centos来的 自己本地 也要选centos阵营 否则以后命令熟悉了  再换就不行了

就一开始 就坚守一个阵地  所以我放弃mint 系统 虽然它类windows 但是命令不合 不相为谋  拜拜
————————————————
版权声明：本文为CSDN博主「Lucky@Dong」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/zzddada/article/details/123208388