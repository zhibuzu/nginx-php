FROM nginx:latest

MAINTAINER Jesse Hu

RUN mkdir /var/www/

ADD ./nginx.conf /etc/nginx/nginx.conf
	