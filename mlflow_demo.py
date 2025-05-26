import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
import mlflow
import mlflow.sklearn
from sklearn.datasets import load_iris


# Cargar el conjunto de datos de Iris
# X, y = load_iris(return_X_y=True)
iris = load_iris()
X = iris.data
y = iris.target

# Dividir el conjunto de datos
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Parámetros del modelo
n_estimators = 100
max_depth = 3

# Configurar el experimento
mlflow.set_experiment("Iris_Classification")

with mlflow.start_run():
    # Entrenar el modelo
    model = RandomForestClassifier(n_estimators=n_estimators, max_depth=max_depth, random_state=42)
    model.fit(X_train, y_train)

    # Predicciones y métrica
    predictions = model.predict(X_test)
    accuracy = accuracy_score(y_test, predictions)

    # Registrar parámetros y métricas
    mlflow.log_param("n_estimators", n_estimators)
    mlflow.log_param("max_depth", max_depth)
    mlflow.log_metric("accuracy", accuracy)

    # Guardar el modelo
    # mlflow.sklearn.log_model(model, artifact_path="model")
    mlflow.sklearn.log_model(model, "model")
    print(f"Modelo registrado con precisión: {accuracy:.4f}")
