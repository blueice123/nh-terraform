# Infrastructure 배포를 위해 남겨둔다. 

## 필수 AWS Account 
 1. Management account - @megazone.com 계정 
 2. Audit account - 고객 계정 
 3. Logs account  - 고객 계정 
    * 반드시 Control Tower를 배포해 놓을것 (그래야 CloudTrail, GuardDuty 설정이 편하며 불필요한 코드를 만들 피룡가 없음)
 4. Network account - 고객 계정 
    * 네트워크 VPC, TGW, DX를 관장하는 계정
 5. Shared account - 고객 계정
    * jenkins(CI/CD), IPS MGMT 등 공용 시스템의 리소스가 위치하는 계정 
 6. Security account - 고객 계정
    * IPS, Wapples, squid proxy 리소스가 설치되는 계정 
 7. Product account - 고객 계정
    * VMware Tanzu가 구성되는 계정 


## 배포에 앞서 git repo 전략 
 - terraform workspace 이름과 Branch 이름을 맞출 것
 - 각 디렉토리는 1개의 repo로 볼 것 
 - 모듈은 jenkins 빌드 시에 내려 받을 것 


## 배포 순서 
1. logs 배포 
 - VPC Flowlogs를 받아주기 위해서 필요함 

