terraform {
    backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "megazone-terraform"
    dynamodb_table = "megazone-terraform"
    key            = "nh-net-account-vpc.tfstate"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

data "terraform_remote_state" "logs" {  ## logs 계정에 배포된 리소스를 읽어들이기 위해 
    backend = "s3"
    config = {
        region = "ap-northeast-2"
        bucket = "megazone-terraform"
        key    = "env:/logs/nh-logs-account-s3.tfstate"
    }
}