FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx openssl

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/certs

# Copy custom NGINX configuration
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copy the start script
COPY conf/start_nginx.sh /usr/local/bin/start_nginx.sh
#RUN chmod +x /usr/local/bin/start_nginx.sh

# Expose port 443
EXPOSE 443

# Set the entrypoint to the start script
ENTRYPOINT [ "sh", "/usr/local/bin/start_nginx.sh" ]