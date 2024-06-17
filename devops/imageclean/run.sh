#docker run -it  -v /var/run/docker.sock:/var/run/docker.sock docker:dind sh -c "docker system prune -f && docker rmi $(docker images -f "dangling=true" -q)" 
docker run -it  -v /var/run/docker.sock:/var/run/docker.sock wxxiong6/imageclean:1.0 sh -c "docker system prune -f && docker rmi $(docker images -f "dangling=true" -q)" 
