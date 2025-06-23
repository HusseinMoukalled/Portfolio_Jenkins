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

    stage('Deploy to Kubernetes') {
      steps {
        script {
          sh """
            kubectl set image deployment/django-deployment django-container=mydjangoapp:latest --record
            kubectl rollout status deployment/django-deployment
          """
        }
      }
    }
  }
}
