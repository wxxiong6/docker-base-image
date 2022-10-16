# docker-base-image

制作一些常用的基础镜像,镜像使用官方镜像制作而成。



支持多版本php切换，支持版有（.1.30、.2.5、7.4.14、8.0 ）。
支持多版本mysql切换，支持版有（5.7、8.0 ）。


##  包含镜像

- [nginx-1.10](https://github.com/wxxiong6/docker-lnmp/blob/master/nginx/README.md)
- [php-7.4.14](https://github.com/wxxiong6/docker-lnmp/blob/master/php74/README.md) 
- [php-7.2.5](https://github.com/wxxiong6/docker-lnmp/blob/master/php72/README.md) 
- [php-7.1.30](https://github.com/wxxiong6/docker-lnmp/blob/master/php71/README.md) 
- [mysql-5.7](https://github.com/wxxiong6/docker-lnmp/blob/master/mysql57/README.md) 
- [mysql-8.0](https://github.com/wxxiong6/docker-lnmp/blob/master/mysql80/README.md) 
- [redis-5.0](https://github.com/wxxiong6/docker-lnmp/blob/master/redis50/README.md) 
- [clickhouse-22](https://github.com/wxxiong6/docker-lnmp/blob/master/clickhouse-server22_3/README.md) 



### 默认配置

```shell
#.env 文件
DOCKERFILE_DIR=/docker-base-image
WEBROOT_DIR=/web
DOCKER_LOGS_DIR=/docker/logs
DOCKER_DATA_DIR=/docker/data
DOCKER_USER=wxxiong6
PHP_VERSION=80
```

**请根据自己实际情况.env文件中的参数**

.evn文件参数详细说明

| 参数            | 说明                 |
| :-------------- | :------------------- |
| DOCKERFILE_DIR  | 下载项目源码目录     |
| WEBROOT_DIR     | web项目目录          |
| DOCKER_LOGS_DIR | 日志目录             |
| DOCKER_DATA_DIR | 数据目录             |
| DOCKER_USER     | 运行容器用户         |
| PHP_VERSION     | 安装php版本71、72、74|

## 安装方法

1.  使用git clone 项目 :
   ```shell
   git clone https://github.com/wxxiong6/docker-base-image.git 
   ```
   或者直接下载：https://github.com/wxxiong6/docker-base-image/archive/master.zip

2. 切换到目录,修改.env文件:

   ``` shell
   cd docker-base-image
   ```

3. 构建启动:

   ```shell
   docker-compose build
   docker-compose up -d
   ```
4. 浏览器打开http://localhost，就可以访问默认网站了。

## 更新日志

- 2020-04-02  [V1.0-alpha](https://github.com/wxxiong6/docker-lnmp/releases/tag/v1.0) 发布第一版
- 2020-04-05  [V1.1-alpha](https://github.com/wxxiong6/docker-lnmp/releases/tag/v1.1) 增加可选php版本安装
- 2021-01-23  [V1.1-alpha](https://github.com/wxxiong6/docker-lnmp/releases/tag/v1.2) 增加php7.4

