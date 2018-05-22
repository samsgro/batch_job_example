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
        sh 'docker info'
      }
    }
  }
  environment {
    USER = 'jenkins'
  }
}
