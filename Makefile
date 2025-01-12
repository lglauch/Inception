up:
	cd srcs && docker compose up -d

up-all:
	cd srcs && docker-compose up --build

down:
	cd srcs && docker compose down

logs:
	cd srcs && docker-compose logs -f