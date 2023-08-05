pipeline {
    agent any
    stages {
        stage('DEPLOYING INFRASTRUCTURE') {
            steps {
                withCredentials([file(credentialsId: 'prefect', variable: 'GOOGLE_CREDENTIALS')]) {
                    sh '''
                    export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_CREDENTIALS
                    terraform init
                    terraform apply -auto-approve
                    '''
                }
            }
        }
    }
}
