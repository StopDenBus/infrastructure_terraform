module "databases" {
  source    = "./modules/databases"

  databases = var.databases
}

module "grants" {
  source  = "./modules/grants"

  users   = var.users
}

module "users" {
  source  = "./modules/users"

  secrets = var.secrets
  users   = var.users
}
