IMAGES := $(shell docker images -f "dangling=true" -q)
CONTAINERS := $(shell docker ps -a -q -f status=exited)
CONT := omeka-s
PWD=$(shell pwd)


build:
	docker build -t docker/omeka-s .

run:
	docker run -d --name omeka-s -p 8080:80 --link mysql_omeka:db docker/omeka-s

stop:
	docker stop $(CONT)
	
remove:
	docker stop $(CONT)
	docker rm  $(CONT)

run_mysql:
	docker run --name mysql_omeka -e MYSQL_DATABASE=omeka -e MYSQL_USER=root -e MYSQL_ROOT_PASSWORD=root -d mysql:5.7


restart:
	docker restart $(CONT)


bash:
	docker exec -it $(CONT) bash

clean:
	docker rm -f $(CONTAINERS)
	docker rmi -f $(IMAGES)



.PHONY: build run stop remove run_mysql restart bash clean
