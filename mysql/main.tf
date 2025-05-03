module "databases" {
  source    = "./modules/databases"

  databases = var.databases
}

module "grants" {
  source  = "./modules/grants"

  users   = var.users
  depends_on = [ module.users ]
}

module "users" {
  source  = "./modules/users"

  secrets = var.secrets
  users   = var.users
  depends_on = [ module.databases ]
}
