# resource "aws_route" "r" {
#   # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route.html
#   count                       = module.ingress_vpc.loadbalancer_route_table_ids.*
  
#   route_table_id              = module.ingress_vpc.loadbalancer_route_table_ids.[count.index]
#   destination_cidr_block      = "10.11.0.0/28"
#   vpc_endpoint_id             =  # transit_gateway_id | vpc_endpoint_id | network_interface_id | vpc_peering_connection_id

# }