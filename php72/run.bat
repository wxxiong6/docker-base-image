@echo off

title php install

set WEBROOT_DIR=D:/web
set DOCKERFILE_DIR=D:/docker/docker-lnmp
set DOCKER_LOGS_DIR=D:/docker/logs/nginx
set docker_name="wxxiong6/php-fpm:7.2.5"


set used=false
for /F "usebackq tokens=1" %%i in (`"docker ps -a|find "php-fpm""`) do (
    set old_docker_name=%%i
    set used=true
)

 if "%used%"=="true" (
	docker stop %old_docker_name%
	docker rm %old_docker_name%
)

docker run -p 9000:9000 --name  php-fpm  -v %WEBROOT_DIR%:/var/www/html -v %DOCKER_LOGS_DIR%/php72:/var/log/php -v %DOCKERFILE_DIR%/php72/etc:/usr/local/etc  -d %docker_name%
if %ERRORLEVEL% == 0 (
   echo install success
) ELSE (
   echo install failure
)
pause