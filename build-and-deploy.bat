@echo off
REM Use Minikube's Docker daemon
FOR /f "tokens=*" %%i IN ('minikube docker-env') DO @%%i

REM Generate unique image tag using random + time
SET TAG=%RANDOM%-%TIME:~6,2%%TIME:~3,2%%TIME:~0,2%

REM Build fresh tagged image inside Minikube
docker build -t portfolio:%TAG% .

REM Force kubectl to use your kubeconfig
SET KUBECONFIG=C:\Users\Hussein\.kube\config

REM Apply deployment YAML in case (structure remains)
kubectl apply -f k8s\deployment.yaml

REM Overwrite Deployment image to this unique tag (forces new pod)
kubectl set image deployment/portfolio-deployment portfolio=portfolio:%TAG%

REM Apply service YAML
kubectl apply -f k8s\service.yaml
