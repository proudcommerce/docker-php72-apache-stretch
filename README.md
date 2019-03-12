# docker-php72-apache-stretch
Docker image with Apache PHP 7.2 / mod_pagespeed / composer / ioncube on Debian Stretch

## ENV variables
`ServerAdmin ${PS_APACHE_SERVERADMIN}`

`DocumentRoot ${PS_APACHE_DOCROOT}`

`ErrorLog ${APACHE_LOG_DIR}/error.log`

`CustomLog ${APACHE_LOG_DIR}/access.log combined`

## Notice

mod_pagespeed is globally off, enable in vhost or htaccess.
