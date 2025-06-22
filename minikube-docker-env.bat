@echo off
FOR /f "tokens=*" %%i IN ('minikube docker-env') DO @%%i
