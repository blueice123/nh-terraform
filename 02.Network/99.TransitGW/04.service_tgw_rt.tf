# Routing path 정의 
## 아래 문구는 service -> ingress로 트래픽 전달 
## 여기에서는 상대측 cidr과 attachment를 정의함 
resource "aws_ec2_transit_gateway_route" "svc_to_ing" {
  destination_cidr_block         = data.terraform_remote_state.nh-net-account-vpc.outputs.ing_vpc_cidr[0]
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.ingress_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.service.id
}

## 아래 문구는 service -> shared로 트래픽 전달 
## 여기에서는 상대측 cidr과 attachment를 정의함 
resource "aws_ec2_transit_gateway_route" "svc_to_sha" {
  destination_cidr_block         = data.terraform_remote_state.nh-net-account-vpc.outputs.sha_vpc_cidr[0]
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.shared_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.service.id
}

## 아래 문구는 service -> egress 트래픽 전달 
## 여기에서는 상대측 cidr과 attachment를 정의함 
resource "aws_ec2_transit_gateway_route" "svc_to_egr" {
  destination_cidr_block         = data.terraform_remote_state.nh-net-account-vpc.outputs.egr_vpc_cidr[0]
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.egress_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.service.id
}


# Blackhole route 정의
# resource "aws_ec2_transit_gateway_route" "example_blackhole" {
#   destination_cidr_block         = "0.0.0.0/0"
#   blackhole                      = true
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id
# }


## Route table 생성 
resource "aws_ec2_transit_gateway_route_table" "service" {
  transit_gateway_id = module.tgw.ec2_transit_gateway_id
  tags = {
    Name = "nh-tgw-svc-rt"
  }
}

## TGW Attachment와 Route table을 연결하고 IP를 전파 
## 여기에서는 자기 자신의 attachment를 정의함
resource "aws_ec2_transit_gateway_route_table_association" "service" {
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.service_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.service.id
}
resource "aws_ec2_transit_gateway_route_table_propagation" "service" {
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.service_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.service.id
}
