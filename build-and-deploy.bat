@echo off
REM Build fresh image in HOST Docker
SET TAG=%RANDOM%-%TIME:~6,2%%TIME:~3,2%%TIME:~0,2%

docker build -t portfolio:%TAG% .

REM Push the image into Minikube's internal Docker
minikube image load portfolio:%TAG%

REM Force kubectl to use your kubeconfig
SET KUBECONFIG=C:\Users\Hussein\.kube\config

REM Apply deployment YAML (structure stays same)
kubectl apply -f k8s\deployment.yaml

REM Update Deployment to use the new tag (forces new pod)
kubectl set image deployment/portfolio-deployment portfolio=portfolio:%TAG%

REM Apply service YAML
kubectl apply -f k8s\service.yaml
