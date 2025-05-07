# Imagen base con Python
FROM python:3.9-slim

# Directorio de trabajo
WORKDIR /app

# Copiar requirements y el script
COPY requirements.txt .
COPY mlflow_demo.py .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Comando para correr el script
CMD ["python", "mlflow_demo.py"]
