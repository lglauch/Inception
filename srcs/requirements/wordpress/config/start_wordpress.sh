#!/bin/sh

check_admin_username() {
    forbidden_substrings="admin Admin administrator Administrator ADMIN"
    for substring in $forbidden_substrings; do
        if echo "$WORDPRESS_ADMIN_USER" | grep -i -q "$substring"; then
            echo "Error: The administrator's username cannot contain 'admin/Admin' or 'administrator/Administrator' in any form."
            exit 1
        fi
    done
}

check_admin_username

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "WordPress not found. Downloading and installing..."

    cd /var/www/html/
    
    echo "Creating wp-config.php..."
    wp config create \
        --dbname=$MARIADB_DATABASE \
        --dbuser=$MARIADB_USER \
        --dbpass=$MARIADB_PASSWORD \
        --dbhost="mariadb" \
        --path=/var/www/html/ \
        --allow-root

    echo "Installing WordPress..."
    wp core install \
        --url="http://localhost" \
        --title="Inception" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --path=/var/www/html/ \
        --allow-root

    wp user create \
        $WORDPRESS_TEST_USER \
        $WORDPRESS_TEST_USER_EMAIL \
        --user_pass=$WORDPRESS_TEST_USER_PASSWORD \
        --role=author \
        --path=/var/www/html/ \
        --allow-root

else
    echo "WordPress already installed."
fi

echo "Updating siteurl and home options..."
wp option update siteurl http://localhost --allow-root --path=/var/www/html/
wp option update home http://localhost --allow-root --path=/var/www/html/
# echo "Configuring PHP-FPM to listen on 0.0.0.0:9000..."
sed -i 's/listen = .*/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

echo Starting PHP-FPM...
php-fpm7.4 -F