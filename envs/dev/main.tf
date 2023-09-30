module "network" {
  source = "../../modules/network"
  env    = var.env
}

module "aurora" {
  source = "../../modules/aurora"
  env    = var.env

  private_subnet_ids = module.network.private_subnet_ids
}
