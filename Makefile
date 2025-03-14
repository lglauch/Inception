up:
	cd srcs && mkdir -p /home/${USER}/data/db && mkdir -p /home/${USER}/data/wordpress && docker compose up -d

up-all:
	cd srcs && mkdir -p /home/${USER}/data/db && mkdir -p /home/${USER}/data/wordpress && docker compose up --build -d

down:
	cd srcs && docker compose down

logs:
	cd srcs && docker compose logs -f

clean:
	cd srcs && docker compose down -v && rm -rf /home/${USER}/data
	docker volume prune -f
	docker system prune -f

#eval: docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null