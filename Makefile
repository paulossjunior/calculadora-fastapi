# Variáveis
APP_NAME=app.main:app
UVICORN_CMD=uvicorn
PYTEST_CMD=pytest

# Rodar o servidor FastAPI
run:
	$(UVICORN_CMD) $(APP_NAME) --reload

# Rodar os testes
test:
	$(PYTEST_CMD) tests/

# Instalar as dependências
install:
	pip install -r requirements.txt

# Atualizar o requirements.txt
freeze:
	pip freeze > requirements.txt

# Rodar o servidor em uma porta específica
run-port:
	$(UVICORN_CMD) $(APP_NAME) --reload --port 8001

# Ajuda: mostrar todos os comandos disponíveis
help:
	@echo "Comandos disponíveis:"
	@echo "  make install     - Instalar dependências"
	@echo "  make run         - Rodar o servidor FastAPI"
	@echo "  make run-port    - Rodar o servidor em outra porta"
	@echo "  make test        - Rodar os testes"
	@echo "  make freeze      - Atualizar requirements.txt"
