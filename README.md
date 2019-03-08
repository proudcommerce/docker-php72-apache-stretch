# docker-php72-apache-stretch
Docker image with Apache and PHP 7.2 on Debian Stretch

## Needed .env Variables
`ServerAdmin ${PS_APACHE_SERVERADMIN}`

`DocumentRoot ${PS_APACHE_DOCROOT}`

`ErrorLog ${APACHE_LOG_DIR}/error.log`

`CustomLog ${APACHE_LOG_DIR}/access.log combined`
