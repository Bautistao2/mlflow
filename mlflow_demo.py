import mlflow
import mlflow.sklearn
from sklearn.ensemble import RandomForestClassifier
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

# Cargar datos 
X, y = load_iris(return_X_y=True)
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=42)

# Crear y entrenar modelo 
model = RandomForestClassifier(n_estimators=100, max_depth=3, random_state=42)
model.fit(X_train, y_train)

# Evaluar 
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)

# Iniciar experimento 
mlflow.set_experiment("Iris_Classification")

with mlflow.start_run():
    mlflow.log_param("n_estimators", 100)
    mlflow.log_param("max_depth", 3)
    mlflow.log_metric("accuracy", accuracy)

    # Guardar el modelo 
    mlflow.sklearn.log_model(model, artifact_path="model")
    print("Modelo guardado y versionado con MLflow.") 