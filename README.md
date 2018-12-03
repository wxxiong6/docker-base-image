# docker 搭建lnmp开发环境

build php镜像

```shell
docker build . -t xwx/php-fpm:7.2.5
```



```shell
docker run -p 3306:3306 --name mysql -v d:/docker/mysql/conf:/etc/mysql/conf.d -v d:/docker/mysql/logs:/logs -v d:/docker/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -d mysql:5.7			

docker run -p 9000:9000 --name  php-fpm  -v D:/web:/var/www/html -v D:/docker/php7/etc:/usr/local/etc  -d php:7.2.5-fpm

docker run --name nginx --link php-fpm:php-fpm --restart=always -d -p 80:80 -p443:443 -v d:/web:/var/www/html -v D:/docker/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v  D:/docker/nginx/conf/conf.d:/etc/nginx/conf.d -v D:/docker/nginx/logs:/var/log/nginx nginx:1.10
```

命令说明:

-p 9000:9000 :将容器的9000端口映射到主机的9000端口

--name myphp-fpm :将容器命名为myphp-fpm

--restart=always 使得容器开机随着docker服务自行启动

--link 连接到php-fpm容器 

-v ~/nginx/www:/www :将主机中项目的目录www挂载到容器的/www

php安装扩展

docker-php-ext-install pdo pdo_mysql

安装gd会遇到问题需要执行

```shell
apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev 

docker-php-ext-configure gd  --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include
docker-php-ext-install gd 
```



如遇到不是内置扩展需要手动编译安装



xdebug配置文件

```ini
[XDebug]
xdebug.profiler_append = 0
xdebug.profiler_enable = 0
xdebug.profiler_enable_trigger = On
xdebug.profiler_output_dir ="/tmp"
xdebug.profiler_output_name = "callgrind.out.%t-%s"

xdebug.remote_port = 19001
xdebug.remote_enable = 1
xdebug.remote_handler = "dbgp"
xdebug.remote_host = "172.16.5.166"
;宿主机ip
xdebug.remote_log = "/tmp/remote.log"

xdebug.auto_trace = 0
xdebug.collect_params = 4
xdebug.collect_return = 1
xdebug.var_display_max_depth = 10
xdebug.show_mem_delta = 1
xdebug.trace_enable_trigger = On
xdebug.trace_options = On
xdebug.trace_output_name = trace.%c_%H
xdebug.trace_output_dir ="/tmp"
xdebug.dump_undefined = On
```

