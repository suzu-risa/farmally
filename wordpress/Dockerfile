FROM wordpress:4.9.6-php7.2-fpm

RUN apt-get update
RUN apt-get -y install wget unzip

WORKDIR /tmp/wp-plugins
RUN wget https://downloads.wordpress.org/plugin/contact-form-7.4.6.zip
RUN wget https://downloads.wordpress.org/plugin/syntaxhighlighter.zip
RUN wget https://downloads.wordpress.org/plugin/wp-emmet.zip
RUN wget https://downloads.wordpress.org/plugin/amazon-web-services.1.0.5.zip
RUN wget https://downloads.wordpress.org/plugin/amazon-s3-and-cloudfront.1.4.2.zip

RUN unzip './*.zip' -d /usr/src/wordpress/wp-content/plugins

RUN apt-get clean
RUN rm -rf /tmp/*

RUN chown -R www-data:www-data /usr/src/wordpress/wp-content

WORKDIR /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
