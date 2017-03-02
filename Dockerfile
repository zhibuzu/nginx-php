FROM nginx:latest

MAINTAINER Jesse Hu

ADD ./default.conf /etc/nginx/conf.d/
	