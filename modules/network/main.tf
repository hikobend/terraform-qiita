module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  cidr                    = "10.0.0.0/24"                                                    # VPCのcidr
  azs                     = ["ap-northeast-1a", "ap-northeast-1c"]                           # 展開するAZ
  public_subnets          = ["10.0.0.0/26", "10.0.0.64/26"]                                  # public-subnetのcidr
  private_subnets         = ["10.0.0.128/26", "10.0.0.192/26"]                               # private-subnetのcidr
  public_subnet_names     = ["${var.env}-public-subnet-1a", "${var.env}-public-subnet-1c"]   # public-subnetの名前
  private_subnet_names    = ["${var.env}-private-subnet-1a", "${var.env}-private-subnet-1c"] # private-subnetの名前
  enable_dns_hostnames    = true                                                             # DNSホスト名を有効化
  enable_dns_support      = true                                                             # DNS解決を有効化
  enable_nat_gateway      = true                                                             # NatGatewayを有効化
  one_nat_gateway_per_az  = true                                                             # 1AZに対してNatGatewayを作成
  map_public_ip_on_launch = true                                                             # publicサブネットにIPv4を自動割り当てる

  vpc_tags                 = { Name = "${var.env}-vpc" }
  public_route_table_tags  = { Name = "${var.env}-route-table-public" }
  private_route_table_tags = { Name = "${var.env}-route-table-private" }
  igw_tags                 = { Name = "${var.env}-internet-gateway" }
  nat_gateway_tags         = { Name = "${var.env}-nat-gateway" }
  nat_eip_tags             = { Name = "${var.env}-elatic-ip" }
}

module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "${var.env}-alb-sg"
  description = "ALB security group"
  vpc_id      = module.network.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
  egress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.ecs_sg.security_group_id
    }
  ]
}

module "ecs_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "${var.env}-frontend-sg"
  description = "ECS security group"
  vpc_id      = module.network.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.alb_sg.security_group_id
    }
  ]
  egress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.database_sg.security_group_id
    },
    {
      rule                     = "redis-tcp"
      source_security_group_id = module.elasticache_sg.security_group_id
    }
  ]
}

module "database_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "${var.env}-database-sg"
  description = "Database security group"
  vpc_id      = module.network.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.ecs_sg.security_group_id
    }
  ]
}

module "elasticache_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "${var.env}-elasticache-sg"
  description = "Elasticache security group"
  vpc_id      = module.network.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "redis-tcp"
      source_security_group_id = module.ecs_sg.security_group_id
    }
  ]
}
