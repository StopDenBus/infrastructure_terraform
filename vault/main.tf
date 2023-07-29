module "mounts" {
  source = "./modules/mounts"

  mounts = var.mounts

  depends_on = [
    module.policies
  ]
}

module "policies" {
    source = "./modules/policies"

    policies = var.policies
}

module "secrets" {
  source = "./modules/secrets"

  secrets = var.secrets

  depends_on = [
    module.mounts
  ]
}

module "auth" {
  source = "./modules/auth"

  depends_on = [
    module.policies
  ]
}

module "jwt" {
  source = "./modules/jwt"
  oidc_client_secret = module.secrets.vault-dex-client-password
}

module "ssh" {
  source = "./modules/ssh"
  ssh_backend = module.mounts.ssh_mounts
}

output "secrets" {
  sensitive = true
  value = module.secrets.secrets
}
