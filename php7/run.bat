@echo off

set nginx_web_dir="D:/web"
set docker_php_dir="D:/docker/php7"
set docker_name="xwx/php-fpm:7.2.5"



nginx_web_dir="/var/www/html"
docker_php_dir="/docker/php7/"
docker_name="xwx/php-fpm:7.2.5"

if  exist %nginx_web_dir% (
) else (
    rem  %nginx_web_dir%
    md  %nginx_web_dir%
)

if  exist %docker_php_dir% (
) else (
    rem  %docker_php_dir%
    md  %docker_php_dir%
)

docker run -p 9000:9000 --name  php-fpm  -v %nginx_web_dir%:/var/www/html -v %docker_php_dir%etc:/usr/local/etc  -d %docker_name%
