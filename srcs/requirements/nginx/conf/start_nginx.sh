#!/bin/bash

# Set variables for certificate paths and subject
CERT_DIR="/etc/nginx/certs"
CERT_KEY="${CERT_DIR}/ssl_key.key"
CERT_CRT="${CERT_DIR}/ssl_cert.crt"
CERT_SUBJ="/C=DE/ST=BW/L=HN42/O=42Heilbronn/CN=localhost"

# Create directory for SSL certificates if it doesn't exist
mkdir -p "${CERT_DIR}"

# Generate SSL certificates
echo "Generating SSL certificates..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "${CERT_KEY}" \
    -out "${CERT_CRT}" \
    -subj "${CERT_SUBJ}"
echo "SSL certificates generated successfully."

# Check if SSL certificates were created successfully
if [ ! -f "${CERT_KEY}" ] || [ ! -f "${CERT_CRT}" ]; then
    echo "Error: SSL certificate or key file not found!"
    exit 1
fi

# Test NGINX configuration
echo "Testing NGINX configuration..."
nginx -t
if [ $? -ne 0 ]; then
    echo "Error: NGINX configuration test failed!"
    exit 1
fi
echo "NGINX configuration test passed."

# Start NGINX
echo "Starting Nginx..."
nginx -g 'daemon off;'
echo "Nginx exited!"