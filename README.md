# docker-lnmp

使用这个docker快构建一套LNMP环境。让开发者更专注于开发，让运维从繁琐的安装服务中解放出来。

开发团队可以统一环境，提升效率减少BUG的产生。

镜像使用官方镜像制作而成，增加常用的php扩展（yaf、yar、imagick、mcrypt、mongodb、swoole、xdebug、xlswriter）。

支持多版本php切换，支持版（php7.1.30、php7.2.5、7.4.14）。

##  包含镜像

- [nginx1.10](https://github.com/wxxiong6/docker-lnmp/blob/master/nginx/README.md)
- [php7.4.14](https://github.com/wxxiong6/docker-lnmp/blob/master/php74/README.md) 
- [php7.2.5](https://github.com/wxxiong6/docker-lnmp/blob/master/php72/README.md) 
- [php7.1.30](https://github.com/wxxiong6/docker-lnmp/blob/master/php71/README.md) 
- [mysql5.7](https://github.com/wxxiong6/docker-lnmp/blob/master/mysql57/README.md) 
- [redis5.0](https://github.com/wxxiong6/docker-lnmp/blob/master/redis50/README.md) 



### 默认配置

```shell
#.env 文件
DOCKERFILE_DIR=/docker-lnmp
WEBROOT_DIR=/web
DOCKER_LOGS_DIR=/docker/logs
DOCKER_DATA_DIR=/docker/data
DOCKER_USER=wxxiong6
PHP_VERSION=74
```

**请根据自己实际情况.env文件中的参数**

.evn文件参数详细说明

- DOCKERFILE_DIR       下载docker项目源码目录

- WEBROOT_DIR            web项目目录

- DOCKER_LOGS_DIR   日志目录

- DOCKER_DATA_DIR   数据目录

- DOCKER_USER         镜像名称

- PHP_VERSION           安装php版本 支持参数71、72、74

  对应php-7.1.30、php-7.2.5

## 安装方法

1.  使用git clone 项目 :

   ```shell
   git clone https://github.com/wxxiong6/docker-lnmp.git 
   ```

   或者直接下载：https://github.com/wxxiong6/docker-lnmp/archive/master.zip

   

2. 切换到目录,修改.env文件:

   ``` shell
   cd docker-lnmp
   ```

3. 构建启动:

   ```shell
   docker-compose build
   docker-compose up -d
   ```

   

4. 浏览器打开http://localhost，就可以访问默认网站了。

   

## 更新日志

-  2020-04-02  [V1.0-alpha](https://github.com/wxxiong6/docker-lnmp/releases/tag/v1.0) 发布第一版
- 2020-04-05  [V1.1-alpha](https://github.com/wxxiong6/docker-lnmp/releases/tag/v1.1) 增加可选php版本安装
- 2021-01-23  [V1.1-alpha](https://github.com/wxxiong6/docker-lnmp/releases/tag/v1.2) 增加php7.4

