################################################################################
# loadbalancer Subnets
################################################################################

output "loadbalancer_subnets" {
  description = "List of IDs of loadbalancer subnets"
  value       = aws_subnet.loadbalancer[*].id
}

output "loadbalancer_subnets_tags_all" { ## 태그 값 추가 
  description = "List of cidr_blocks of loadbalancer subnets"
  value       = aws_subnet.loadbalancer[*].tags_all[*]
}

output "loadbalancer_subnet_arns" {
  description = "List of ARNs of loadbalancer subnets"
  value       = aws_subnet.loadbalancer[*].arn
}

output "loadbalancer_subnets_cidr_blocks" {
  description = "List of cidr_blocks of loadbalancer subnets"
  value       = compact(aws_subnet.loadbalancer[*].cidr_block)
}

output "loadbalancer_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of loadbalancer subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.loadbalancer[*].ipv6_cidr_block)
}

# output "loadbalancer_subnet_group" {
#   description = "ID of loadbalancer subnet group"
#   value       = try(aws_db_subnet_group.loadbalancer[0].id, null)
# }

# output "loadbalancer_subnet_group_name" {
#   description = "Name of loadbalancer subnet group"
#   value       = try(aws_db_subnet_group.loadbalancer[0].name, null)
# }

output "loadbalancer_route_table_ids" {
  description = "List of IDs of loadbalancer route tables"
  value       = try(coalescelist(aws_route_table.loadbalancer[*].id, local.private_route_table_ids), [])
}

output "loadbalancer_internet_gateway_route_id" {
  description = "ID of the loadbalancer internet gateway route"
  value       = try(aws_route.loadbalancer_internet_gateway[0].id, null)
}

output "loadbalancer_nat_gateway_route_ids" {
  description = "List of IDs of the loadbalancer nat gateway route"
  value       = aws_route.loadbalancer_nat_gateway[*].id
}

output "loadbalancer_ipv6_egress_route_id" {
  description = "ID of the loadbalancer IPv6 egress route"
  value       = try(aws_route.loadbalancer_ipv6_egress[0].id, null)
}

output "loadbalancer_route_table_association_ids" {
  description = "List of IDs of the loadbalancer route table association"
  value       = aws_route_table_association.loadbalancer[*].id
}

output "loadbalancer_network_acl_id" {
  description = "ID of the loadbalancer network ACL"
  value       = try(aws_network_acl.loadbalancer[0].id, null)
}

output "loadbalancer_network_acl_arn" {
  description = "ARN of the loadbalancer network ACL"
  value       = try(aws_network_acl.loadbalancer[0].arn, null)
}

################################################################################
# loadbalancer Subnets
################################################################################

variable "loadbalancer_subnets" {
  description = "A list of loadbalancer subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "loadbalancer_subnet_assign_ipv6_address_on_creation" {
  description = "Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is `false`"
  type        = bool
  default     = false
}

variable "loadbalancer_subnet_enable_dns64" {
  description = "Indicates whether DNS queries made to the Amazon-provided DNS Resolver in this subnet should return synthetic IPv6 addresses for IPv4-only destinations. Default: `true`"
  type        = bool
  default     = true
}

variable "loadbalancer_subnet_enable_resource_name_dns_aaaa_record_on_launch" {
  description = "Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. Default: `true`"
  type        = bool
  default     = true
}

variable "loadbalancer_subnet_enable_resource_name_dns_a_record_on_launch" {
  description = "Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default: `false`"
  type        = bool
  default     = false
}

variable "loadbalancer_subnet_ipv6_prefixes" {
  description = "Assigns IPv6 loadbalancer subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
  type        = list(string)
  default     = []
}

variable "loadbalancer_subnet_ipv6_native" {
  description = "Indicates whether to create an IPv6-only subnet. Default: `false`"
  type        = bool
  default     = false
}

variable "loadbalancer_subnet_private_dns_hostname_type_on_launch" {
  description = "The type of hostnames to assign to instances in the subnet at launch. For IPv6-only subnets, an instance DNS name must be based on the instance ID. For dual-stack and IPv4-only subnets, you can specify whether DNS names use the instance IPv4 address or the instance ID. Valid values: `ip-name`, `resource-name`"
  type        = string
  default     = null
}

variable "loadbalancer_subnet_names" {
  description = "Explicit values to use in the Name tag on loadbalancer subnets. If empty, Name tags are generated"
  type        = list(string)
  default     = []
}

variable "loadbalancer_subnet_suffix" {
  description = "Suffix to append to loadbalancer subnets name"
  type        = string
  default     = "lb"
}

