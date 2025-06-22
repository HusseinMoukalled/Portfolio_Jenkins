@echo off
REM Generate unique tag
SET TAG=%RANDOM%-%TIME:~6,2%%TIME:~3,2%%TIME:~0,2%

REM Build image in host Docker
docker build -t portfolio:%TAG% .

REM Load image into Minikube and specify the profile
minikube image load portfolio:%TAG% --profile=minikube

REM Use your kubeconfig
SET KUBECONFIG=C:\Users\Hussein\.kube\config

REM Apply deployment YAML
kubectl apply -f k8s\deployment.yaml

REM Force Deployment to use the new tag
kubectl set image deployment/portfolio-deployment portfolio=portfolio:%TAG%

REM Apply service YAML
kubectl apply -f k8s\service.yaml
