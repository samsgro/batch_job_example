pipeline {
  agent {
    node {
      label 'tools'
    }
    
  }
  stages {
    stage('step1') {
      steps {
        sh 'echo "hello World"'
      }
    }
  }
  environment {
    foo = 'bar'
  }
}
