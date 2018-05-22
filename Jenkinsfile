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
        sh 'terraform --version'
      }
    }
    stage('test deployment') {
      steps {
        sh 'sh ./scripts/deploy_global_infra.sh'
      }
    }
  }
  
  environment {
    USER = 'jenkins'
  }
}
