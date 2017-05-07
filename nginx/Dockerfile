FROM daocloud.io/library/nginx:1.7.1

MAINTAINER Jesse Hu <hu2014jesse@gmail.com>

# 创建代码目录，服务器配置目录，日志目录	
RUN mkdir /home/www \
        && mkdir /home/error \
	&& mkdir /home/logs

COPY ./nginx.conf /etc/nginx.conf

# 声明暴露80和443端口
EXPOSE 80 443