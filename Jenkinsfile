pipeline {
  agent any

 environment {
  IMAGE_NAME ="revvikram/spartanproject2:1." + "$BUILD_NUMBER"
  DOCKER_CREDENTIALS = 'docker_hub_cred'
  }

  stages {
     stage('Cloning the project from GitHub'){
      steps {
        checkout([
          $class: 'GitSCM', branches: [[name: '*/main']],
          serRemoteConfigs: [[
            url: 'git@github.com:RevVikram/spartanproject2.git',
            credentialsId: 'ssh_git_cred'
          ]]
        ])
    }
  }


    stage('Build Docker Image'){
      steps {
        script {
          DOCKER_IMAGE = docker.build IMAGE_NAME
        }
      }
    }

    stage('Testing the Code'){
      steps{
        script {
          sh '''
            docker run --rm -v $PWD/test-results:/reports --workdir /app $IMAGE_NAME pytest -v --junitxml=/reports/results.xml
          '''
        }
      }

      post {
        always {
          junit testResults: '**/test-results/*.xml'
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

    stage('Removing the Docker'){
      steps {
       sh "docker rmi $IMAGE_NAME"
      }
    }
  }

}
