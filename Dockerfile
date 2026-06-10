#  define a imagem base oficial do Python
FROM python:3.10-slim
# 2. define a pasta dentro do container
WORKDIR /app

# configurações de ambiente para o Python rodar melhor em containers
ENV PYTHONTONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

#instala dependências do sistema necessárias para o SQLite e compilações leves
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

#copia primeiro o arquivo de requisitos para otimizar o cache do Docker
COPY app/requisitos.txt /app/requisitos.txt

# instala as bibliotecas do projeto (Flask, FastAPI, Uvicorn, etc.)
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r /app/requisitos.txt

#copia todo o restante dos arquivos do projeto para o container
COPY . /app/

# informa a porta que o Flask vai rodar (geralmente a 5000)
EXPOSE 5000
# roda o appflask.py quando o container iniciar
CMD ["python", "app/app_flask.py"]