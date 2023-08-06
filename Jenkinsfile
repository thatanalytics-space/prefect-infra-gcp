pipeline {
    agent {
        docker {
            image 'australia-southeast1-docker.pkg.dev/prefect-395009/jenkins-agent/agent:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock' // Mount the Docker socket if needed
        }
    }
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

                