@echo off

title nginx install

set nginx_web_dir=D:/web
set docker_nginx_dir=D:/docker/nginx
set docker_name="xwx/nginx:1.10"

if  not exist %nginx_web_dir% (
    md  %nginx_web_dir%
)

if not  exist %docker_nginx_dir% (
    md  %docker_nginx_dir%
)


xcopy "./resources/nginx" "%docker_nginx_dir%"  /e /h /d /y /i
set used=false
for /F "usebackq tokens=1" %%i in (`"docker ps -a|find "nginx""`) do (
    set old_docker_name=%%i
    set used=true
)

 if "%used%"=="true" (
	docker stop %old_docker_name%
	docker rm %old_docker_name%
)


docker run --name nginx  --link php-fpm:php-fpm -p 80:80 -p443:443 -v %nginx_web_dir%:/var/www/html -v %docker_nginx_dir%/nginx.conf:/etc/nginx/nginx.conf -v %docker_nginx_dir%/conf.d:/etc/nginx/conf.d -v %docker_nginx_dir%/logs:/var/log/nginx -d %docker_name%

if %ERRORLEVEL% == 0 (
   echo install success
) ELSE (
   echo install failure
)
pause