pipeline {
  agent any

  environment {
    IMAGE_NAME = "mydjangoapp:latest"
  }

  triggers {
    pollSCM('H/2 * * * *')
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/HusseinMoukalled/Portfolio_Jenkins.git'
      }
    }

    stage('Build inside Minikube Docker') {
      steps {
        script {
          sh '''
            eval $(minikube docker-env)
            docker build -t ${IMAGE_NAME} .
          '''
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        script {
          sh """
            kubectl set image deployment/django-deployment django-container=${IMAGE_NAME} --record
            kubectl rollout status deployment/django-deployment
          """
        }
      }
    }
  }
}