variable "create_loadbalancer_subnet_route_table" {
  description = "Controls if separate route table for loadbalancer should be created"
  type        = bool
  default     = false
}

variable "create_loadbalancer_internet_gateway_route" {
  description = "Controls if an internet gateway route for public loadbalancer access should be created"
  type        = bool
  default     = false
}

variable "create_loadbalancer_nat_gateway_route" {
  description = "Controls if a nat gateway route should be created to give internet access to the loadbalancer subnets"
  type        = bool
  default     = false
}

variable "loadbalancer_route_table_tags" {
  description = "Additional tags for the loadbalancer route tables"
  type        = map(string)
  default     = {}
}

variable "loadbalancer_subnet_tags" {
  description = "Additional tags for the loadbalancer subnets"
  type        = map(string)
  default     = {}
}

# variable "create_loadbalancer_subnet_group" {
#   description = "Controls if loadbalancer subnet group should be created (n.b. loadbalancer_subnets must also be set)"
#   type        = bool
#   default     = true
# }

# variable "loadbalancer_subnet_group_name" {
#   description = "Name of loadbalancer subnet group"
#   type        = string
#   default     = null
# }

# variable "loadbalancer_subnet_group_tags" {
#   description = "Additional tags for the loadbalancer subnet group"
#   type        = map(string)
#   default     = {}
# }

################################################################################
# loadbalancer Network ACLs
################################################################################

variable "loadbalancer_dedicated_network_acl" {
  description = "Whether to use dedicated network ACL (not default) and custom rules for loadbalancer subnets"
  type        = bool
  default     = false
}

