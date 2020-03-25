# docker-lnmp

使用这个docker快构建一套LNMP环境。让开发者更专注于开发，让运维从繁琐的安装服务中解放出来。开发团队可以统一环境，提升效率减少BUG的产生。



##  包含镜像

- [nginx1.10](https://github.com/wxxiong6/docker-lnmp/blob/master/nginx/README.md)
- [php7.2.5](https://github.com/wxxiong6/docker-lnmp/blob/master/php7.2/README.md) 
- php5
- [mysql5.7](https://github.com/wxxiong6/docker-lnmp/blob/master/mysql/README.md) 
- [redis5.0](https://github.com/wxxiong6/docker-lnmp/blob/master/redis5.0/README.md) 
- rabbitMQ



### 默认环境变量

```shell
#.env 文件
DOCKERFILE_DIR=d:/docker/dockerfile
WEBROOT_DIR=d:/web
DOCKER_DIR=d:/docker
DOCKER_USER=wxxiong6
```

**根据自己实际情况修改目录**

- DOCKERFILE_DIR  下载这个docker源码目录
- WEBROOT_DIR     web项目目录
- DOCKER_DIR         持久化docker服务数据目录。从docker容器挂载到宿主机的目录。
  nginx 的配置文件、日志，php配置目录，mysql data目录等等.
- DOCKER_USER      镜像名称

## 安装方式

### 方法一

使用docker-compose

```shell
docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml up -d
```

#### 方法二

可以选择性安装需要的镜像执行如下命令

```shell
./build.sh #build 镜像
./run.sh   #运行容器
```



## 更新日志

- 增加docker-compose