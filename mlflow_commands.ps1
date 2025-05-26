# Script PowerShell equivalente al Makefile para MLflow Docker

# Variables
$IMAGE_NAME = "mlflow_demo"
$CONTAINER_NAME = "mlflow_container"
$PORT = 5001

# Función para mostrar la ayuda
function Show-Help {
    Write-Host "Comandos disponibles:"
    Write-Host "  .\mlflow_commands.ps1 build   - Construir la imagen Docker"
    Write-Host "  .\mlflow_commands.ps1 run     - Ejecutar el contenedor"
    Write-Host "  .\mlflow_commands.ps1 train   - Entrenar nuestro modelo"
    Write-Host "  .\mlflow_commands.ps1 logs    - Ver los logs en tiempo real"
    Write-Host "  .\mlflow_commands.ps1 stop    - Detener y eliminar el contenedor"
    Write-Host "  .\mlflow_commands.ps1 restart - Reiniciar el contenedor"
    Write-Host "  .\mlflow_commands.ps1 clean   - Eliminar imagen y contenedor"
    Write-Host "  .\mlflow_commands.ps1 open    - Abrir la interfaz de MLflow en el navegador"
}

# Función principal
function Execute-Command {
    param (
        [string]$Command
    )

    switch ($Command) {
        "build" {
            Write-Host "Construyendo la imagen Docker..."
            docker build -t $IMAGE_NAME .
        }
        "run" {
            Write-Host "Ejecutando el contenedor..."
            docker run -d --name $CONTAINER_NAME -p ${PORT}:5000 -v ${PWD}/mlruns:/app/mlruns $IMAGE_NAME
        }
        "train" {
            Write-Host "Entrenando el modelo..."
            docker exec -it $CONTAINER_NAME python /app/mlflow_demo.py
        }
        "logs" {
            Write-Host "Mostrando logs del contenedor..."
            docker logs -f $CONTAINER_NAME
        }
        "stop" {
            Write-Host "Deteniendo el contenedor..."
            docker stop $CONTAINER_NAME 2>$null
            docker rm $CONTAINER_NAME 2>$null
        }
        "restart" {
            Write-Host "Reiniciando el contenedor..."
            Execute-Command "stop"
            Execute-Command "run"
        }
        "clean" {
            Write-Host "Eliminando imagen y contenedor..."
            docker rm $CONTAINER_NAME -f 2>$null
            docker rmi $IMAGE_NAME -f 2>$null
        }
        "open" {
            Write-Host "Abriendo la interfaz de MLflow en el navegador..."
            Start-Process "http://localhost:$PORT"
        }
        default {
            Show-Help
        }
    }
}

# Verificar argumentos
if ($args.Count -eq 0) {
    Show-Help
} else {
    Execute-Command $args[0]
}
