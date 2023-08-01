module "tgw" {
  source  = "../../00.Modules/transit-gateway/"
  # version = "~> 2.0"

  name        = "nh-net-tgw"
  description = "nh-net-tgw"

  enable_auto_accept_shared_attachments = true
  amazon_side_asn                       = 64532

  vpc_attachments = {
    ingress_vpc = { 
      ### vpc_attachment의 경우 리스트로 저장되기에 ingress_vpc_att를 찾으려면 
      ### module.tgw.ec2_transit_gateway_vpc_attachment.ingress_att.id
      name                    = "ingress_att"
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
      name                    = "egress_att"
      tgw_id                  = module.tgw.ec2_transit_gateway_id
      vpc_id                  = data.terraform_remote_state.nh-net-account-vpc.outputs.egr_vpc_id[0]
      subnet_ids              = data.terraform_remote_state.nh-net-account-vpc.outputs.egr_endpoint_subnets
      dns_support             = true
      ipv6_support            = false
      enable_vpn_ecmp_support = true

      tgw_vpc_attachment_tags = "nh-net-tgw-egr"

      transit_gateway_default_route_table_association = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
      transit_gateway_default_route_table_propagation = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
    }

    service_vpc = {
      name                    = "service_att"
      tgw_id                  = module.tgw.ec2_transit_gateway_id
      vpc_id                  = data.terraform_remote_state.nh-net-account-vpc.outputs.svc_vpc_id[0]
      subnet_ids              = data.terraform_remote_state.nh-net-account-vpc.outputs.svc_endpoint_subnets
      dns_support             = true
      ipv6_support            = false
      enable_vpn_ecmp_support = true

      tgw_vpc_attachment_tags = "nh-net-tgw-svc"

      transit_gateway_default_route_table_association = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
      transit_gateway_default_route_table_propagation = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
    }

    security_vpc = {
      name                    = "security_att"
      tgw_id                  = module.tgw.ec2_transit_gateway_id
      vpc_id                  = data.terraform_remote_state.nh-net-account-vpc.outputs.sec_vpc_id[0]
      subnet_ids              = data.terraform_remote_state.nh-net-account-vpc.outputs.sec_endpoint_subnets
      dns_support             = true
      ipv6_support            = false
      enable_vpn_ecmp_support = true

      tgw_vpc_attachment_tags = "nh-net-tgw-sec"

      transit_gateway_default_route_table_association = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
      transit_gateway_default_route_table_propagation = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
    }

    shared_vpc = {
      name                    = "shared_att"
      tgw_id                  = module.tgw.ec2_transit_gateway_id
      vpc_id                  = data.terraform_remote_state.nh-net-account-vpc.outputs.sha_vpc_id[0]
      subnet_ids              = data.terraform_remote_state.nh-net-account-vpc.outputs.sha_endpoint_subnets
      dns_support             = true
      ipv6_support            = false
      enable_vpn_ecmp_support = true

      tgw_vpc_attachment_tags = "nh-net-tgw-sha"

      transit_gateway_default_route_table_association = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
      transit_gateway_default_route_table_propagation = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
    }

    console_vpc = {
      name                    = "console_att"
      tgw_id                  = module.tgw.ec2_transit_gateway_id
      vpc_id                  = data.terraform_remote_state.nh-net-account-vpc.outputs.con_vpc_id[0]
      subnet_ids              = data.terraform_remote_state.nh-net-account-vpc.outputs.con_endpoint_subnets
      dns_support             = true
      ipv6_support            = false
      enable_vpn_ecmp_support = true

      tgw_vpc_attachment_tags = "nh-net-tgw-con"

      transit_gateway_default_route_table_association = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
      transit_gateway_default_route_table_propagation = false # Default RT에 속하지 않게 함으로서 별도 RT 생성
    }
  }
  
  ram_allow_external_principals = false
  # ram_principals = [var.aws_account["prd"]] # [333003622053] # 공유할 계정 정의 상대측에서 수동으로 수락해주어야 함, 혹시나 Tanze 계정에서 VPC를 생성할 경우 TGW share를 통해 구성하여야 함

  tags = {
    Environment = "net"
  }
}