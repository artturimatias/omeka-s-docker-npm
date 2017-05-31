FROM php:apache
MAINTAINER Ari Häyrinen <ari.hayrinen@gmail.com>
# based on: https://github.com/boredland/omeka-s-docker

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

# Install git 
RUN apt-get update && \
    apt-get -y install \
    git-core \
    apt-utils \
    zip \
    unzip \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libmemcached-dev \
    zlib1g-dev \
    imagemagick \
    vim \
    nodejs

# Install php-extensions
RUN docker-php-ext-install -j$(nproc) iconv mcrypt \
    pdo pdo_mysql gd
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

# Clone omeka-s
RUN cd / && rm -rf /var/www/html/
ADD omeka-s /var/www/html/

# enable the rewrite module of apache
RUN a2enmod rewrite && /etc/init.d/apache2 restart

# Create a default php.ini
COPY files/php.ini /usr/local/etc/php/

# build omeka-s
RUN cd /var/www/html/ 
RUN npm install && npm install --global gulp-cli
RUN gulp init

# Clone all the Omeka-S Modules
RUN cd /var/www/html/modules && curl "https://api.github.com/users/omeka-s-modules/repos?page=$PAGE&per_page=100" | grep -e 'clone_url*' | cut -d \" -f 4 | xargs -L1 git clone

# Clone all the Omeka-S Themes
RUN cd /var/www/html/themes && rm -r default && curl "https://api.github.com/users/omeka-s-themes/repos?page=$PAGE&per_page=100" | grep -e 'clone_url*' | cut -d \" -f 4 | xargs -L1 git clone

# copy over the database and the apache config
COPY ./files/database.ini /var/www/html/config/database.ini
COPY ./files/apache-config.conf /etc/apache2/sites-enabled/000-default.conf
# set the file-rights
RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R +w /var/www/html/files
# Expose the Port we'll provide Omeka on
EXPOSE 80
