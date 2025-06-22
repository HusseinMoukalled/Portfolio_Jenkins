@echo off
REM Ensure Jenkins uses YOUR user’s Minikube + Kube config
SET MINIKUBE_HOME=C:\Users\Hussein\.minikube
SET USERPROFILE=C:\Users\Hussein
SET KUBECONFIG=C:\Users\Hussein\.kube\config

REM Generate unique tag
SET TAG=%RANDOM%-%TIME:~6,2%%TIME:~3,2%%TIME:~0,2%

REM Build in host Docker
docker build -t portfolio:%TAG% .
IF ERRORLEVEL 1 EXIT /B %ERRORLEVEL%

REM Load into Minikube, force profile, fail if error
minikube image load portfolio:%TAG% --profile=minikube
IF ERRORLEVEL 1 EXIT /B %ERRORLEVEL%

REM Apply deployment
kubectl apply -f k8s\deployment.yaml
IF ERRORLEVEL 1 EXIT /B %ERRORLEVEL%

REM Set image to unique tag
kubectl set image deployment/portfolio-deployment portfolio=portfolio:%TAG%
IF ERRORLEVEL 1 EXIT /B %ERRORLEVEL%

REM Apply service
kubectl apply -f k8s\service.yaml
IF ERRORLEVEL 1 EXIT /B %ERRORLEVEL%
