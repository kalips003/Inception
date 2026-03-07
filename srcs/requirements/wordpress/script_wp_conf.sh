#!/bin/bash

set -e  # stop script if any command fails

if [ ! -f wp-config.php ]; then

	export DB_NAME=$(echo $MYSQL_DATABASE)
	export DB_USER=$(echo $MYSQL_USER)
	DB_PWD=$(cat /run/secrets/db_password)

	cp wp-config-sample.php wp-config.php

	# sed [options] 's/pattern/replacement/flags' file
	# Replace DB placeholders with environment variables
	sed -i "s/database_name_here/$DB_NAME/" wp-config.php
	sed -i "s/username_here/$DB_USER/" wp-config.php
	sed -i "s/password_here/$DB_PWD/" wp-config.php
	sed -i "s/localhost/$DB_HOST/" wp-config.php

	# set WP keys/salts dynamically
	# Remove the placeholder lines
	sed -i "/define('AUTH_KEY'/,/define('NONCE_SALT'/d" wp-config.php
	# Append the generated keys from WordPress API
	curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php
	echo "define( 'WP_ALLOW_REPAIR', true );" >> wp-config.php
	chown www-data:www-data wp-config.php
	chmod 640 wp-config.php

fi
