#!/bin/bash

set -e  # stop script if any command fails

wp core download --allow-root
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

set -a
. /run/secrets/credentials
set +a

wp core install \
  --url=http://$DOMAIN_NAME \
  --title="$WP_TITLE" \
  --admin_user="$WP_ADMIN_USR" \
  --admin_password="$WP_ADMIN_PWD" \
  --admin_email="$WP_ADMIN_EMAIL" \
  --skip-email \
  --allow-root

wp user create $WP_USR $WP_EMAIL --role=subscriber --user_pass=$WP_USR_PWD
