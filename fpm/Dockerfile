FROM daocloud.io/library/php:7.0-fpm

MAINTAINER Jesse Hu <hu2014jesse@gmail.com>

# 挂载宿主机代码目录
RUN mkdir /home/www

ENV PHP_EXT_SRC_DIR = /usr/local/src
ENV PHP_INI_DIR = /usr/local/etc/php

COPY sources.list /etc/apt/sources.list
COPY ext/libmemcached-1.0.18.tar.gz /usr/local/src
COPY ext/php-memcached /usr/local/src/php-memcached
COPY php.ini /usr/local/etc/php

# 安装模块
RUN 	apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 40976EAF437D05B5 && \
	apt-get update && \
	apt-get install -yqq \
		apt-transport-https \
		ca-certificates \
		locales \
		wget \
		zlib1g-dev && \
	rm -rf /tmp/* && rm -rf /var/fmp/*

# 安装libmemcaced
RUN cd /usr/local/src && \
	tar zxvf libmemcached-1.0.18.tar.gz && \
	cd libmemcached-1.0.18 && \
	./configure \
		--prefix=/usr/local/libmemcached && \
	make && make install

# 安装memcached扩展
RUN cd /usr/local/src/php-memcached && \
	/usr/local/bin/phpize && \
	./configure --with-php-config=/usr/local/bin/php-config --with-libmemcached-dir=/usr/local/libmemcached --with-zlib-dir --disable-memcached-sasl && \
	make && make install

###############################
# xDebug:
###############################
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug.so

# Copy xdebug configration for remote debugging
COPY ./ext/xDebug/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
	
	

#声明暴露9000端口
EXPOSE 9000
	