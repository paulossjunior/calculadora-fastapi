# Variáveis
SERVICE_NAME=calculator-api  # Nome do serviço no docker-compose.yml
IMAGE_NAME=fastapi-calculator
GITHUB_USER=seu-usuario-aqui  # <-- Trocar pelo seu username do GitHub
REGISTRY=ghcr.io/$(GITHUB_USER)/$(IMAGE_NAME)

# Rodar os testes localmente
test:
	pytest tests/

# Buildar o container usando docker-compose
docker-build:
	docker compose build $(SERVICE_NAME)

# Subir o container usando docker-compose
docker-up:
	docker compose up $(SERVICE_NAME)

# Subir o container em modo detached (background)
docker-up-detached:
	docker compose up -d $(SERVICE_NAME)

# Derrubar o container
docker-down:
	docker compose down

# Fazer login no GitHub Container Registry
docker-login:
	echo $${GITHUB_TOKEN} | docker login ghcr.io -u $(GITHUB_USER) --password-stdin

# Taguear e fazer push da imagem para o GitHub Packages
docker-push-ghcr: docker-build docker-login
	docker tag $(IMAGE_NAME):latest $(REGISTRY):latest
	docker push $(REGISTRY):latest

# Limpar imagens e containers
docker-clean:
	docker compose down --rmi all --volumes --remove-orphans

# Mostrar ajuda
help:
	@echo "Comandos disponíveis:"
	@echo "  make test             - Rodar testes unitários"
	@echo "  make docker-build     - Buildar imagem usando docker compose"
	@echo "  make docker-up        - Subir container (foreground)"
	@echo "  make docker-up-detached - Subir container em background"
	@echo "  make docker-down      - Derrubar container"
	@echo "  make docker-login     - Fazer login no GitHub Packages (GHCR)"
	@echo "  make docker-push-ghcr - Push da imagem para o GitHub Packages"
	@echo "  make docker-clean     - Limpar tudo (containers, imagens, volumes)"
