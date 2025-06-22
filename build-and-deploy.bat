@echo off
REM --- BUILD IMAGE IN HOST DOCKER ---
SET TAG=%RANDOM%-%TIME:~6,2%%TIME:~3,2%%TIME:~0,2%

docker build -t portfolio:%TAG% .

REM --- COPY IMAGE INTO MINIKUBE ---
minikube image load portfolio:%TAG%

REM --- CONFIGURE KUBECTL ---
SET KUBECONFIG=C:\Users\Hussein\.kube\config

REM --- APPLY YAML (ensures deployment exists) ---
kubectl apply -f k8s\deployment.yaml

REM --- FORCE DEPLOYMENT TO USE THE NEW IMAGE TAG ---
kubectl set image deployment/portfolio-deployment portfolio=portfolio:%TAG%

REM --- APPLY SERVICE FOR GOOD MEASURE ---
kubectl apply -f k8s\service.yaml
