@echo off

title php install

set PHP_VERSION=74
set WEBROOT_DIR=d:/web
set DOCKERFILE_DIR=d:/docker/docker-lnmp
set DOCKER_LOGS_DIR=d:/docker/logs
set docker_name="wxxiong6/php:%PHP_VERSION%"


if  not exist %WEBROOT_DIR% (
    md  %WEBROOT_DIR%
)

if not  exist %DOCKER_LOGS_DIR%/php%PHP_VERSION% (
    md  %DOCKER_LOGS_DIR%/php%PHP_VERSION%
)


REM xcopy "./resources/php7/etc" "%docker_php_dir%/etc"  /e /h /d /y


set used=false
for /F "usebackq tokens=1" %%i in (`"docker ps -a|find "php-fpm""`) do (
    set old_docker_name=%%i
    set used=true
)

 if "%used%"=="true" (
	docker stop %old_docker_name%
	docker rm %old_docker_name%
)

docker run -p 9000:9000 --name  php-fpm  -v %WEBROOT_DIR%:/var/www/html -v %DOCKER_LOGS_DIR%/php%PHP_VERSION%:/var/log/php -v %DOCKERFILE_DIR%/php%PHP_VERSION%/etc:/usr/local/etc  -d %docker_name%
if %ERRORLEVEL% == 0 (
   echo install success
) ELSE (
   echo install failure
)
pause
