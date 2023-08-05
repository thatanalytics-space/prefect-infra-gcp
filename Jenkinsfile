pipeline {
    agent any
    environment {
        GOOGLE_CREDENTIALS = credentials('prefect')
    }
    stages {
        stage('DEPLOYING INFRASTRUCTURE') {
            steps {
                sh '''
                gcloud auth activate-service-account --key-file=$GOOGLE_CREDENTIALS
                terraform init
                terraform apply -auto-approve
                '''
            }
        }
    }
}