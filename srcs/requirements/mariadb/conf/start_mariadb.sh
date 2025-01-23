#!/bin/sh

# Initialize MariaDB data directory if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null 2>&1
fi

# Start MariaDB in the background for initial setup
echo "Starting MariaDB..."
mysqld_safe --datadir='/var/lib/mysql' &
sleep 10  # Give MariaDB time to start

# Wait until MariaDB is up and running
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Set up the database and user only if it hasn't been done yet
if [ ! -f /var/lib/mysql/.setup_done ]; then
    echo "Configuring MariaDB for WordPress..."
    mysql -u root <<-EOSQL
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
    CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
    CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

    touch /var/lib/mysql/.setup_done  # Prevent rerunning the setup
fi

echo "MariaDB setup complete. Running in the foreground..."

# Keep MariaDB running in the foreground
wait