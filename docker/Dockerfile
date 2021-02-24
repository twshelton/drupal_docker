FROM ubuntu:18.04
MAINTAINER Thomas Shelton

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get -y install \
  curl \
  php-cli \
  php-mbstring \
  git \
  unzip \
  nginx \
  mariadb-server \
  php-fpm \
  php-curl \
  php-simplexml \
  php-mysql \
  php-gd \
  vim

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && php composer-setup.php --install-dir=/usr/local/bin --filename=composer
ADD ./config/skillpointe.com /etc/nginx/sites-available/skillpointe.com
COPY scripts /root/scripts
RUN ln -s /etc/nginx/sites-available/skillpointe.com /etc/nginx/sites-enabled/
RUN unlink /etc/nginx/sites-enabled/default
CMD bash
