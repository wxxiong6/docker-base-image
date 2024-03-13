
FROM clickhouse-server:22.3.7.28


ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


LABEL maintainer="wxxiong <wxxiong6@gmail.com>" version="${22.3.7.28}" description="clickhouse-server:22.3.7.28"


