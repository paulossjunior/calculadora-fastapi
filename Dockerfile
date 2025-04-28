# Imagem base
FROM python:3.11-slim

# Definir diretório de trabalho dentro do container
WORKDIR /app

# Copiar arquivos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar o restante do código
COPY ./app ./app
COPY ./run.py .

# Expor a porta padrão do uvicorn
EXPOSE 8000

# Comando para rodar o servidor
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
