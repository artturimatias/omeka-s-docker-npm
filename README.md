# omeka-s-docker-npm

Setup for quickly testing [omeka-s](http://omeka.org/s/). Everything needed is installed (modules, themese, database). The database (mysql) is created as a a separate container. 

This is based on https://github.com/boredland/omeka-s-docker. 

## Usage

1. checkout this repository

    	git clone https://github.com/artturimatias/omeka-s-docker-npm.git
    	cd omeka-s-docker-npm
    	
2. Fetch omeka-s source:

        git clone https://github.com/omeka/omeka-s

3. Create container network and database

        make create_network
        make run_mysql

4. Build and run omeka-s

        make build 
        make run

5. Browse to http://localhost:8080 and you should see a user registration form.


The default port is 8080 but you can change that in Makefile.
