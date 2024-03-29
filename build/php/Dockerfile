FROM php:7.3.31-apache

RUN set -ex; \
    apt-get update && \ 
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y \
    \
    libldap2-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libonig-dev \
    zlib1g-dev \
    libc-client-dev \
    libkrb5-dev \
    libpng-dev \
    libpq-dev \
    libzip-dev \
    libtidy-dev \
    libsodium-dev \
    netcat \
    curl \
    &&  \
    apt-get -y autoclean; apt-get -y autoremove; \
    rm -rf /var/lib/apt/lists/*   

RUN set -ex; \
        ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/

# Install PHP Plugins and Configure PHP imap plugin
RUN set -ex; \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j5 \
    exif \
    gd \
    imap \
    ldap \
    mbstring \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    sodium \
    tidy \
    zip

# Apache configuration
RUN a2enmod headers rewrite remoteip; \
        {\
        echo RemoteIPHeader X-Real-IP ;\
        echo RemoteIPTrustedProxy 10.0.0.0/8 ;\
        echo RemoteIPTrustedProxy 172.16.0.0/12 ;\
        echo RemoteIPTrustedProxy 192.168.0.0/16 ;\
        } > /etc/apache2/conf-available/remoteip.conf;\
        a2enconf remoteip

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

WORKDIR /var/www/html

USER www-data

CMD ["apache2-foreground"]
