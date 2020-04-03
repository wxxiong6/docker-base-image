# docker-lnmp

使用这个docker快构建一套LNMP环境。让开发者更专注于开发，让运维从繁琐的安装服务中解放出来。

开发团队可以统一环境，提升效率减少BUG的产生。

镜像都是使用官方镜像制作而成，使用安全放心。



##  包含镜像

- [nginx1.10](https://github.com/wxxiong6/docker-lnmp/blob/master/nginx/README.md)
- [php7.2.5](https://github.com/wxxiong6/docker-lnmp/blob/master/php7.2/README.md) 
- [mysql5.7](https://github.com/wxxiong6/docker-lnmp/blob/master/mysql/README.md) 
- [redis5.0](https://github.com/wxxiong6/docker-lnmp/blob/master/redis5.0/README.md) 



### 默认环境变量

```shell
#.env 文件
DOCKERFILE_DIR=/docker-lnmp
WEBROOT_DIR=/web
DOCKER_LOGS_DIR=/docker/logs
DOCKER_DATA_DIR=/docker/data
DOCKER_USER=wxxiong6
PHP_VERSION=72
```

**根据自己实际情况修改目录**

- DOCKERFILE_DIR       下载docker项目源码目录

- WEBROOT_DIR            web项目目录

- DOCKER_LOGS_DIR   日志目录

- DOCKER_DATA_DIR   持久化docker服务数据目录

- DOCKER_USER         镜像名称

- PHP_VERSION           安装php版本 支持71、72

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

- 增加docker-compose