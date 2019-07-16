
echo ****************************************
echo docker-redis run
echo ****************************************

set docker_redis_dir=D:/docker/redis2/
set docker_name=redis:3.2

if not exist %docker_redis_dir%data md %docker_redis_dir%data
pause


