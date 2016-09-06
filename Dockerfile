FROM wordpress:4.5.2-apache

RUN pecl install xdebug-beta \
    && docker-php-ext-enable xdebug \
	&& docker-php-ext-install gd \
	&& echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.default_enable=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
	&& echo "xdebug.coverage_enable=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
	&& echo "extension=gd.so" > /usr/local/etc/php/conf.d/ext-gd.ini

RUN a2enmod rewrite

ENV APACHE_RUN_USER wordpress
ENV APACHE_RUN_GROUP wordpress

RUN adduser --uid 1000 --disabled-password wordpress

RUN chown -R "$APACHE_RUN_USER:$APACHE_RUN_GROUP" /var/lock/apache2 /var/run/apache2
