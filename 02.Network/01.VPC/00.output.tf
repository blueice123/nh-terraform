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
output "ing_vpc_private_rt" {
  value = module.ingress_vpc.private_route_table_ids.*
}
output "ing_vpc_endpoint_rt" {
  value = module.ingress_vpc.endpoint_route_table_ids.*
}
output "ing_vpc_gwlb_rt" {
  value = module.ingress_vpc.gwlb_route_table_ids.*
}
output "ing_vpc_lb_rt" {
  value = module.ingress_vpc.loadbalancer_route_table_ids.*
}
output "ing_vpc_public_rt" {
  value = module.ingress_vpc.public_route_table_ids.*
}


## Egress VPC 관련 정보
output "egr_endpoint_subnets" {
  value       = module.egress_vpc.endpoint_subnets.*
}
output "egr_vpc_id" {
  value       = module.egress_vpc.vpc_id.*
}
output "egr_vpc_cidr" {
  value       = module.egress_vpc.vpc_cidr_block.*
}
output "egr_nat_ip" {
  value       = module.egress_vpc.nat_public_ips.*
}
output "egr_vpc_private_rt" {
  value = module.egress_vpc.private_route_table_ids.*
}
output "egr_vpc_endpoint_rt" {
  value = module.egress_vpc.endpoint_route_table_ids.*
}
output "egr_vpc_gwlb_rt" {
  value = module.egress_vpc.gwlb_route_table_ids.*
}
output "egr_vpc_lb_rt" {
  value = module.egress_vpc.loadbalancer_route_table_ids.*
}
output "egr_vpc_public_rt" {
  value = module.egress_vpc.public_route_table_ids.*
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
output "svc_vpc_private_rt" {
  value = module.service_vpc.private_route_table_ids.*
}
output "svc_vpc_endpoint_rt" {
  value = module.service_vpc.endpoint_route_table_ids.*
}
output "svc_vpc_gwlb_rt" {
  value = module.service_vpc.gwlb_route_table_ids.*
}
output "svc_vpc_lb_rt" {
  value = module.service_vpc.loadbalancer_route_table_ids.*
}
output "svc_vpc_public_rt" {
  value = module.service_vpc.public_route_table_ids.*
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
output "sec_vpc_private_rt" {
  value = module.security_vpc.private_route_table_ids.*
}
output "sec_vpc_endpoint_rt" {
  value = module.security_vpc.endpoint_route_table_ids.*
}
output "sec_vpc_gwlb_rt" {
  value = module.security_vpc.gwlb_route_table_ids.*
}
output "sec_vpc_lb_rt" {
  value = module.security_vpc.loadbalancer_route_table_ids.*
}
output "sec_vpc_public_rt" {
  value = module.security_vpc.public_route_table_ids.*
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
output "sha_vpc_private_rt" {
  value = module.shared_vpc.private_route_table_ids.*
}



## Consol VPC 관련 정보 
output "con_endpoint_subnets" {
  value       = module.egress_console.endpoint_subnets.*
}
output "con_vpc_id" {
  value       = module.egress_console.vpc_id.*
}
output "con_vpc_cidr" {
  value       = module.egress_console.vpc_cidr_block.*
}
output "con_vpc_private_rt" {
  value = module.egress_console.private_route_table_ids.*
}
output "con_vpc_endpoint_rt" {
  value = module.egress_console.endpoint_route_table_ids.*
}