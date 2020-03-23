## nginx安装

### 打包镜像

```shell
./build.sh
```

### 运行镜像

```shell
./run.sh
```

### 注意事项
因为使用 docker --link php-fpm。在安装nginx前需要先安装php-fpm。 如果只需要安装nginx，可在run文件中去掉--link php-fpm后再运行。
