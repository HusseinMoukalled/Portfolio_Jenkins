@echo off
REM Switch to Minikube's Docker daemon
FOR /f "tokens=*" %%i IN ('minikube docker-env') DO @%%i

REM Build Docker image
docker build -t portfolio:latest .

REM Apply Kubernetes manifests
kubectl apply -f k8s\deployment.yaml
kubectl apply -f k8s\service.yaml
