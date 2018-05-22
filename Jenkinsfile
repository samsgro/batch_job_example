pipeline {
  agent {
    node {
      label 'tools'
    }
    
  }
  stages {
    stage('build') {
      steps {
        sh 'echo $USER'
        sh 'aws --version'
        sh 'curl -fsSL get.docker.com -o get-docker.sh'
        sh 'sudo sh get-docker.sh'
        sh 'docker --version'
        sh 'ls -la'
      }
    }
  }
  environment {
    USER = 'jenkins'
  }
}
