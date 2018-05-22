pipeline {
  agent {
    node {
      label 'tools'
    }
    
  }
  stages {
    stage('build') {
      steps {
        sh 'ls -la'
        sh 'echo $USER'
        sh 'aws --version'
        sh 'sh ./scripts/install_docker.sh'
        sh 'sudo docker info'
        sh 'sh ./scripts/install_terraform.sh'
      }
    }
    stage('test deployment') {
      steps {
        sh 'cd infrastructure/dev/global'
        sh 'ls -la'
      }
    }
  }
  
  environment {
    USER = 'jenkins'
  }
}
