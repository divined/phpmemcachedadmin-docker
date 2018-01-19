FROM wodby/php-nginx

# Install phpmemcacheadmin
RUN wget https://github.com/elijaa/phpmemcachedadmin/archive/1.3.0.tar.gz && \
    tar xfz 1.3.0.tar.gz -C /usr/share/nginx/html/ && \
    rm 1.3.0.tar.gz

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
