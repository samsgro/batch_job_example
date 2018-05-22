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
        sh 'ls -la'
      }
    }
  }
  environment {
    USER = 'jenkins'
  }
}
