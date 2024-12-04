---
title: nginx
date: 2024-11-02 22:34:42
categories:
tags:
  - nginx
---


# nginx 多账户认证


在Nginx中设置多个密码，实际上是通过创建一个包含多个用户名和密码对的认证文件来实现的。以下是具体的步骤：

1. **安装htpasswd工具**：这是一个用于创建和更新认证文件的工具。在大多数Linux发行版中，可以通过包管理器安装`httpd-tools`来获取`htpasswd`工具。例如，在基于Debian的系统上，可以使用以下命令安装：

    ```
    sudo apt-get install apache2-utils
    ```

   在基于RPM的系统上，如CentOS，可以使用：

    ```
    sudo yum install -y httpd-tools
    ```
2. **创建密码文件**：使用`htpasswd`命令创建一个新的密码文件，并添加用户。例如，创建一个名为`.htpasswd`的文件，并添加一个用户名为`username`的用户：

    ```
    htpasswd -c /etc/nginx/.htpasswd username
    ```

   这个命令会提示你输入密码，并将用户名和加密后的密码保存在`/etc/nginx/.htpasswd`文件中。你可以重复这个命令来添加更多的用户，但不要使用`-c`选项，因为`-c`选项会创建新文件，而不是向现有文件添加用户。
3. **配置Nginx**：编辑Nginx的配置文件（通常是`/etc/nginx/nginx.conf`或者`/etc/nginx/sites-available/default`），并在需要保护的`location`块中添加以下配置：

    ```
    location / {
        auth_basic "Restricted";
        auth_basic_user_file /etc/nginx/.htpasswd;
        ...
    }
    ```

   这里`auth_basic`指令用于设置一个提示信息，告诉用户这是一个需要认证的区域。`auth_basic_user_file`指令指定了包含用户名和密码的文件路径。
4. **重启Nginx**：完成配置后，需要重启Nginx以使更改生效：

    ```
    sudo nginx -s reload
    ```

   或者在某些系统中可能是：

    ```
    sudo systemctl reload nginx
    ```

通过以上步骤，你可以在Nginx中设置多个密码，每个用户都有自己的用户名和密码。当用户尝试访问受保护的资源时，他们将被提示输入用户名和密码。