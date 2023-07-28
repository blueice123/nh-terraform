module "tgw" {
  source  = "../../00.Modules/transit-gateway/"
  # version = "~> 2.0"

  name        = "nh-net-tgw"
  description = "My TGW shared with several other AWS accounts"

  enable_auto_accept_shared_attachments = true
  amazon_side_asn                       = 64532

  vpc_attachments = {
    ingress_vpc = {
      name                    = "ingress_vpc"
      tgw_id                  = module.tgw.ec2_transit_gateway_id
      vpc_id                  = data.terraform_remote_state.nh-net-account-vpc.outputs.ing_vpc_id[0]
      subnet_ids              = data.terraform_remote_state.nh-net-account-vpc.outputs.ing_endpoint_subnets
      dns_support             = true
      ipv6_support            = false
      enable_vpn_ecmp_support = true
      tgw_vpc_attachment_tags = "nh-net-tgw-ing"

      transit_gateway_default_route_table_association = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
      transit_gateway_default_route_table_propagation = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
    }

    egress_vpc = {
      name                    = "egress_vpc"
      tgw_id                  = module.tgw.ec2_transit_gateway_id
      vpc_id                  = data.terraform_remote_state.nh-net-account-vpc.outputs.eg_vpc_id[0]
      subnet_ids              = data.terraform_remote_state.nh-net-account-vpc.outputs.eg_endpoint_subnets
      dns_support             = true
      ipv6_support            = false
      enable_vpn_ecmp_support = true

      tgw_vpc_attachment_tags = "nh-net-tgw-egr"

      transit_gateway_default_route_table_association = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
      transit_gateway_default_route_table_propagation = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
    }
  }

  # ram_allow_external_principals = true
  # ram_principals = [333003622053] # 공유할 계정 정의하며, 상대측에서 수동으로 수락해주어야 함 

  tags = {
    Environment = "net"
  }
}