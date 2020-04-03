@echo off

title php install

set WEBROOT_DIR=D:/web
set DOCKERFILE_DIR=D:/docker/docker-lnmp
set PHP_VERSION=71
set DOCKER_LOGS_DIR=D:/docker/logs/
set docker_name="wxxiong6/php:%PHP_VERSION%"

set used=false
for /F "usebackq tokens=1" %%i in (`"docker ps -a|find "php%PHP_VERSION%-fpm""`) do (
    set old_docker_name=%%i
    set used=true
)

 if "%used%"=="true" (
	docker stop %old_docker_name%
	docker rm %old_docker_name%
)

docker run -p 9000:9000 --name  php%PHP_VERSION%-fpm  -v %WEBROOT_DIR%:/var/www/html -v %DOCKER_LOGS_DIR%/php%PHP_VERSION%:/var/log/php -v %DOCKERFILE_DIR%/php%PHP_VERSION%/etc:/usr/local/etc  -d %docker_name%
if %ERRORLEVEL% == 0 (
   echo install success
) ELSE (
   echo install failure
)
pause