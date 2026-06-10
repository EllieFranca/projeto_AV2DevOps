# 1. define a imagem base oficial do Python
FROM python:3.10-slim
# 2. define a pasta dentro do container
WORKDIR /app

# 3. configurações de ambiente para o Python rodar melhor em containers
ENV PYTHONTONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 4. instala dependências do sistema necessárias para o SQLite e compilações leves
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 5. copia primeiro o arquivo de requisitos para otimizar o cache do Docker
COPY backend/requisitos.txt /app/requisitos.txt

# 6. instala as bibliotecas do projeto (Flask, FastAPI, Uvicorn, etc.)
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r /app/requisitos.txt

# 7. copia todo o restante dos arquivos do projeto para o container
COPY . /app/

# 8. informa a porta que o Flask vai rodar (geralmente a 5000)
EXPOSE 5000

# 9. comando que inicia o seu servidor principal quando o container ligar
CMD ["python", "backend/app_flask.py"]