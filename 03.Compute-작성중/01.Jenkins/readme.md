# Jenkins 설치 및 Terraform 연동 방법

arn:aws:iam::239234376445:role/ec2-admin > arn:aws:iam::239234376445:role/mzc_solutions_architect
                                         > arn:aws:iam::333003622053:role/mzc_solutions_architect


# Jenkins 초기 패스워드 확인
# [root@ip-172-31-10-222 ~]# docker exec -it 7580a647e862 /bin/bash  # Jenkins container 내부로 접근 
# jenkins@7580a647e862:/$ cat /var/jenkins_home/secrets/initialAdminPassword  # 패스워드 확인

55c7cbf29a30459aa075d3dbd20a33ab

https://spacelift.io/blog/terraform-jenkins

6-7 사이 
plugin 설치하면 재기동되는데 이때 컨테이너가 중지됨


/var/jenkins_home/terraform_binary/terraform


```bash
pipeline {
    agent any
    
    environment {
        TF_WORKSPACE = 'prod'
    }
    parameters {
        choice(
            choices: ['plan', 'apply', 'show', 'preview-destroy', 'destroy'],
            description: 'Terraform action to apply',
            name: 'action')
        choice(
            choices: ['prod', 'net'],
            description: 'deployment environment at terraform workspaces',
            name: 'ENVIRONMENT')
    }
    
    stages {
        stage('Checkout') {
            steps {
                // 참고 URL: https://plugins.jenkins.io/git/
                // credential이 있으면 위 링크보고 설정
                checkout scmGit(
                    branches: [[name: 'master']],
                    userRemoteConfigs: [[url: 'https://github.com/blueice123/squid-proxy.git']])
            }
        }
        stage ('terraform init') { 
            steps {
                sh ('/var/jenkins_home/terraform_binary/terraform version')
                sh ('/var/jenkins_home/terraform_binary/terraform init -upgrade')
                // sh ('/var/jenkins_home/terraform_binary/terraform workspace new ${TF_WORKSPACE}' || true)
                // sh ('/var/jenkins_home/terraform_binary/terraform workspace seclect ${TF_WORKSPACE}')
                sh ('/var/jenkins_home/terraform_binary/terraform workspace list')
            }
        }
        stage ('terraform syntax validate') {
            steps {
                sh ('/var/jenkins_home/terraform_binary/terraform validate -no-color')
            }
        }
        stage ('terraform plan') {
            when {
                expression { params.action == 'plan' || params.action == 'apply' }
            }
            steps {
                sh ('/var/jenkins_home/terraform_binary/terraform -no-color -input=false -output-tfplan')
            }
        }
        stage('Approval') {
            when {
                expression { params.action == 'apply'}
            }
            steps {
                script {
                    sh ('/var/jenkins_home/terraform_binary/terraform show -no-color tfplan > tfplan.txt')
                    def plan = readFile 'tfplan.txt'
                    input message: "Apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
             }
        }
        stage ('terraform apply') {
            when {
                expression { params.action == 'apply' }
            }
            steps {
                sh ('/var/jenkins_home/terraform_binary/terraform apply -no-color -input=false tfplan')
            }
        }
        stage('show') {
            when {
                expression { params.action == 'show' }
            }
            steps {
                sh '/var/jenkins_home/terraform_binary/terraform show -no-color'
            }
        }
        stage('preview-destroy') {
            when {
                expression { params.action == 'preview-destroy' || params.action == 'destroy'}
            }
            steps {
                sh '/var/jenkins_home/terraform_binary/terraform plan -no-color -destroy -out=tfplan'
                sh '/var/jenkins_home/terraform_binary/terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('destroy') {
            when {
                expression { params.action == 'destroy' }
            }
            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Delete the stack?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
                sh '/var/jenkins_home/terraform_binary/terraform destroy -auto-approve'
            }
        }
    }
}
```