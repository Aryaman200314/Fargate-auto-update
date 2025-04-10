pipeline {
    agent {label 'Jobs'}

    stages {
        stage('Checkout Code') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/master']],
                    extensions: [],
                    userRemoteConfigs: [[
                        credentialsId: 'gitpass',
                        url: 'git@github.com:Aryaman200314/Private-EKS-code.git'
                    ]]
                )
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                sh '''
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 711070167349.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t eks .
                    docker tag eks:latest 711070167349.dkr.ecr.us-east-1.amazonaws.com/eks:latest
                    docker push 711070167349.dkr.ecr.us-east-1.amazonaws.com/eks:latest
                '''
            }
        }
    }
}