variable "loadbalancer_inbound_acl_rules" {
  description = "loadbalancer subnets inbound network ACL rules"
  type        = list(map(string))
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "loadbalancer_outbound_acl_rules" {
  description = "loadbalancer subnets outbound network ACL rules"
  type        = list(map(string))
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "loadbalancer_acl_tags" {
  description = "Additional tags for the loadbalancer subnets network ACL"
  type        = map(string)
  default     = {}
}

################################################################################
# loadbalancer Subnets
################################################################################

locals {
  create_loadbalancer_subnets     = local.create_vpc && local.len_loadbalancer_subnets > 0
  create_loadbalancer_route_table = local.create_loadbalancer_subnets && var.create_loadbalancer_subnet_route_table
}

resource "aws_subnet" "loadbalancer" {
  count = local.create_loadbalancer_subnets ? local.len_loadbalancer_subnets : 0

  assign_ipv6_address_on_creation                = var.enable_ipv6 && var.loadbalancer_subnet_ipv6_native ? true : var.loadbalancer_subnet_assign_ipv6_address_on_creation
  availability_zone                              = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id                           = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  cidr_block                                     = var.loadbalancer_subnet_ipv6_native ? null : element(concat(var.loadbalancer_subnets, [""]), count.index)
  enable_dns64                                   = var.enable_ipv6 && var.loadbalancer_subnet_enable_dns64
  enable_resource_name_dns_aaaa_record_on_launch = var.enable_ipv6 && var.loadbalancer_subnet_enable_resource_name_dns_aaaa_record_on_launch
  enable_resource_name_dns_a_record_on_launch    = !var.loadbalancer_subnet_ipv6_native && var.loadbalancer_subnet_enable_resource_name_dns_a_record_on_launch
  ipv6_cidr_block                                = var.enable_ipv6 && length(var.loadbalancer_subnet_ipv6_prefixes) > 0 ? cidrsubnet(aws_vpc.this[0].ipv6_cidr_block, 8, var.loadbalancer_subnet_ipv6_prefixes[count.index]) : null
  ipv6_native                                    = var.enable_ipv6 && var.loadbalancer_subnet_ipv6_native
  private_dns_hostname_type_on_launch            = var.loadbalancer_subnet_private_dns_hostname_type_on_launch
  vpc_id                                         = local.vpc_id

  tags = merge(
    {
      Name = try(
        var.loadbalancer_subnet_names[count.index],
        # format("${var.name}-${var.loadbalancer_subnet_suffix}-%s", element(var.azs, count.index), )
        format("${var.name}-${var.loadbalancer_subnet_suffix}-%s", element(split("", var.azs[count.index]), length(var.azs[count.index]) -1))
      )
    },
    var.tags,
    var.loadbalancer_subnet_tags,
  )
}

# resource "aws_db_subnet_group" "loadbalancer" {
#   count = local.create_loadbalancer_subnets && var.create_loadbalancer_subnet_group ? 1 : 0

#   name        = lower(coalesce(var.loadbalancer_subnet_group_name, var.name))
#   description = "loadbalancer subnet group for ${var.name}"
#   subnet_ids  = aws_subnet.loadbalancer[*].id

#   tags = merge(
#     {
#       "Name" = lower(coalesce(var.loadbalancer_subnet_group_name, var.name))
#     },
#     var.tags,
#     var.loadbalancer_subnet_group_tags,
#   )
# }

resource "aws_route_table" "loadbalancer" {
  count = local.create_loadbalancer_route_table ? var.single_nat_gateway || var.create_loadbalancer_internet_gateway_route ? 1 : local.len_loadbalancer_subnets : 0

  vpc_id = local.vpc_id

  tags = merge(
    {
      "Name" = var.single_nat_gateway || var.create_loadbalancer_internet_gateway_route ? "${var.name}-${var.loadbalancer_subnet_suffix}" : format(
        "${var.name}-${var.loadbalancer_subnet_suffix}-%s",
        element(var.azs, count.index),
      )
    },
    var.tags,
    var.loadbalancer_route_table_tags,
  )
}

resource "aws_route_table_association" "loadbalancer" {
  count = local.create_loadbalancer_subnets ? local.len_loadbalancer_subnets : 0

  subnet_id = element(aws_subnet.loadbalancer[*].id, count.index)
  route_table_id = element(
    coalescelist(aws_route_table.loadbalancer[*].id, aws_route_table.private[*].id),
    var.create_loadbalancer_subnet_route_table ? var.single_nat_gateway || var.create_loadbalancer_internet_gateway_route ? 0 : count.index : count.index,
  )
}

resource "aws_route" "loadbalancer_internet_gateway" {
  count = local.create_loadbalancer_route_table && var.create_igw && var.create_loadbalancer_internet_gateway_route && !var.create_loadbalancer_nat_gateway_route ? 1 : 0

  route_table_id         = aws_route_table.loadbalancer[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "loadbalancer_nat_gateway" {
  count = local.create_loadbalancer_route_table && !var.create_loadbalancer_internet_gateway_route && var.create_loadbalancer_nat_gateway_route && var.enable_nat_gateway ? var.single_nat_gateway ? 1 : local.len_loadbalancer_subnets : 0

  route_table_id         = element(aws_route_table.loadbalancer[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this[*].id, count.index)

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "loadbalancer_dns64_nat_gateway" {
  count = local.create_loadbalancer_route_table && !var.create_loadbalancer_internet_gateway_route && var.create_loadbalancer_nat_gateway_route && var.enable_nat_gateway && var.enable_ipv6 && var.private_subnet_enable_dns64 ? var.single_nat_gateway ? 1 : local.len_loadbalancer_subnets : 0

  route_table_id              = element(aws_route_table.loadbalancer[*].id, count.index)
  destination_ipv6_cidr_block = "64:ff9b::/96"
  nat_gateway_id              = element(aws_nat_gateway.this[*].id, count.index)

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "loadbalancer_ipv6_egress" {
  count = local.create_loadbalancer_route_table && var.create_egress_only_igw && var.enable_ipv6 && var.create_loadbalancer_internet_gateway_route ? 1 : 0

  route_table_id              = aws_route_table.loadbalancer[0].id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

################################################################################
# loadbalancer Network ACLs
################################################################################

locals {
  create_loadbalancer_network_acl = local.create_loadbalancer_subnets && var.loadbalancer_dedicated_network_acl
}

resource "aws_network_acl" "loadbalancer" {
  count = local.create_loadbalancer_network_acl ? 1 : 0

  vpc_id     = local.vpc_id
  subnet_ids = aws_subnet.loadbalancer[*].id

  tags = merge(
    { "Name" = "${var.name}-${var.loadbalancer_subnet_suffix}" },
    var.tags,
    var.loadbalancer_acl_tags,
  )
}

resource "aws_network_acl_rule" "loadbalancer_inbound" {
  count = local.create_loadbalancer_network_acl ? length(var.loadbalancer_inbound_acl_rules) : 0

  network_acl_id = aws_network_acl.loadbalancer[0].id

  egress          = false
  rule_number     = var.loadbalancer_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.loadbalancer_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.loadbalancer_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.loadbalancer_inbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.loadbalancer_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.loadbalancer_inbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.loadbalancer_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.loadbalancer_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.loadbalancer_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "loadbalancer_outbound" {
  count = local.create_loadbalancer_network_acl ? length(var.loadbalancer_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.loadbalancer[0].id

  egress          = true
  rule_number     = var.loadbalancer_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.loadbalancer_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.loadbalancer_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.loadbalancer_outbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.loadbalancer_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.loadbalancer_outbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.loadbalancer_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.loadbalancer_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.loadbalancer_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}
