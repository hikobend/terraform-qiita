module "dev_tfstate" {
  source = "../../modules/tfstate"
}

module "network" {
  source = "../../modules/network"
  env    = var.env
}

module "rds" {
  source = "../../modules/rds"
  env    = var.env
}
