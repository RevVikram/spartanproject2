pipeline {
  agent any

 environment {
  IMAGE_NAME ="revvikram/spartanproject2:1." + "$BUILD_NUMBER"
  DOCKER_CREDENTIALS = 'docker_hub_cred'
  }

  stages {
    stage('cloning the project from github'){
      steps {
        git branch: 'main',
        url: 'https://github.com/RevVikram/spartanproject2.git'
      }
    }

    stage('Build Docker Image'){
      steps {
        script {
          DOCKER_IMAGE = docker.build IMAGE_NAME
        }
      }
    }

    stage('push to docker hub'){
      steps {
        script {
          docker.withRegistry('',DOCKER_CREDENTIALS){
            DOCKER_IMAGE.push()

          }
       }
     }
    }
  }
}
