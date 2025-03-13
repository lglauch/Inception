up:
	cd srcs && mkdir -p /home/${USER}/data && docker-compose up -d

up-all:
	cd srcs && mkdir -p /home/${USER}/data && docker-compose up --build

down:
	cd srcs && docker-compose down

logs:
	cd srcs && docker-compose logs -f

clean:
	cd srcs && docker-compose down -v && rm -rf /home/${USER}/data
	docker volume prune -f
	docker system prune -f