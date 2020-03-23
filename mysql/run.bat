

title mysql install


set docker_mysql_dir=d:/docker/mysql
set docker_name=mysql:5.7

if not  exist %docker_mysql_dir% (
    md  %docker_mysql_dir%
)

set used=false
for /F "usebackq tokens=1" %%i in (`"docker ps -a|find "mysql""`) do (
    set old_docker_name=%%i
    set used=true
)

 if "%used%"=="true" (
	docker stop %old_docker_name%
	docker rm %old_docker_name%
)

docker run -p 3306:3306 --name mysql -v %docker_mysql_dir%/conf:/etc/mysql/conf.d -v %docker_mysql_dir%/logs:/logs -v %docker_mysql_dir%/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -d %docker_name%

if %ERRORLEVEL% == 0 (
   echo install success
) ELSE (
   echo install failure
)

