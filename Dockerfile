FROM php:7.2-apache-stretch

MAINTAINER hosting@proudsourcing.de

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# timezone / date   
RUN echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# install packages
RUN apt-get update -y && \
  apt-get install -y --no-install-recommends \
  less vim wget unzip rsync git mysql-client postfix autossh \
  libcurl4-openssl-dev libfreetype6 libjpeg62-turbo libpng-dev libjpeg-dev libxml2-dev libwebp6 libxpm4 libc-client-dev libkrb5-dev && \
  apt-get clean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/* && \
  echo "export TERM=xterm" >> /root/.bashrc

# install php extensions
RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/local/ && \
  docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
  docker-php-ext-install -j$(nproc) curl json xml mbstring zip bcmath soap pdo_mysql mysqli gd gettext imap

# composer stuff
RUN php -r 'readfile("https://getcomposer.org/installer");' > composer-setup.php \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  && rm -f composer-setup.php \
  && chown www-data:www-data /var/www

# apache stuff
RUN /usr/sbin/a2enmod rewrite && /usr/sbin/a2enmod headers && /usr/sbin/a2enmod expires
COPY ./files/000-default.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html

CMD ["apache2-foreground"]
