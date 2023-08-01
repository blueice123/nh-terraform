# resource "aws_ram_resource_share" "ing_public" {
#     count = length(module.ingress_vpc.public_subnets_tags_all) 

#     name                      = module.ingress_vpc.public_subnets_tags_all[count.index][0]["Name"]
#     allow_external_principals = true

#     tags = {
#         Name = module.ingress_vpc.public_subnets_tags_all[count.index][0]["Name"]
#     }
# }

# resource "aws_ram_resource_association" "ing_public" {
#     count = length(module.ingress_vpc.public_subnets_tags_all) 
    
#     resource_arn       = module.ingress_vpc.public_subnet_arns[count.index] # aws_subnet.example.arn
#     resource_share_arn = aws_ram_resource_share.ing_public[count.index].arn
# }

# # resource "aws_ram_principal_association" "ing_public" {
# #   count = length(module.ingress_vpc.public_subnets.*)

# #   principal          = var.aws_account["sec"]
# #   resource_share_arn = aws_ram_resource_share.ing_public[count.index].arn
# # }



# # resource "aws_ram_resource_association" "this" {
# #   count = var.create_tgw && var.share_tgw ? 1 : 0

# #   resource_arn       = aws_ec2_transit_gateway.this[0].arn
# #   resource_share_arn = aws_ram_resource_share.this[0].id
# # }

# # resource "aws_ram_principal_association" "this" {
# #   count = var.create_tgw && var.share_tgw ? length(var.ram_principals) : 0

# #   principal          = var.ram_principals[count.index]
# #   resource_share_arn = aws_ram_resource_share.this[0].arn
# # }

# # resource "aws_ram_resource_share_accepter" "this" {
# #   count = !var.create_tgw && var.share_tgw ? 1 : 0

# #   share_arn = var.ram_resource_share_arn
# # }
