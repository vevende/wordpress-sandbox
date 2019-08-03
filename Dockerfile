FROM wordpress:5-apache

ENV APACHE_RUN_USER=wordpress \
    APACHE_RUN_GROUP=wordpress \
    TERM=xterm

RUN set -ex \
    && pecl install xdebug-beta \
    && docker-php-ext-enable xdebug && ( \
        echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini; \
        echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini; \
        echo "xdebug.default_enable=0" >> /usr/local/etc/php/conf.d/xdebug.ini; \
        echo "xdebug.coverage_enable=0" >> /usr/local/etc/php/conf.d/xdebug.ini; \
        echo 'date.timezone=utc' > /usr/local/etc/php/php.ini ) \
    && adduser --uid 1000 --disabled-password wordpress \
    && chown -R "$APACHE_RUN_USER:$APACHE_RUN_GROUP" /var/lock/apache2 /var/run/apache2 \
    && sed -i '/Listen 80/c\Listen 8080' /etc/apache2/ports.conf \
    && sed -i '/User /c\User wordpress' /etc/apache2/apache2.conf \
    && sed -i '/Group /c\Group wordpress' /etc/apache2/apache2.conf \
    && curl --silent --output /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && apt-get update \
    && apt-get install -y less zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

COPY wp.sh /bin/wp

RUN chmod +x /bin/wp-cli.phar /bin/wp

EXPOSE 8080
