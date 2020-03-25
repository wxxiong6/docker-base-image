#
# Dockerfile for building nginx images


FROM nginx:1.10
MAINTAINER wxxiong <wxxiong6@gmail.com>

ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

LABEL version="1.0"
LABEL description="nginx:1.10"


#将预先下载好的拓展包从宿主机拷贝进去
COPY resources/nginx/nginx.conf /etc/nginx/nginx.conf
COPY resources/nginx /etc/nginx