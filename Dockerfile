FROM python:3.9-slim

WORKDIR /app

# Instalar git y otros paquetes necesarios
RUN apt-get update && apt-get install -y git

# Instalar dependencias de Python
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto de los archivos
COPY . .

CMD ["mlflow", "server", "--host", "0.0.0.0", "--port", "5000", "--backend-store-uri", "sqlite:///mlflow.db"]
