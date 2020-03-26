@echo off

title php install

set nginx_web_dir=D:/web
set docker_php_dir=D:/docker/php7.2
set docker_name="xwx/php-fpm:7.2.5"


if  not exist %nginx_web_dir% (
    md  %nginx_web_dir%
)

if not  exist %docker_php_dir% (
    md  %docker_php_dir%
)
if not  exist %docker_php_dir%/etc (
    md  %docker_php_dir%/etc
)

xcopy "./resources/php7/etc" "%docker_php_dir%/etc"  /e /h /d /y

set used=false
for /F "usebackq tokens=1" %%i in (`"docker ps -a|find "php-fpm""`) do (
    set old_docker_name=%%i
    set used=true
)

 if "%used%"=="true" (
	docker stop %old_docker_name%
	docker rm %old_docker_name%
)

docker run -p 9000:9000 --name  php-fpm  -v %nginx_web_dir%:/var/www/html -v %docker_php_dir%/php7.2/logs:/var/log/php -v %docker_php_dir%/etc:/usr/local/etc  -d %docker_name%
if %ERRORLEVEL% == 0 (
   echo install success
) ELSE (
   echo install failure
)
pause