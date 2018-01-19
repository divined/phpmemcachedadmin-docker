FROM wodby/php-nginx

RUN set -ex && \
    wget -qO- https://blog.elijaa.org/wp-content/uploads/2017/03/phpmemcachedadmin-1.3.0.tar.gz

RUN chown -R www-data:www-data /var/www/html

# Define working directory and volumes
WORKDIR /etc/nginx
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/usr/share/nginx/html", "/phpmemcachedadmin"]

COPY Memcache.php /usr/share/nginx/html/memcachedadmin/Config/Memcache.php

# Expose port
EXPOSE 80

ADD ./start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]
