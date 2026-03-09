#!/bin/bash

set -e  # stop script if any command fails

set -a
. /run/secrets/wp_credentials
set +a


echo -e $C_430 "--- script_wp_setup.sh ---" $RESET
echo -e $C_104 "WP_ADMIN_USR=$WP_ADMIN_USR" $RESET
echo -e $C_104 "WP_ADMIN_PWD=$WP_ADMIN_PWD" $RESET
echo -e $C_104 "WP_USR=$WP_USR" $RESET
echo -e $C_104 "WP_USR_PWD=$WP_USR_PWD" $RESET
echo -e $C_430 "-------------------------" $RESET

# Install WordPress only if not already installed
if ! wp core is-installed --allow-root >/dev/null 2>&1; then
	wp core install \
	--url=http://$DOMAIN_NAME \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN_USR" \
	--admin_password="$WP_ADMIN_PWD" \
	--admin_email="$WP_ADMIN_EMAIL" \
	--skip-email \
	--allow-root
	chown -R www-data:www-data /var/www/html
	echo -e $C_430 "-0--wp core installed---------------------" $RESET
fi
echo -e $C_104 "WP_ADMIN_USR=$WP_ADMIN_USR" $RESET
echo -e $C_104 "WP_ADMIN_PWD=$WP_ADMIN_PWD" $RESET
echo -e $C_430 "-1-----------------------" $RESET

# Create subscriber user only if it doesn't exist
echo -e $C_430 "-2-----------------------" $RESET
if ! wp user get $WP_USR --allow-root >/dev/null 2>&1; then
	wp user create $WP_USR $WP_EMAIL --role=subscriber --user_pass=$WP_USR_PWD --allow-root
fi
echo -e $C_430 "-3-----------------------" $RESET
