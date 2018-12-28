docker run --name nginx  --link php-fpm:php-fpm -p 80:80 -p443:443 -v d:/web:/var/www/html -v D:/docker/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v  D:/docker/nginx/conf/conf.d:/etc/nginx/conf.d -v D:/docker/nginx/logs:/var/log/nginx -d nginx:1.10

goto start
 = --restart=always 使得容器开机随着docker服务自行启动
 = --link连接到php-fpm容器 php-fpm是容器的名称,需要先安装php-fpm容器
 = --d:/web:/var/www/html 挂载盘跟php保持一致
:start