# MLflow Docker Demo

## Instrucciones para ejecutar el contenedor

### Usando Makefile (Linux/Mac)

Si tienes `make` instalado:

```bash
# Construir la imagen
make build

# Ejecutar el contenedor
make run

# Entrenar el modelo
make train

# Ver los logs
make logs

# Detener el contenedor
make stop

# Abrir la interfaz de MLflow
make open
```

### Usando comandos Docker directamente (Windows PowerShell)

```powershell
# Construir la imagen
docker build -t mlflow_demo .

# Ejecutar el contenedor (con servidor MLflow UI)
docker run -d --name mlflow_container -p 5001:5000 -v ${PWD}/mlruns:/app/mlruns mlflow_demo mlflow ui --host 0.0.0.0

# Entrenar el modelo
docker exec -it mlflow_container python /app/mlflow_demo.py

# Ver los logs
docker logs -f mlflow_container

# Detener y eliminar el contenedor
docker stop mlflow_container
docker rm mlflow_container

# Abrir la interfaz de MLflow en el navegador
Start-Process "http://localhost:5001"
```

### Acceder a la interfaz web de MLflow
Abre el navegador en: http://localhost:5001

