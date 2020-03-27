#
# Dockerfile for building nginx images


FROM nginx:1.10

LABEL maintainer="wxxiong <wxxiong6@gmail.com>" version="1.0" description="nginx:1.10"

ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN rm /etc/nginx/conf.d/default.conf

VOLUME ["/var/www/html", "/etc/nginx/conf.d", "/var/log/nginx"]
