FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y php7.4-fpm php7.4-common php7.4-mysql \
	php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-gd \
	php7.4-imagick php7.4-cli php7.4-dev  \
	php7.4-mbstring php7.4-opcache  \
	php7.4-soap php7.4-zip \
	default-mysql-client \
	wget tar curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN mkdir /run/php/

COPY config/start_wordpress.sh /start_wordpress.sh
RUN chmod +x /start_wordpress.sh

ENTRYPOINT [ "sh", "/start_wordpress.sh" ]