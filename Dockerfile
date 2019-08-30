FROM debian:stable

RUN useradd -mUG sudo app \
 && echo 'app:app' | chpasswd \
 && chsh -s /bin/bash app \
 && mkdir /home/app/docroot

RUN apt-get update \
 && apt-get -y install \
    lsb-base \
    curl \
    zip \
    unzip \
    php7.3 \
    php7.3-common \
    php7.3-cli \
    php7.3-fpm \
    php7.3-mysql \
    php7.3-sqlite \
    php7.3-pgsql \
    php7.3-xml \
    php7.3-mbstring \
    php7.3-curl \
    php7.3-zip \
    php7.3-intl \
    php7.3-imagick \
    php7.3-gd

RUN sed -i -- 's/www-data/app/g' /etc/php/7.3/fpm/pool.d/www.conf \
 && sed -i -- 's/listen[[:space:]]*=[[:space:]]*.*/listen = 0.0.0.0:8080/g' /etc/php/7.3/fpm/pool.d/www.conf

CMD service php7.3-fpm start \
 && service php7.3-fpm restart \
 && sleep infinity
