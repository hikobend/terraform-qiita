module "dev_tfstate" {
  source = "../../modules/tfstate"
}

# module "network" {
#   source = "../../modules/network"
# }

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
}
