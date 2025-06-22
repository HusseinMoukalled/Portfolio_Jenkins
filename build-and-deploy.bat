@echo off
REM Switch to Minikube Docker
FOR /f "tokens=*" %%i IN ('minikube docker-env') DO @%%i

REM Build image
docker build -t portfolio:latest .

REM Force kubeconfig path
SET KUBECONFIG=C:\Users\hussein\.kube\config

REM Apply manifests
kubectl apply -f k8s\deployment.yaml
kubectl apply -f k8s\service.yaml

REM ✅ Force pod restart to pick up fresh image
kubectl rollout restart deployment portfolio-deployment

