# Routing path 정의 
## 아래 문구는 console -> egress로 트래픽 전달 
## 여기에서는 상대측 cidr과 attachment를 정의함 
resource "aws_ec2_transit_gateway_route" "con_to_egr" {
  destination_cidr_block         = data.terraform_remote_state.nh-net-account-vpc.outputs.egr_vpc_cidr[0]
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.egress_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.console.id 
}

# ## 아래 문구는 console -> dx로 트래픽 전달 
# ## 여기에서는 상대측 cidr과 attachment를 정의함 
# resource "aws_ec2_transit_gateway_route" "sha_to_dx" {
#   destination_cidr_block         = data.terraform_remote_state.nh-net-account-vpc.outputs.ing_vpc_cidr[0]
#   transit_gateway_attachment_id  = DX Attachment (DX connection을 수동으로 만들고, 이 또한 수동으로 하드코딩 할 것..)
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.console.id 
# }

# Blackhole route 정의
# resource "aws_ec2_transit_gateway_route" "example_blackhole" {
#   destination_cidr_block         = "0.0.0.0/0"
#   blackhole                      = true
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id
# }


## Route table 생성 
resource "aws_ec2_transit_gateway_route_table" "console" {
  transit_gateway_id = module.tgw.ec2_transit_gateway_id
  tags = {
    Name = "nh-tgw-con-rt"
  }
}

## TGW Attachment와 Route table을 연결하고 IP를 전파 
## 여기에서는 자기 자신의 attachment를 정의함
resource "aws_ec2_transit_gateway_route_table_association" "console" {
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.console_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.console.id
}
resource "aws_ec2_transit_gateway_route_table_propagation" "console" {
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment.console_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.console.id
}
