#
# Dockerfile for building nginx images
# see https://hub.docker.com/_/nginx


FROM nginx:1.21.6-alpine

LABEL maintainer="wxxiong <wxxiong6@gmail.com>" version="1.21.6" description="nginx:1.21.6-alpine"

ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


VOLUME ["/var/www/html", "/etc/nginx/conf.d", "/var/log/nginx"]
