FROM wodby/php-nginx

ENV ADMIN_URL="https://github.com/elijaa/phpmemcachedadmin/archive/1.3.0.tar.gz"

RUN wget -qO- ${ADMIN_URL} | tar xz -C /var/www/html/

# Define mountable directories
RUN chown -R www-data:www-data /var/www/html

# Define working directory and volumes
WORKDIR /etc/nginx
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/usr/share/nginx/html", "/phpmemcachedadmin"]

COPY Memcache.php /usr/share/nginx/html/memcachedadmin/Config/Memcache.php

# Expose port
EXPOSE 80

ADD ./start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]
