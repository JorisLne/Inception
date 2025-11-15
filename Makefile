# Variables
COMPOSE_FILE = srcs/docker-compose.yml

.PHONY: all up down clean fclean re

all: up

# Build and start containers
up:
	@echo "Building and starting up services..."
	@mkdir -p /home/jlaine/data/wordpress
	@mkdir -p /home/jlaine/data/mariadb
	docker compose -f $(COMPOSE_FILE) up --build -d

# Stop the services
down:
	@echo "Stopping services..."
	docker compose -f $(COMPOSE_FILE) down

# Stop and remove containers, networks, but keep volumes
clean:
	@echo "Stopping and removing containers and networks..."
	docker compose -f $(COMPOSE_FILE) down

# Full cleanup: stop and remove containers, networks, images, and volumes
fclean:
	@echo "Performing a full cleanup..."
	docker compose -f $(COMPOSE_FILE) down -v --rmi all
	sudo rm -rf /home/jlaine/data/wordpress /home/jlaine/data/mariadb