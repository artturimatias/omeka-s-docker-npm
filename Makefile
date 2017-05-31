IMAGES := $(shell docker images -f "dangling=true" -q)
CONTAINERS := $(shell docker ps -a -q -f status=exited)
CONT := omeka-s
PWD=$(shell pwd)


build:
	docker build -t docker/omeka-s .

create_network:
	docker network create --driver bridge gp

run:
	docker run -d --name omeka_s -p 8080:80 --net=gp docker/omeka-s

stop:
	docker stop $(CONT)
	
remove:
	docker stop $(CONT)
	docker rm  $(CONT)

run_mysql:
	docker run --net=gp --name mysql_omeka -e MYSQL_DATABASE=omeka -e MYSQL_USER=root -e MYSQL_ROOT_PASSWORD=root -d mysql:5.7


restart:
	docker restart $(CONT)


bash:
	docker exec -it $(CONT) bash

clean:
	docker rm -f $(CONTAINERS)
	docker rmi -f $(IMAGES)



.PHONY: build create_network run stop remove run_mysql restart bash clean
