#  Docker image

包含 nginx、php7.2、php5、mysql、redis、rabbitMQ 镜像 ，整理出这些常用的环境，是为了方便重新装机。

在php7.2基础镜像中增加了 xdebug、gd、mongodb、yaf、pdo_mysql、yar 、bcmath  扩展

[php7]: https://github.com/wxxiong6/docker-lnmp/tree/master/php7	"php7"

打包镜像

```shell
./build.sh
```

运行镜像

```shell
./run.sh
```

[php5]: https://github.com/wxxiong6/docker-lnmp/tree/master/php5	"php5"

```shell
./run.sh
```

[nginx]: https://github.com/wxxiong6/docker-lnmp/tree/master/ngin	"nginx"

```shell
./run.sh
```

[rabbitMQ]: https://github.com/wxxiong6/docker-lnmp/tree/master/rabbitmq	"rabbitMQ"

```shell
./run.sh
```

[redis]: https://github.com/wxxiong6/docker-lnmp/tree/master/redis	"redis"

```shell
./run.sh
```

