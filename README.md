# omeka-s-docker-npm
Docker setup for omeka-s based on https://github.com/boredland/omeka-s-docker. The database (mysql) is also created and is running in a separate container.



## Usage

1. checkout this repository

    	git clone https://github.com/artturimatias/omeka-s-docker-npm.git
    	cd omeka-s-docker-npm
    	
2. Fetch omeka-s source:

        git clone https://github.com/omeka/omeka-s

3. Create database

        make run_mysql

4. Build and run omeka-s

        make build 
        make run
        
The default port is 8000 so you can acces omeka-s in: http://localhost:8000.You can change that in Makefile.
