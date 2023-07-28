terraform {
    backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "megazone-terraform"
    dynamodb_table = "megazone-terraform"
    key            = "nh-net-account-tgw.tfstate"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

data "terraform_remote_state" "nh-net-account-vpc" {
  backend = "s3"
  config = {
    region = "ap-northeast-2"
    bucket = "megazone-terraform"
    key    = "env:/net/nh-net-account-vpc.tfstate"
  }
}

