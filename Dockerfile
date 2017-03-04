FROM nginx:latest

MAINTAINER Jesse Hu

ADD ./nginx.conf /etc/nginx/nginx.conf
	