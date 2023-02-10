@echo off

title redis-7.0 install



set docker_redis_dir=D:/docker/redis
set docker_name=redis:7.0

set used=false
for /F "usebackq tokens=1" %%i in (`"docker ps -a|find "redis-server""`) do (
    set old_docker_name=%%i
    set used=true
)

 if "%used%"=="true" (
	docker stop %old_docker_name%
	docker rm %old_docker_name%
)


docker run --name redis-server -p 6379:6379 -v %docker_redis_dir%/data:/data -v %docker_redis_dir%/conf:/etc/redis/  -d %docker_name%  redis-server --appendonly yes

if %ERRORLEVEL% == 0 (
   echo install success
) ELSE (
   echo install failure
)
pause
