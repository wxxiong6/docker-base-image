@echo off

Web=
Docker=D:/docker/
Php7=php7/etc




if exist %Docker%Php7 (

) else (
    md  %Docker%Php7
)

docker run -p 9000:9000 --name  php-fpm  -v D:/web:/var/www/html -v D:/docker/php7/etc:/usr/local/etc  -d xwx/php-fpm:7.2.5


