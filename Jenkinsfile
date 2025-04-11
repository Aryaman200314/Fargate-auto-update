pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/master']],
                    extensions: [],
                    userRemoteConfigs: [[
                        credentialsId: 'gitpass',
                        url: 'https://github.com/Aryaman200314/Fargate-auto-update.git'
                    ]]
                )
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                sh '''
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 711070167349.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t fargate .
                    docker tag fargate:latest 711070167349.dkr.ecr.us-east-1.amazonaws.com/fargate:latest
                    docker push 711070167349.dkr.ecr.us-east-1.amazonaws.com/fargate:latest
                '''
            }
        }
    }
}