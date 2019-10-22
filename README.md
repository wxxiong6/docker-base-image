#  Docker image

包含 nginx、php7.2、php5、mysql、redis、rabbitMQ 镜像 ，整理出这些常用的环境，方便统一环境及重新装机方便。

在php7.2基础镜像中增加了 xdebug、gd、mongodb、yaf、pdo_mysql、yar 、bcmath  扩展

## 打包镜像

```shell
./build.sh
```

## 运行镜像

```shell
./run.sh
```

## 更新日志

