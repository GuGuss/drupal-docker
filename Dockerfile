FROM php:5.6-apache

RUN apt-get update && apt-get install -y \
        git \
        mysql-client \
        sendmail \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install mcrypt mbstring pdo_mysql mysqli zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && pecl install xdebug \
    && echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "date.timezone = Europe/Paris" > /usr/local/etc/php/conf.d/timezone.ini

RUN a2enmod rewrite

COPY etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/
COPY usr/local/etc/php/php.ini /usr/local/etc/php/php.ini

# Install composer and drush by using composer
ENV COMPOSER_BIN_DIR=/usr/local/bin
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require drush/drush:dev-master
