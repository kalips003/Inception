
FROM debian:bullseye

# install dependancies
RUN apt update && apt install -y \
        php-fpm \
        php-mysql \
        php-xml \
        php-mbstring \
        php-curl \
        curl \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/www/html \
    && chmod -R 755 /var/www/html

WORKDIR /var/www/html

# download wordpress archives
RUN rm -rf * \
    && curl -o latest.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm -f latest.tar.gz \
    && chown -R www-data:www-data /var/www/html

COPY entry.sh /tmp/entry.sh
COPY script_wp_conf.sh /tmp/script_wp_conf.sh
COPY script_wp_setup.sh /tmp/script_wp_setup.sh
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf \
    && mkdir /run/php \
	&& chmod -R 755 /tmp/script_wp_conf.sh \
    && chmod -R 755 /tmp/entry.sh \
    && chmod -R 755 /tmp/script_wp_setup.sh \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

CMD ["/tmp/entry.sh"]