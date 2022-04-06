pipeline {
  agent any

  stages {
    stage('cloning the project from github'){
      steps {
        git branch: 'main',
        url: 'https://github.com/RevVikram/spartanproject2.git'
      }
    }

    stage('Build Docker Image'){
     steps {
      scripts {
        docker.build 'RevVikram/spartanproject2'
      }
     }
    }
  }
}
