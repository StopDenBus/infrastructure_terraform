output "secrets" {
  value = local.passwords
}

output "vault-dex-client-password" {
  value = random_password.passwords["vault_dex_client"].result
}