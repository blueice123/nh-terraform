module "ingress_vpc" {
  source = "../../00.Modules/vpc/"

  name = "nh-ing-vpc"
  cidr = "10.0.0.0/24"

  azs                  = ["ap-northeast-2a", "ap-northeast-2c"]
  public_subnets       = ["10.0.0.0/28", "10.0.0.16/28"]
  gwlb_subnets         = ["10.0.0.32/28", "10.0.0.48/28"]
  loadbalancer_subnets = ["10.0.0.64/28", "10.0.0.80/28"]
  private_subnets      = ["10.0.0.96/28", "10.0.0.112/28"]
  endpoint_subnets     = ["10.0.0.128/28", "10.0.0.144/28"]

  # NAT G/W 설정, 모든 zone에 구성 
  enable_nat_gateway = false
  single_nat_gateway = false
  one_nat_gateway_per_az = false

  # Routetable 생성 기준 (Public, Private routetable은 무조건 생성됨)
  create_gwlb_subnet_route_table          = true
  create_loadbalancer_subnet_route_table  = true
  create_endpoint_subnet_route_table      = true

  # vpc flow logs
  enable_flow_log                     = true
  flow_log_max_aggregation_interval   = "60"
  flow_log_traffic_type               = "ALL"
  flow_log_destination_type           = "s3"
  flow_log_log_format                 = null
  flow_log_file_format                = "plain-text" #"parquet"
  flow_log_destination_arn            = data.terraform_remote_state.logs.outputs.s3_vpc_flow_arn
  flow_log_hive_compatible_partitions = false
  flow_log_per_hour_partition         = true
  vpc_flow_log_tags = {
    Name = "vpcflow"
  }

  tags = {
    Environment = "net"
  }
}
