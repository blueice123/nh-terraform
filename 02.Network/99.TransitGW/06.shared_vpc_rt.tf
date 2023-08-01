# 참고 내용
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route.html

##########################################################################
# Private subnet VPC 라우팅 테이블
##########################################################################
resource "aws_route" "sha_vpc_private_to_tgw_1" {
  depends_on                  = [module.tgw]
  count                       = length(data.terraform_remote_state.nh-net-account-vpc.outputs.sha_vpc_private_rt)
    
  route_table_id              = data.terraform_remote_state.nh-net-account-vpc.outputs.sha_vpc_private_rt[count.index] 
  destination_cidr_block      = "10.0.0.0/8"
  transit_gateway_id          =  module.tgw.ec2_transit_gateway_id # transit_gateway_id | vpc_endpoint_id | network_interface_id | vpc_peering_connection_id
}
resource "aws_route" "sha_vpc_private_to_tgw_2" {
  depends_on                  = [module.tgw]
  count                       = length(data.terraform_remote_state.nh-net-account-vpc.outputs.sha_vpc_private_rt)
    
  route_table_id              = data.terraform_remote_state.nh-net-account-vpc.outputs.sha_vpc_private_rt[count.index] 
  destination_cidr_block      = "172.16.0.0/12"
  transit_gateway_id          =  module.tgw.ec2_transit_gateway_id # transit_gateway_id | vpc_endpoint_id | network_interface_id | vpc_peering_connection_id
}
resource "aws_route" "sha_vpc_private_to_tgw_3" {
  depends_on                  = [module.tgw]
  count                       = length(data.terraform_remote_state.nh-net-account-vpc.outputs.sha_vpc_private_rt)
    
  route_table_id              = data.terraform_remote_state.nh-net-account-vpc.outputs.sha_vpc_private_rt[count.index] 
  destination_cidr_block      = "192.168.0.0/16"
  transit_gateway_id          =  module.tgw.ec2_transit_gateway_id # transit_gateway_id | vpc_endpoint_id | network_interface_id | vpc_peering_connection_id
}
