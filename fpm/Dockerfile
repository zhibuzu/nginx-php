FROM php:7.0-fpm

MAINTAINER Jesse Hu <hu2014jesse@gmail.com>

# 挂载宿主机代码目录
RUN mkdir /home/www

# 添加apt的网易源
# RUN touch /etc/apt/sources.list.d/163.sources.list && \
#	echo "deb http://mirrors.163.com/ubuntu/ precise main restricted universe multiverse" | tee /etc/apt/sources.list.d/163.sources.list && \
#	echo "deb http://mirrors.163.com/ubuntu/ precise-security main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/163.sources.list && \
#	echo "deb http://mirrors.163.com/ubuntu/ precise-updates main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/163.sources.list && \
#	echo "deb http://mirrors.163.com/ubuntu/ precise-proposed main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/163.sources.list && \
#	echo "deb http://mirrors.163.com/ubuntu/ precise-backports main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/163.sources.list && \
#	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5

# clear apt sources.list
RUN echo '' > /etc/apt/sources.list

# add aliyun sources.list
RUN touch /etc/apt/sources.list.d/aliyun.sources.list && \
echo "deb http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial main" && \
echo "deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial main" && \
echo "deb http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial-updates main" && \
echo "deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial-updates main" && \
echo "deb http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial universe" && \
echo "deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial universe" && \
echo "deb http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial-updates universe" && \
echo "deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial-updates universe" && \
echo "deb http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial-security main" && \
echo "deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial-security main" && \
echo "deb http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial-security universe" && \
echo "deb-src http://mirrors.cloud.aliyuncs.com/ubuntu/ xenial-security universe" && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5

# 安装基本模块
RUN	apt-get update && \
	apt-get install -y --force-yes --no-install-recommends \
		apt-transport-https \
		ca-certificates \
		locales \
		curl \
		wget \
		zlib1g-dev \
		libmemcached-dev \
		libz-dev \
		libpq-dev \
		libjpeg-dev \
		libpng12-dev \
		libfreetype6-dev \
		libssl-dev \
		libmcrypt-dev \
	&& rm -rf /tmp/* && rm -rf /var/fmp/* && rm -rf /var/lib/apt/lists/*

# Install the PHP mcrypt extention
RUN docker-php-ext-install mcrypt

# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql

# Install the PHP pdo_pgsql extention
RUN docker-php-ext-install pdo_pgsql

#####################################
# gd:
#####################################

# Install the PHP gd library
RUN docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd


#####################################
# Mysqli Modifications:
#####################################

ARG INSTALL_MYSQLI=false
RUN if [ ${INSTALL_MYSQLI} = true ]; then \
    docker-php-ext-install mysqli \
;fi


##############################
# PHP memcached
##############################
ARG INSTALL_MEMCACHED=false
RUN if [ ${INSTALL_MEMCACHED} = true ]; then \
	curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz" && \
	mkdir -p memcached && \
	tar -C memcached -zxvf /tmp/memcached.tar.gz --strip 1 && \
	( \
		cd memcached \
		&& phpize \
		&& ./configure \
		&& make \
		&& make install \
	) \
	&& docker-php-ext-enable memcached \
	&& rm -rf memcached \
	&& rm /tmp/memcached.tar.gz \
;fi

###############################
# xDebug:
###############################
ARG INSTALL_XDEBUG=false
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
	pecl install xdebug && \
    docker-php-ext-enable xdebug.so \
;fi

# Copy xdebug configration for remote debugging
COPY ./ext/xDebug/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
	
#####################################
# Human Language and Character Encoding Support:
#####################################

ARG INSTALL_INTL=false
RUN if [ ${INSTALL_INTL} = true ]; then \
    # Install intl and requirements
    apt-get update -yqq && \
    apt-get install -y zlib1g-dev libicu-dev g++ && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl \
;fi

#####################################
# ZipArchive:
#####################################

ARG INSTALL_ZIP_ARCHIVE=false
RUN if [ ${INSTALL_ZIP_ARCHIVE} = true ]; then \
    # Install the zip extension
    docker-php-ext-install zip \
;fi
	

#声明暴露9000端口
EXPOSE 9000
	