## mysql安装



### 运行镜像

```shell
./run.sh
```

### 初始化一个新实例
首次启动容器时，使用配置好的变量创建并初始化指定的新数据库。它会执行带有扩展名的文件，这些.sh文件会
按文件字母顺序执行。您可以将初始化SQL文件保存在这个目录中，将会被自动导入到数据库。
`.sql` `.sql.gz` `/docker-entrypoint-initdb.dmysql` `MYSQL_DATABASE`




### 以任意用户身份运行
需要设置mysqld特定用户对挂载目录权限,在参数中加上--user 用户：用户组
```shell
mkdir data
ls -lnd data
docker run -v "$PWD/data":/var/llib/mysql --user 1000:1000 --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pwd -d mysql:tag
```

### 导出数据库数据
```shell
docker exec some-mysql sh -c `exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > /some/path/on/your/host/all-databases.sql
```

### 导入数据库
```shell
docker exec some-mysql sh -c `exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < /some/path/on/your/host/all-databases.sql
```


