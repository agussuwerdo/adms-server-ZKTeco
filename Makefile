.PHONY: help start stop restart rebuild ssh artisan composer test logs clean

# Default target when running just 'make'
help:
	@echo "Available commands:"
	@echo "  make start      - Start Docker containers"
	@echo "  make stop       - Stop Docker containers"
	@echo "  make restart    - Restart Docker containers"
	@echo "  make rebuild    - Rebuild Docker containers from scratch"
	@echo "  make ssh        - SSH into PHP container"
	@echo "  make artisan    - Run Laravel Artisan command (usage: make artisan cmd=migrate)"
	@echo "  make composer   - Run Composer command (usage: make composer cmd=require package)"
	@echo "  make test       - Run PHPUnit tests"
	@echo "  make logs       - View Docker container logs"
	@echo "  make clean      - Remove all Docker containers, images, and volumes"

# Start Docker containers
start:
	docker-compose up -d

# Stop Docker containers
stop:
	docker-compose down

# Restart Docker containers
restart:
	docker-compose down
	docker-compose up -d

# Rebuild Docker containers from scratch
rebuild:
	docker-compose down -v
	docker-compose build --no-cache
	docker-compose up -d

# SSH into PHP container
ssh:
	docker-compose exec app bash

# Run Laravel Artisan commands
artisan:
	docker-compose exec app php artisan $(cmd)

# Run Composer commands
composer:
	docker-compose exec app composer $(cmd)

# Run PHPUnit tests
test:
	docker-compose exec app php artisan test

# View Docker logs
logs:
	docker-compose logs -f

# Clean everything
clean:
	docker-compose down -v
	docker system prune -af --volumes 