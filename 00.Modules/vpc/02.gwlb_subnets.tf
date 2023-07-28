################################################################################
# gwlb Subnets
################################################################################

output "gwlb_subnets" {
  description = "List of IDs of gwlb subnets"
  value       = aws_subnet.gwlb[*].id
}

output "gwlb_subnets_tags_all" { ## 태그 값 추가 
  description = "List of cidr_blocks of gwlb subnets"
  value       = aws_subnet.gwlb[*].tags_all[*]
}

output "gwlb_subnet_arns" {
  description = "List of ARNs of gwlb subnets"
  value       = aws_subnet.gwlb[*].arn
}

output "gwlb_subnets_cidr_blocks" {
  description = "List of cidr_blocks of gwlb subnets"
  value       = compact(aws_subnet.gwlb[*].cidr_block)
}

output "gwlb_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of gwlb subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.gwlb[*].ipv6_cidr_block)
}

# output "gwlb_subnet_group" {
#   description = "ID of gwlb subnet group"
#   value       = try(aws_db_subnet_group.gwlb[0].id, null)
# }

# output "gwlb_subnet_group_name" {
#   description = "Name of gwlb subnet group"
#   value       = try(aws_db_subnet_group.gwlb[0].name, null)
# }

output "gwlb_route_table_ids" {
  description = "List of IDs of gwlb route tables"
  value       = try(coalescelist(aws_route_table.gwlb[*].id, local.private_route_table_ids), [])
}

output "gwlb_internet_gateway_route_id" {
  description = "ID of the gwlb internet gateway route"
  value       = try(aws_route.gwlb_internet_gateway[0].id, null)
}

output "gwlb_nat_gateway_route_ids" {
  description = "List of IDs of the gwlb nat gateway route"
  value       = aws_route.gwlb_nat_gateway[*].id
}

output "gwlb_ipv6_egress_route_id" {
  description = "ID of the gwlb IPv6 egress route"
  value       = try(aws_route.gwlb_ipv6_egress[0].id, null)
}

output "gwlb_route_table_association_ids" {
  description = "List of IDs of the gwlb route table association"
  value       = aws_route_table_association.gwlb[*].id
}

output "gwlb_network_acl_id" {
  description = "ID of the gwlb network ACL"
  value       = try(aws_network_acl.gwlb[0].id, null)
}

output "gwlb_network_acl_arn" {
  description = "ARN of the gwlb network ACL"
  value       = try(aws_network_acl.gwlb[0].arn, null)
}

################################################################################
# gwlb Subnets
################################################################################

variable "gwlb_subnets" {
  description = "A list of gwlb subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "gwlb_subnet_assign_ipv6_address_on_creation" {
  description = "Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is `false`"
  type        = bool
  default     = false
}

variable "gwlb_subnet_enable_dns64" {
  description = "Indicates whether DNS queries made to the Amazon-provided DNS Resolver in this subnet should return synthetic IPv6 addresses for IPv4-only destinations. Default: `true`"
  type        = bool
  default     = true
}

variable "gwlb_subnet_enable_resource_name_dns_aaaa_record_on_launch" {
  description = "Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. Default: `true`"
  type        = bool
  default     = true
}

variable "gwlb_subnet_enable_resource_name_dns_a_record_on_launch" {
  description = "Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default: `false`"
  type        = bool
  default     = false
}

variable "gwlb_subnet_ipv6_prefixes" {
  description = "Assigns IPv6 gwlb subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
  type        = list(string)
  default     = []
}

variable "gwlb_subnet_ipv6_native" {
  description = "Indicates whether to create an IPv6-only subnet. Default: `false`"
  type        = bool
  default     = false
}

variable "gwlb_subnet_private_dns_hostname_type_on_launch" {
  description = "The type of hostnames to assign to instances in the subnet at launch. For IPv6-only subnets, an instance DNS name must be based on the instance ID. For dual-stack and IPv4-only subnets, you can specify whether DNS names use the instance IPv4 address or the instance ID. Valid values: `ip-name`, `resource-name`"
  type        = string
  default     = null
}

variable "gwlb_subnet_names" {
  description = "Explicit values to use in the Name tag on gwlb subnets. If empty, Name tags are generated"
  type        = list(string)
  default     = []
}

variable "gwlb_subnet_suffix" {
  description = "Suffix to append to gwlb subnets name"
  type        = string
  default     = "gwlb"
}

