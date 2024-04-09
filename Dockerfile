FROM public.ecr.aws/docker/library/php:7.3-apache-buster
LABEL MAINTAINER="Chris Baugus"

EXPOSE 80

RUN apt-get update \
    && apt-get install -y \
        g++ \
        git \
        libicu-dev \
        libmcrypt4 \
        libonig-dev \
        libzip4 \
        libzip-dev \
        zlib1g-dev \
        zip \
        wamerican \
    && docker-php-ext-install intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip \
    && a2enmod headers ssl \
    && apt-get purge --auto-remove -y g++ libicu-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sSL https://getcomposer.org/installer | php -- --1 \
    && mv composer.phar /usr/local/bin/composer \
    && a2enmod rewrite