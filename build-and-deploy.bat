@echo off
REM Generate unique tag
SET TAG=%RANDOM%-%TIME:~6,2%%TIME:~3,2%%TIME:~0,2%

REM Build locally
docker build -t portfolio:%TAG% .

REM Tag for local registry
docker tag portfolio:%TAG% localhost:5000/portfolio:%TAG%

REM Push to local registry
docker push localhost:5000/portfolio:%TAG%

REM Use kubeconfig
SET KUBECONFIG=C:\Users\Hussein\.kube\config

REM Apply deployment
kubectl apply -f k8s\deployment.yaml

REM Force deployment to use new image from local registry
kubectl set image deployment/portfolio-deployment portfolio=localhost:5000/portfolio:%TAG%

REM Apply service
kubectl apply -f k8s\service.yaml
