@echo off
REM Use Minikube's Docker daemon
FOR /f "tokens=*" %%i IN ('minikube docker-env') DO @%%i

REM Build new image inside Minikube
docker build -t portfolio:latest .

REM Ensure kubectl uses your user kubeconfig
SET KUBECONFIG=C:\Users\Hussein\.kube\config

REM Apply YAMLs
kubectl apply -f k8s\deployment.yaml
kubectl apply -f k8s\service.yaml

REM ✅ Force pods to restart so they pull the new image
kubectl rollout restart deployment portfolio-deployment
