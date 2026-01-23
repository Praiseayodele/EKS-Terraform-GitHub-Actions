properties([
    parameters([
        string(
            defaultValue: 'dev',
            name: 'Environment'
        ),
        choice(
            choices: ['plan', 'apply', 'destroy'], 
            name: 'Terraform_Action'
        )
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
                    sh '''
                      docker run --rm \
                        -v $PWD:/workspace \
                        -w /workspace/eks \
                        hashicorp/terraform:1.14.3 \
                        terraform init
                    '''
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh '''
                      docker run --rm \
                        -v $PWD:/workspace \
                        -w /workspace/eks \
                        hashicorp/terraform:1.14.3 \
                        terraform validate
                    '''
                }
            }
        }

        stage('Terraform Action') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    script {
                        if (params.Terraform_Action == 'plan') {
                            sh '''
                              docker run --rm \
                                -v $PWD:/workspace \
                                -w /workspace/eks \
                                hashicorp/terraform:1.14.3 \
                                terraform plan -var-file=${Environment}.tfvars
                            '''
                        } else if (params.Terraform_Action == 'apply') {
                            sh '''
                              docker run --rm \
                                -v $PWD:/workspace \
                                -w /workspace/eks \
                                hashicorp/terraform:1.14.3 \
                                terraform apply -var-file=${Environment}.tfvars -auto-approve
                            '''
                        } else if (params.Terraform_Action == 'destroy') {
                            sh '''
                              docker run --rm \
                                -v $PWD:/workspace \
                                -w /workspace/eks \
                                hashicorp/terraform:1.14.3 \
                                terraform destroy -var-file=${Environment}.tfvars -auto-approve
                            '''
                        }
                    }
                }
            }
        }
    }
}
