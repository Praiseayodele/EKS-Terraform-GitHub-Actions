properties([
    parameters([
        string(defaultValue: 'dev', name: 'Environment'),
        choice(choices: ['plan', 'apply', 'destroy'], name: 'Terraform_Action')
    ])
])

pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
    }

    stages {

        stage('Preparing') {
            steps {
                sh 'echo Preparing'
            }
        }

        stage('Git Pulling') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Praiseayodele/EKS-Terraform-GitHub-Actions.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh 'terraform -chdir=eks init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh 'terraform -chdir=eks validate'
                }
            }
        }

        stage('Terraform Action') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    script {
                        if (params.Terraform_Action == 'plan') {
                            sh "terraform -chdir=eks plan -var-file=${params.Environment}.tfvars"
                        } else if (params.Terraform_Action == 'apply') {
                            sh "terraform -chdir=eks apply -var-file=${params.Environment}.tfvars -auto-approve"
                        } else if (params.Terraform_Action == 'destroy') {
                            sh "terraform -chdir=eks destroy -var-file=${params.Environment}.tfvars -auto-approve"
                        }
                    }
                }
            }
        }
    }
}
