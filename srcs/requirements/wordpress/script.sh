#!/bin/bash

if [ ! -f wp-config.php ]; then

	export $(grep -v '^#' /run/secrets/credentials.txt | xargs)

	cp wp-config-sample.php wp-config.php

	# sed [options] 's/pattern/replacement/flags' file
	# Replace DB placeholders with environment variables
	sed -i "s/database_name_here/$DB_NAME/" wp-config.php
	sed -i "s/username_here/$DB_USER/" wp-config.php
	sed -i "s/password_here/$DB_PWD/" wp-config.php
	sed -i "s/localhost/mysql/" wp-config.php  # assuming your DB host is 'mysql'

	# set WP keys/salts dynamically
	# Remove the placeholder lines
	sed -i "/define('AUTH_KEY'/,/define('NONCE_SALT'/d" wp-config.php
	# Append the generated keys from WordPress API
	curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php
	echo "define( 'WP_ALLOW_REPAIR', true );" >> wp-config.php
	chown www-data:www-data wp-config.php
	chmod 640 wp-config.php

fi

wp user create $WP_USR $WP_EMAIL --role=subscriber --user_pass=$WP_PWD

