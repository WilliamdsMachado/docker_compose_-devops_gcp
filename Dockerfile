# Use uma imagem base oficial do Python.
# A versão alpine é leve, o que é ótimo para produção.
# Usando Python 3.12, uma versão estável e recente, conforme o readme pede 3.10+.
FROM python:3.12-alpine

# Define o diretório de trabalho no contêiner para /app
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# Fazer isso em um passo separado aproveita o cache de camadas do Docker.
COPY requirements.txt .

# Instala as dependências.
# --no-cache-dir reduz o tamanho da imagem.
# --upgrade pip garante que estamos usando a versão mais recente do pip.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta em que a aplicação será executada.
EXPOSE 8000

# Comando para iniciar a aplicação com Uvicorn em modo de produção.
# Usamos --host 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]