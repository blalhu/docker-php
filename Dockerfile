FROM debian:stable

RUN useradd -mUG sudo app \
 && echo 'app:app' | chpasswd \
 && chsh -s /bin/bash app \
 && mkdir /home/app/docroot

RUN apt-get update \
 && apt-get -y install \
    apt-transport-https \
    gnupg \
    curl \
    lsb-release \
    ca-certificates \
 && curl https://packages.sury.org/php/apt.gpg | apt-key add - \
 && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update \
 && apt-get -y install \
    zip \
    unzip \
    php7.2 \
    php7.2-fpm \
    php7.2-mysql \
    php7.2-sqlite \
    php7.2-pgsql \
    php7.2-xml \
    php7.2-mbstring \
    php7.2-curl \
    php7.2-zip \
    php7.2-imagick \
    php7.2-gd

RUN sed -i -- 's/www-data/app/g' /etc/php/7.2/fpm/pool.d/www.conf \
 && sed -i -- 's/listen[[:space:]]*=[[:space:]]*.*/listen = 0.0.0.0:8080/g' /etc/php/7.2/fpm/pool.d/www.conf

CMD service php7.2-fpm start \
 && service php7.2-fpm restart \
 && sleep infinity
