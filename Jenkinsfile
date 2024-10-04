pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws_access', region: "${AWS_REGION}") {
                    dir('terraform') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws_access', region: "${AWS_REGION}") {
                    dir('terraform') {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Get EC2 Instance IP') {
            steps {
                script {
                    env.INSTANCE_IP = sh(script: "terraform output -raw ec2_private_ip", returnStdout: true).trim()
                }
            }
        }

        stage('Create Text File on EC2 Instance') {
            steps {
                script {
                    def command = "echo 'Hello, World!' > /home/ec2-user/hello.txt"
                    sshagent(['ec2-ssh-access-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@${env.INSTANCE_IP} '${command}'"
                    }
                }
            }
        }
    }
}