pipeline {
    agent any
    environment {
        GOOGLE_CREDENTIALS = credentials('prefect')
    }
    stages {
        stage('DEPLOYING INFRASTRUCTURE') {
            steps {
                sh '''
                terraform init
                terraform apply -auto-approve
                '''
            }
        }
    }
}