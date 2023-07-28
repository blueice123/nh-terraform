# Infrastructure 배포를 위해 남겨둔다. 

## 필수 AWS Account 
 1. management account - @megazone.com 계정 
 2. audit account - 고객 계정 
 3. logs account  - 고객 계정 
    * 반드시 Control Tower를 배포해 놓을것 (그래야 CloudTrail, GuardDuty 설정이 편하며 불필요한 코드를 만들 피룡가 없음)


## 배포에 앞서 git repo 전략 
 - terraform workspace 이름과 Branch 이름을 맞출 것
 - 각 디렉토리는 1개의 repo로 볼 것 
 - 모듈은 jenkins 빌드 시에 내려 받을 것 


## 배포 순서 
1. logs 배포 
 - VPC Flowlogs를 받아주기 위해서 필요함 

