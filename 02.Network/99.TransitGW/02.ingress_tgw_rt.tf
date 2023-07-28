# Routing path 정의 
## 아래 예시 문구는 10.0.1.0/24를 ingress -> egress로 
resource "aws_ec2_transit_gateway_route" "example_normal" {
  destination_cidr_block         = "1.1.1.1/32"
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment_ids[1]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id #aws_ec2_transit_gateway.example.association_default_route_table_id
}

# Blackhole route 정의
resource "aws_ec2_transit_gateway_route" "example_blackhole" {
  destination_cidr_block         = "0.0.0.0/0"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id #aws_ec2_transit_gateway.example.association_default_route_table_id
}


## Route table 생성 
resource "aws_ec2_transit_gateway_route_table" "ingress" {
  transit_gateway_id = module.tgw.ec2_transit_gateway_id
  tags = {
    Name = "nh-tgw-ing-rt"
  }
}

## TGW Attachment와 Route table을 연결하고 IP를 전파 
resource "aws_ec2_transit_gateway_route_table_association" "ingress" {
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment_ids[0] #aws_ec2_transit_gateway_vpc_attachment.ingress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id
}
resource "aws_ec2_transit_gateway_route_table_propagation" "ingress" {
  transit_gateway_attachment_id  = module.tgw.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id
}
