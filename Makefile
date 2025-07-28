ENV_FILE = srcs/.env

DATA_DIR = /home/sde-silv/data

all: compose

$(DATA_DIR):
	mkdir -p /home/sde-silv/data
	mkdir -p /home/sde-silv/data/wordpress
	mkdir -p /home/sde-silv/data/mariadb


compose: $(ENV_FILE) $(DATA_DIR)
	docker compose -f srcs/docker-compose.yml up --build -d
	docker ps | wc -l

up: compose

down: stop
	@read -p "Are you sure? [y/N] " ans && ans=$${ans:-N} ; \
    if [ $${ans} = y ] || [ $${ans} = Y ]; then \
        printf "YES" ;
		docker compose -f srcs/docker-compose.yml down ;\
		docker volume prune -af ;\
		docker volume rm srcs_wordpress ;\
		docker volume rm srcs_mariadb ;\
    else \
        printf "NO" ; \
    fi

start:
	docker compose -f srcs/docker-compose.yml start

stop:
	@-docker ps | wc -l
	docker compose -f srcs/docker-compose.yml stop
	@-docker ps | wc -l

clean: stop

fclean: stop down

status:
	docker ps

log:
	-docker logs nginx
	-docker logs mariadb 
	-docker logs wordpress

.PHONY: all compose up down start stop clean fclean status log
