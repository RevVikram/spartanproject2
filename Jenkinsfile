pipeline {
  agent any
  
 environment {
  IMAGE_NAME ="revvikram/spartanproject2:1." + "$BUILD_NUMBER"
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
          docker.withRegistry('','docker_hub_cred'){
            DOCKER_IMAGE.push()
            
          }
       }
     }
    }
  }
}
