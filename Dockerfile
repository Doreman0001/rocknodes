FROM node:16

# Install dependencies
RUN apt update && apt install -y \
    php8.0-cli php8.0-common php8.0-mbstring php8.0-mysql \
    php8.0-pgsql php8.0-xml php8.0-curl php8.0-gd unzip \
    curl git nginx mariadb-server supervisor

# Set working directory
WORKDIR /app

# Clone Pterodactyl Panel
RUN git clone https://github.com/pterodactyl/panel.git . && \
    curl -sS https://getcomposer.org/installer | php && \
    php composer.phar install --no-dev --optimize-autoloader

# Setup file permissions
RUN chmod -R 755 storage/* bootstrap/cache

# Copy custom entrypoint
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
CMD ["/entrypoint.sh"]
