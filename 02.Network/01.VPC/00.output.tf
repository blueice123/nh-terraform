## Ingress VPC 관련 정보
output "ing_endpoint_subnets" {
  value       = module.ingress_vpc.endpoint_subnets.*
}
output "ing_vpc_id" {
  value       = module.ingress_vpc.vpc_id.*
}
output "ing_vpc_cidr" {
  value       = module.ingress_vpc.vpc_cidr_block.*
}


## Egress VPC 관련 정보
output "eg_endpoint_subnets" {
  value       = module.egress_vpc.endpoint_subnets.*
}
output "eg_vpc_id" {
  value       = module.egress_vpc.vpc_id.*
}
output "eg_vpc_cidr" {
  value       = module.egress_vpc.vpc_cidr_block.*
}
output "eg_nat_ip" {
  value       = module.egress_vpc.nat_public_ips.*
}


## Service VPC 관련 정보 
output "svc_endpoint_subnets" {
  value       = module.service_vpc.endpoint_subnets.*
}
output "svc_vpc_id" {
  value       = module.service_vpc.vpc_id.*
}
output "svc_vpc_cidr" {
  value       = module.service_vpc.vpc_cidr_block.*
}


## Security VPC 관련 정보 
output "sec_endpoint_subnets" {
  value       = module.security_vpc.endpoint_subnets.*
}
output "sec_vpc_id" {
  value       = module.security_vpc.vpc_id.*
}
output "sec_vpc_cidr" {
  value       = module.security_vpc.vpc_cidr_block.*
}

## Shared VPC 관련 정보 
output "sha_endpoint_subnets" {
  value       = module.shared_vpc.endpoint_subnets.*
}
output "sha_vpc_id" {
  value       = module.shared_vpc.vpc_id.*
}
output "sha_vpc_cidr" {
  value       = module.shared_vpc.vpc_cidr_block.*
}