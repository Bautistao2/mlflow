# Nombre de la imagen
IMAGE_NAME=mlflow_demo
CONTAINER_NAME=mlflow_container
PORT=5001

# Construir la imagen
build:
	docker build -t $(IMAGE_NAME) .

# Ejecutar el contenedor
run:
	docker run -d --name $(CONTAINER_NAME) -p $(PORT):5000 -v ${PWD}/mlruns:/app/mlruns $(IMAGE_NAME)

train:
	docker exec -it $(CONTAINER_NAME) python /app/mlflow_demo.py

# Ver logs del contenedor
logs:
	docker logs -f $(CONTAINER_NAME)

# Detener el contenedor
stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

# Reiniciar el contenedor
restart: stop run

# Limpiar imágenes y contenedores
clean:
	docker rmi $(IMAGE_NAME) -f
	docker rm $(CONTAINER_NAME) -f || true

# Abrir la interfaz de MLflow en el navegador (Linux)
open-linux:
	xdg-open http://localhost:$(PORT)

# Abrir la interfaz de MLflow en el navegador (macOS)
open-mac:
	open http://localhost:$(PORT)

# Abrir la interfaz de MLflow en el navegador (Windows)
open-win:
	start http://localhost:$(PORT)

# Alias para abrir el navegador dependiendo del sistema
open: open-win

# Ayuda
help:
	@echo "Comandos disponibles:"
	@echo "  make build   - Construir la imagen Docker"
	@echo "  make run     - Ejecutar el contenedor"
	@echo "  make train   - Entrenar nuestro modelo"
	@echo "  make logs    - Ver los logs en tiempo real"
	@echo "  make stop    - Detener y eliminar el contenedor"
	@echo "  make restart - Reiniciar el contenedor"
	@echo "  make clean   - Eliminar imagen y contenedor"
	@echo "  make open    - Abrir la interfaz de MLflow en el navegador"
