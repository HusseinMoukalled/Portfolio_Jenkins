pipeline {
  agent any

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
        call minikube docker-env --shell=cmd > docker_env.bat
        call docker_env.bat
        docker build -t mydjangoapp:latest .
        '''
      }
    }

    stage('Deploy to Minikube') {
      steps {
        bat '''
        kubectl set image deployment/django-deployment django-container=mydjangoapp:latest --record
        kubectl rollout status deployment/django-deployment
        '''
      }
    }
  }
}
