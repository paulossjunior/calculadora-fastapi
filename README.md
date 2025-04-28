# 📟 FastAPI Calculator

Uma calculadora simples usando FastAPI, com automação de testes, build e publicação via Docker.

---

## 📚 Conceitos principais

### 📦 O que é Docker?
Docker é uma plataforma que permite **empacotar** uma aplicação e todas as suas dependências em um **container**.  
Isso garante que o software funcione da mesma forma em qualquer ambiente — seja na sua máquina, em um servidor, ou na nuvem.

**Resumo:**  
- Funciona como uma "máquina virtual leve" para suas aplicações.
- Garante que o ambiente de execução seja sempre o mesmo.

---

### 🛠️ O que é um Dockerfile?
O `Dockerfile` é um **arquivo de instruções**.  
Ele ensina ao Docker como construir uma imagem da sua aplicação.

Exemplo básico:
```Dockerfile
FROM python:3.11
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

**Resumo:**  
- Define a imagem base.
- Copia o código-fonte.
- Instala as dependências.
- Inicia o servidor.

---

### 🗂️ O que é Docker Compose?
O `docker-compose.yml` é um arquivo que **orquestra múltiplos containers**.  
Em vez de rodar `docker run` manualmente para cada container, você descreve tudo no Compose e sobe com um só comando.

**Resumo:**  
- Gerencia múltiplos containers.
- Define redes, volumes e dependências.
- Facilita a subida de ambientes complexos.

---

## 🏗️ Estrutura do Projeto

```plaintext
fastapi-calculator/
├── app/
│   ├── main.py
│   ├── models.py
│   ├── operations.py
│   └── __init__.py
├── tests/
│   ├── test_main.py
│   └── __init__.py
├── Dockerfile
├── docker-compose.yml
├── Makefile
├── requirements.txt
├── README.md
└── .github/
    └── workflows/
        └── docker-build.yml
```

---

## 🚀 Fluxo de Desenvolvimento

1. **Rodar Testes Localmente**
   
Antes de qualquer coisa, valide que tudo funciona:

```bash
make test
```

2. **Buildar a Imagem Docker Localmente**

Cria a imagem da aplicação:

```bash
make docker-build
```

3. **Rodar o Container Localmente**

Sobe a aplicação no `localhost:8000`:

```bash
make docker-run
```

4. **Parar e Remover o Container**

Encerra o container em execução:

```bash
make docker-stop
```

5. **Publicar a Imagem no GitHub Packages**

Depois que os testes passarem:

```bash
make docker-push-ghcr
```

*(Certifique-se de fazer login no GHCR usando `make docker-login` antes se necessário.)*

---

## ⚙️ Entendendo CI/CD no Projeto

### 📚 O que é CI e CD?

| Termo | Significado | Explicação |
|:------|:------------|:-----------|
| CI (Continuous Integration) | Integração Contínua | Processo de testar automaticamente todas as mudanças feitas no código assim que elas são enviadas para o repositório. Garante que o código novo **não quebre** o sistema existente. |
| CD (Continuous Delivery) | Entrega Contínua | Processo de preparar e disponibilizar automaticamente a aplicação para deploy após a aprovação dos testes. |

Em resumo:
- **CI** = Rodar testes automáticos para validar o código.
- **CD** = Preparar o código e publicá-lo em um ambiente (neste caso, criando a imagem Docker no GitHub Packages).

---

### 🛠️ Como funciona o fluxo de CI/CD neste projeto?

Quando você faz um `git push` para a branch `main` ou `master`:

1. **Test Job (🧪)** é iniciado:
   - Faz checkout do repositório.
   - Instala as dependências do projeto.
   - Roda todos os testes com `pytest`.
2. Se **todos os testes passarem**:
   - **Deploy Job (🚀)** é iniciado automaticamente.
   - Faz login no GitHub Container Registry (`ghcr.io`).
   - Builda a imagem Docker da aplicação.
   - Faz o push da imagem para o GitHub Packages (`ghcr.io/SEU_USUARIO/fastapi-calculator`).

Se **os testes falharem**, o deploy **não acontece**.

---


### 🔐 Permissões Necessárias no GitHub

O Actions usa o `GITHUB_TOKEN` nativo para:
- Fazer login no GitHub Container Registry.
- Publicar a imagem sem precisar de senha externa.
- As permissões no workflow são configuradas com:
  
```yaml
permissions:
  contents: read
  packages: write
```


### 📦 Como acessar sua imagem no GitHub Packages

Depois de publicado:

- Vá no repositório → Aba **Packages**
- Você verá a imagem `fastapi-calculator`
- A URL será:  
  ```
  ghcr.io/SEU_USUARIO/fastapi-calculator:latest
  ```

Para usar localmente:

```bash
docker pull ghcr.io/SEU_USUARIO/fastapi-calculator:latest
docker run -d -p 8000:8000 ghcr.io/SEU_USUARIO/fastapi-calculator:latest
```

---

## 🧹 Comandos úteis do Makefile

| Comando | Descrição |
|:--------|:----------|
| `make test` | Rodar testes unitários |
| `make docker-build` | Buildar imagem Docker local |
| `make docker-run` | Rodar container localmente |
| `make docker-stop` | Derrubar container |
| `make docker-login` | Fazer login no GitHub Packages |
| `make docker-push-ghcr` | Enviar imagem para o GitHub Packages |
| `make docker-clean` | Limpar imagens Docker locais |
