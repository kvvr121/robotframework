pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Setup') {
      steps {
        sh 'python3 -m venv .venv'
        sh '. .venv/bin/activate && pip install -r requirements.txt'
      }
    }
    stage('Run Tests') {
      steps {
        sh '. .venv/bin/activate && robot --pythonpath . -d reports --xunit reports/xunit.xml tests'
      }
    }
    stage('Archive') {
      steps {
        archiveArtifacts artifacts: 'reports/**', fingerprint: true
      }
    }
  }
  post {
    always {
      junit 'reports/xunit.xml'
      archiveArtifacts artifacts: 'reports/**', fingerprint: true
    }
  }
}
