pipeline {
  agent any

  // Automatically check GitHub every 2 minutes
  triggers {
    pollSCM('H/2 * * * *')
  }

  stages {

    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/HusseinMoukalled/Portfolio_Jenkins.git'
      }
    }

    stage('Build in Minikube Docker') {
      steps {
        bat '''
        REM Switch Docker to Minikube's internal Docker daemon
        call minikube docker-env --shell=cmd > docker_env.bat
        call docker_env.bat

        REM Build your Django image inside Minikube's Docker
        docker build -t mydjangoapp:latest .
        '''
      }
    }

    stage('Deploy to Minikube') {
      steps {
        bat '''
        REM Update deployment to use the freshly built image
        kubectl set image deployment/django-deployment django-container=mydjangoapp:latest --record

        REM FORCE Kubernetes to restart the pod to pick up the new image, even if tag is still "latest"
        kubectl rollout restart deployment/django-deployment

        REM Wait for the rollout to complete
        kubectl rollout status deployment/django-deployment
        '''
      }
    }

  }
}
