# docker-lnmp

使用这个docker能很快构建一套LNMP环境。节约安装环境的时间，让开发者更专注于开发。可以使团队都统一样的环境，提升效率减少BUG的产生。



##  Docker image

- [nginx](https://github.com/wxxiong6/docker-lnmp/blob/master/nginx/README.md) 
- [php7.2](https://github.com/wxxiong6/docker-lnmp/blob/master/php7.2/README.md) 
- php5
- [mysql5.7](https://github.com/wxxiong6/docker-lnmp/blob/master/mysql/README.md) 
- redis 
- rabbitMQ



### 默认环境变量

```shell
#.env 文件
dockerfile_dir=d:/docker/dockerfile 
web_dir=d:/www              
docker_dir=d:/docker #docker 挂载目录
```

**根据自己实际情况修改目录**

## 安装方式

安装php-fpm需要较长时间。需要更新镜像系统 （ apt-get update），具体看网络状况。

已使用阿里的源加速（mirrors.aliyun.com）。

编译扩展





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