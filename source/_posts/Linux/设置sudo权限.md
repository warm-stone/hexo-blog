---
title: 设置sudo权限
date: 2024-06-18 00:47:13
categories:
  - Linux
tags:
  - Linux
  - sudo
---
[Ubuntu](https://www.linuxidc.com/topicnews.aspx?tid=2 "Ubuntu")下普通用户用sudo执行命令时报"xxx is not in the sudoers file.This incident will be reported"错误，解决方法就是在/etc/sudoers文件里给该用户添加权限。如下：

1.切换到root用户下

2./etc/sudoers文件默认是只读的，对root来说也是，因此需先添加sudoers文件的写权限,命令是:

```bash
chmod u+w /etc/sudoers
```

3.编辑sudoers文件

```bash
vi /etc/sudoers
```

找到这行 root ALL=(ALL) ALL,在他下面添加xxx ALL=(ALL) ALL (这里的xxx是你的用户名)

ps:这里说下你可以sudoers添加下面四行中任意一条

> 第一行:允许用户youuser执行sudo命令(需要输入密码).  
> 第二行:允许用户组youuser里面的用户执行sudo命令(需要输入密码).  
> 第三行:允许用户youuser执行sudo命令,并且在执行的时候不输入密码.  
> 第四行:允许用户组youuser里面的用户执行sudo命令,并且在执行的时候不输入密码.


```
youuser            ALL=(ALL)                ALL
%youuser          ALL=(ALL)                ALL
youuser            ALL=(ALL)                NOPASSWD: ALL
%youuser          ALL=(ALL)                NOPASSWD: ALL
```

4.撤销sudoers文件写权限,命令:

```bash
chmod u-w /etc/sudoers
```

更多Ubuntu相关信息见[Ubuntu](https://www.linuxidc.com/topicnews.aspx?tid=2 "Ubuntu") 专题页面 [http://www.linuxidc.com/topicnews.aspx?tid=2](https://www.linuxidc.com/topicnews.aspx?tid=2 "Ubuntu")

**本文永久更新链接地址**：[http://www.linuxidc.com/Linux/2016-07/133066.htm](https://www.linuxidc.com/Linux/2016-07/133066.htm)