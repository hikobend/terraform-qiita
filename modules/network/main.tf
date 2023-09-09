module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  cidr                    = "10.0.0.0/24"
  azs                     = ["ap-northeast-1a", "ap-northeast-1c"]
  public_subnets          = ["10.0.0.0/26", "10.0.0.64/26"]
  private_subnets         = ["10.0.0.128/26", "10.0.0.192/26"]
  public_subnet_names     = ["public-subnet-1a", "public-subnet-1c"]
  private_subnet_names    = ["private-subnet-1a", "private-subnet-1c"]
  enable_dns_hostnames    = true # DNSホスト名を有効化
  enable_dns_support      = true # DNS解決を有効化
  enable_nat_gateway      = true # NatGatewayを有効化
  one_nat_gateway_per_az  = true # 1AZに対してNatGatewayを作成
  map_public_ip_on_launch = true # publicサブネットにIPv4を自動割り当て流

  vpc_tags                 = { Name = "vpc" }
  public_route_table_tags  = { Name = "route-table-public" }
  private_route_table_tags = { Name = "route-table-private" }
  igw_tags                 = { Name = "internet-gateway" }
  nat_gateway_tags         = { Name = "nat-gateway" }
  nat_eip_tags             = { Name = "elatic-ip" }
}
