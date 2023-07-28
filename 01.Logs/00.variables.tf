variable "REGION" {
    default = "ap-northeast-2"
}

variable "ACCOUNT" {
    ## 내 로컬PC에 저장된 CTC AWS 계정의 IAM AccessKey profile 이름을 명시
    ## mine profile은 script/aws-token.sh 스크립트 실행을 통해 MFA에 인증한 임시 토큰 값
    default = "mine"
}

## 각 계정들 A#로 S3 Policy에 기록됨 
variable "aws_account" {
    type = map(string)
    default = {
        prd             = "138511064004" # 정찬명 님
        mgmt            = "214269918705" # 김현민 님
        logs            = "333003622053" # 이주형 님
        shared          = "140646465574" # 강병욱 님
        sec             = "968653168360" # 박재현 님
        net             = "239234376445" # 하수용 님
        audit           = "709680035562" # 유정훈 님 
    }
}

## Logs 저장소 환경 변수 
variable "s3_vpc_flow_logs" {
    type = map(string)
    default = {
        name                              = "nh-flow-logs-230728"
        expire_days                       = "1825"
        transition_to_INTELLIGENT_TIERING = "29"
    }
}
variable "s3_cloudtrail_logs" {
    type = map(string)
    default = {
        name                              = "nh-trail-logs-230728"
        expire_days                       = "1825"
        transition_to_INTELLIGENT_TIERING = "29"
    }
}