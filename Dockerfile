FROM wodby/php-nginx

# Install phpmemcacheadmin
RUN wget http://phpmemcacheadmin.googlecode.com/files/phpMemcachedAdmin-1.2.2-r262.tar.gz && \
    tar xfz phpMemcachedAdmin-1.2.2-r262.tar.gz -C /usr/share/nginx/html/ && \
    rm phpMemcachedAdmin-1.2.2-r262.tar.gz

# Define mountable directories
RUN chown -R www-data:www-data /usr/share/nginx/html

# Define working directory and volumes
WORKDIR /etc/nginx
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/usr/share/nginx/html", "/phpmemcachedadmin"]

COPY Memcache.php /usr/share/nginx/html/memcachedadmin/Config/Memcache.php

# Expose port
EXPOSE 80

ADD ./start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]
