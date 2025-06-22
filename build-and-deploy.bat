@echo off
REM === ✅ Set dynamic tag ===
SET TAG=%RANDOM%-%TIME:~6,2%%TIME:~3,2%%TIME:~0,2%

REM === ✅ Use Minikube internal registry ===
SET REGISTRY=registry.kube-system.svc.cluster.local:50681

REM === ✅ Build and push ===
docker build -t portfolio:%TAG% .
docker tag portfolio:%TAG% %REGISTRY%/portfolio:%TAG%
docker push %REGISTRY%/portfolio:%TAG%

REM === ✅ Apply deployment ===
kubectl apply -f k8s\deployment.yaml
kubectl set image deployment/portfolio-deployment portfolio=%REGISTRY%/portfolio:%TAG%

REM === ✅ Apply service ===
kubectl apply -f k8s\service.yaml
