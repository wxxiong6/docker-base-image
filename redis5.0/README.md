## redis-5.0

- 映射端口

```shell
-p 6379:6379
```

- 挂载目录

```shell
 -v ${docker_redis_dir}/data:/data
 -v ${docker_redis_dir}/conf:/usr/local/etc/redis
```

### 运行容器

```shell
./run.sh
```