variable "create_gwlb_subnet_route_table" {
  description = "Controls if separate route table for gwlb should be created"
  type        = bool
  default     = false
}

variable "create_gwlb_internet_gateway_route" {
  description = "Controls if an internet gateway route for public gwlb access should be created"
  type        = bool
  default     = false
}

variable "create_gwlb_nat_gateway_route" {
  description = "Controls if a nat gateway route should be created to give internet access to the gwlb subnets"
  type        = bool
  default     = false
}

variable "gwlb_route_table_tags" {
  description = "Additional tags for the gwlb route tables"
  type        = map(string)
  default     = {}
}

variable "gwlb_subnet_tags" {
  description = "Additional tags for the gwlb subnets"
  type        = map(string)
  default     = {}
}

# variable "create_gwlb_subnet_group" {
#   description = "Controls if gwlb subnet group should be created (n.b. gwlb_subnets must also be set)"
#   type        = bool
#   default     = true
# }

# variable "gwlb_subnet_group_name" {
#   description = "Name of gwlb subnet group"
#   type        = string
#   default     = null
# }

# variable "gwlb_subnet_group_tags" {
#   description = "Additional tags for the gwlb subnet group"
#   type        = map(string)
#   default     = {}
# }

################################################################################
# gwlb Network ACLs
################################################################################

variable "gwlb_dedicated_network_acl" {
  description = "Whether to use dedicated network ACL (not default) and custom rules for gwlb subnets"
  type        = bool
  default     = false
}

