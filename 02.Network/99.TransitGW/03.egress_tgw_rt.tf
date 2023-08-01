# Routing path 정의 
## 아래 문구는 egress -> service로 트래픽 전달 
## 여기에서는 상대측 cidr과 attachment를 정의함
resource "aws_ec2_transit_gateway_route" "egr_to_svc" {
  destination_cidr_block         = data.terraform_remote_state.nh-net-account-vpc.outputs.svc_vpc_cidr[0]
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.service_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress.id
}

## 아래 문구는 egress -> shared로 트래픽 전달 
## 여기에서는 상대측 cidr과 attachment를 정의함
resource "aws_ec2_transit_gateway_route" "egr_to_sha" {
  destination_cidr_block         = data.terraform_remote_state.nh-net-account-vpc.outputs.sha_vpc_cidr[0]
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.shared_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress.id
}

## 아래 문구는 egress -> console로 트래픽 전달 
## 여기에서는 상대측 cidr과 attachment를 정의함
resource "aws_ec2_transit_gateway_route" "egr_to_con" {
  destination_cidr_block         = data.terraform_remote_state.nh-net-account-vpc.outputs.con_vpc_cidr[0]
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.console_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress.id
}



# 혹시 Blackhole route 정의한다면 이런 방식으로.. 
# resource "aws_ec2_transit_gateway_route" "example_blackhole" {
#   destination_cidr_block         = "0.0.0.0/0"
#   blackhole                      = true
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id
# }


## Route table 생성 
resource "aws_ec2_transit_gateway_route_table" "egress" {
  transit_gateway_id = module.tgw.ec2_transit_gateway_id
  tags = {
    Name = "nh-tgw-eng-rt"
  }
}

## TGW Attachment와 Route table을 연결하고 IP를 전파 
## 여기에서는 자기 자신의 attachment를 정의함
resource "aws_ec2_transit_gateway_route_table_association" "egress" {
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.egress_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress.id
}
resource "aws_ec2_transit_gateway_route_table_propagation" "egress" {
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.egress_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress.id
}
