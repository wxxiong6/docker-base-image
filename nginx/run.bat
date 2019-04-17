@echo off

set nginx_web_dir="D:/web"
set docker_nginx_dir="D:/docker/nginx/"
set docker_name="xwx/nginx:1.10"



docker run --name nginx  --link php-fpm:php-fpm -p 80:80 -p443:443 -v %nginx_web_dir%:/var/www/html -v %docker_nginx_dir%conf/nginx.conf:/etc/nginx/nginx.conf -v  %docker_nginx_dir%conf/conf.d:/etc/nginx/conf.d -v %docker_nginx_dir%logs:/var/log/nginx -d %docker_name%