variable "gwlb_inbound_acl_rules" {
  description = "gwlb subnets inbound network ACL rules"
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

variable "gwlb_outbound_acl_rules" {
  description = "gwlb subnets outbound network ACL rules"
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

variable "gwlb_acl_tags" {
  description = "Additional tags for the gwlb subnets network ACL"
  type        = map(string)
  default     = {}
}


################################################################################
# gwlb Subnets
################################################################################

locals {
  create_gwlb_subnets     = local.create_vpc && local.len_gwlb_subnets > 0
  create_gwlb_route_table = local.create_gwlb_subnets && var.create_gwlb_subnet_route_table
}

resource "aws_subnet" "gwlb" {
  count = local.create_gwlb_subnets ? local.len_gwlb_subnets : 0

  assign_ipv6_address_on_creation                = var.enable_ipv6 && var.gwlb_subnet_ipv6_native ? true : var.gwlb_subnet_assign_ipv6_address_on_creation
  availability_zone                              = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id                           = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  cidr_block                                     = var.gwlb_subnet_ipv6_native ? null : element(concat(var.gwlb_subnets, [""]), count.index)
  enable_dns64                                   = var.enable_ipv6 && var.gwlb_subnet_enable_dns64
  enable_resource_name_dns_aaaa_record_on_launch = var.enable_ipv6 && var.gwlb_subnet_enable_resource_name_dns_aaaa_record_on_launch
  enable_resource_name_dns_a_record_on_launch    = !var.gwlb_subnet_ipv6_native && var.gwlb_subnet_enable_resource_name_dns_a_record_on_launch
  ipv6_cidr_block                                = var.enable_ipv6 && length(var.gwlb_subnet_ipv6_prefixes) > 0 ? cidrsubnet(aws_vpc.this[0].ipv6_cidr_block, 8, var.gwlb_subnet_ipv6_prefixes[count.index]) : null
  ipv6_native                                    = var.enable_ipv6 && var.gwlb_subnet_ipv6_native
  private_dns_hostname_type_on_launch            = var.gwlb_subnet_private_dns_hostname_type_on_launch
  vpc_id                                         = local.vpc_id

  tags = merge(
    {
      Name = try(
        var.gwlb_subnet_names[count.index],
        # format("${var.name}-${var.gwlb_subnet_suffix}-%s", element(var.azs, count.index), )
        format("${var.name}-${var.gwlb_subnet_suffix}-%s", element(split("", var.azs[count.index]), length(var.azs[count.index]) -1))
      )
    },
    var.tags,
    var.gwlb_subnet_tags,
  )
}

# resource "aws_db_subnet_group" "gwlb" {
#   count = local.create_gwlb_subnets && var.create_gwlb_subnet_group ? 1 : 0

#   name        = lower(coalesce(var.gwlb_subnet_group_name, var.name))
#   description = "gwlb subnet group for ${var.name}"
#   subnet_ids  = aws_subnet.gwlb[*].id

#   tags = merge(
#     {
#       "Name" = lower(coalesce(var.gwlb_subnet_group_name, var.name))
#     },
#     var.tags,
#     var.gwlb_subnet_group_tags,
#   )
# }

resource "aws_route_table" "gwlb" {
  count = local.create_gwlb_route_table ? var.single_nat_gateway || var.create_gwlb_internet_gateway_route ? 1 : local.len_gwlb_subnets : 0

  vpc_id = local.vpc_id

  tags = merge(
    {
      "Name" = var.single_nat_gateway || var.create_gwlb_internet_gateway_route ? "${var.name}-${var.gwlb_subnet_suffix}" : format(
        "${var.name}-${var.gwlb_subnet_suffix}-%s",
        element(var.azs, count.index),
      )
    },
    var.tags,
    var.gwlb_route_table_tags,
  )
}

resource "aws_route_table_association" "gwlb" {
  count = local.create_gwlb_subnets ? local.len_gwlb_subnets : 0

  subnet_id = element(aws_subnet.gwlb[*].id, count.index)
  route_table_id = element(
    coalescelist(aws_route_table.gwlb[*].id, aws_route_table.private[*].id),
    var.create_gwlb_subnet_route_table ? var.single_nat_gateway || var.create_gwlb_internet_gateway_route ? 0 : count.index : count.index,
  )
}

resource "aws_route" "gwlb_internet_gateway" {
  count = local.create_gwlb_route_table && var.create_igw && var.create_gwlb_internet_gateway_route && !var.create_gwlb_nat_gateway_route ? 1 : 0

  route_table_id         = aws_route_table.gwlb[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "gwlb_nat_gateway" {
  count = local.create_gwlb_route_table && !var.create_gwlb_internet_gateway_route && var.create_gwlb_nat_gateway_route && var.enable_nat_gateway ? var.single_nat_gateway ? 1 : local.len_gwlb_subnets : 0

  route_table_id         = element(aws_route_table.gwlb[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this[*].id, count.index)

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "gwlb_dns64_nat_gateway" {
  count = local.create_gwlb_route_table && !var.create_gwlb_internet_gateway_route && var.create_gwlb_nat_gateway_route && var.enable_nat_gateway && var.enable_ipv6 && var.private_subnet_enable_dns64 ? var.single_nat_gateway ? 1 : local.len_gwlb_subnets : 0

  route_table_id              = element(aws_route_table.gwlb[*].id, count.index)
  destination_ipv6_cidr_block = "64:ff9b::/96"
  nat_gateway_id              = element(aws_nat_gateway.this[*].id, count.index)

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "gwlb_ipv6_egress" {
  count = local.create_gwlb_route_table && var.create_egress_only_igw && var.enable_ipv6 && var.create_gwlb_internet_gateway_route ? 1 : 0

  route_table_id              = aws_route_table.gwlb[0].id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

################################################################################
# gwlb Network ACLs
################################################################################

locals {
  create_gwlb_network_acl = local.create_gwlb_subnets && var.gwlb_dedicated_network_acl
}

resource "aws_network_acl" "gwlb" {
  count = local.create_gwlb_network_acl ? 1 : 0

  vpc_id     = local.vpc_id
  subnet_ids = aws_subnet.gwlb[*].id

  tags = merge(
    { "Name" = "${var.name}-${var.gwlb_subnet_suffix}" },
    var.tags,
    var.gwlb_acl_tags,
  )
}

resource "aws_network_acl_rule" "gwlb_inbound" {
  count = local.create_gwlb_network_acl ? length(var.gwlb_inbound_acl_rules) : 0

  network_acl_id = aws_network_acl.gwlb[0].id

  egress          = false
  rule_number     = var.gwlb_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.gwlb_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.gwlb_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.gwlb_inbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.gwlb_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.gwlb_inbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.gwlb_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.gwlb_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.gwlb_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "gwlb_outbound" {
  count = local.create_gwlb_network_acl ? length(var.gwlb_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.gwlb[0].id

  egress          = true
  rule_number     = var.gwlb_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.gwlb_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.gwlb_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.gwlb_outbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.gwlb_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.gwlb_outbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.gwlb_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.gwlb_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.gwlb_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}
