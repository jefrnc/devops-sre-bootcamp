.PHONY: help build test run clean docker-build docker-run docker-stop docker-clean

# Variables
APP_NAME = journals-app
DOCKER_IMAGE = $(APP_NAME):latest
DOCKER_REGISTRY = your-registry.com
MVN = mvn

# Default target
help:
	@echo "Available targets:"
	@echo "  build         - Build the application"
	@echo "  test          - Run tests"
	@echo "  run           - Run the application locally"
	@echo "  clean         - Clean build artifacts"
	@echo "  docker-build  - Build Docker image"
	@echo "  docker-run    - Run application in Docker"
	@echo "  docker-stop   - Stop Docker containers"
	@echo "  docker-clean  - Remove Docker containers and images"
	@echo "  docker-push   - Push image to registry"

# Build application
build:
	cd Code && $(MVN) clean compile

# Run tests
test:
	cd Code && $(MVN) test

# Package application
package:
	cd Code && $(MVN) clean package

# Run application locally
run:
	cd Code && $(MVN) spring-boot:run

# Clean build artifacts
clean:
	cd Code && $(MVN) clean
	rm -rf Code/target

# Docker targets
docker-build:
	docker build -t $(DOCKER_IMAGE) .

docker-run:
	docker-compose up -d

docker-stop:
	docker-compose down

docker-clean:
	docker-compose down -v
	docker rmi $(DOCKER_IMAGE) || true

docker-push: docker-build
	docker tag $(DOCKER_IMAGE) $(DOCKER_REGISTRY)/$(DOCKER_IMAGE)
	docker push $(DOCKER_REGISTRY)/$(DOCKER_IMAGE)

# Development helpers
dev-setup:
	@echo "Setting up development environment..."
	@echo "1. Installing dependencies..."
	cd Code && $(MVN) dependency:resolve
	@echo "2. Creating upload directory..."
	mkdir -p ~/upload
	@echo "3. Copying sample PDFs..."
	cp -r PDFs/* ~/upload/ 2>/dev/null || true
	@echo "Development environment ready!"

# Database operations
db-start:
	docker-compose up -d mysql

db-stop:
	docker-compose stop mysql

db-clean:
	docker-compose down -v mysql

# Logs
logs:
	docker-compose logs -f

logs-app:
	docker-compose logs -f journals-app

logs-db:
	docker-compose logs -f mysql