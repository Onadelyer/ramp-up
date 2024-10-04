pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
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

        // stage('Get EC2 Instance IP') {
        //     steps {
        //         script {
        //             def instanceId = sh(script: "terraform output -raw instance_id", returnStdout: true).trim()
        //             env.INSTANCE_IP = sh(script: "aws ec2 describe-instances --instance-ids ${instanceId} --query 'Reservations[0].Instances[0].PublicIpAddress' --output text", returnStdout: true).trim()
        //         }
        //     }
        // }

        // stage('Create Text File on EC2 Instance') {
        //     steps {
        //         script {
        //             def command = "echo 'Hello, World!' > /home/ec2-user/hello.txt"
        //             sh "ssh -o StrictHostKeyChecking=no -i /path/to/your/private-key.pem ec2-user@${env.INSTANCE_IP} '${command}'"
        //         }
        //     }
        // }
    }
}