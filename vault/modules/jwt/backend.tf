resource "vault_jwt_auth_backend" "dex" {

  description        = "Dex OIDC"
  path               = "oidc"
  type               = "oidc"
  oidc_discovery_url = "https://dex.apps.gusek.info/dex"
  oidc_client_id     = "vault"
  oidc_client_secret = var.oidc_client_secret
  default_role       = "default"
}

resource "vault_jwt_auth_backend_role" "oidc_default" {

  backend               = vault_jwt_auth_backend.dex.path
  role_type             = "oidc"
  role_name             = "default"
  token_policies        = ["default", "admin", "ssh" ]
  oidc_scopes           = ["groups"]
  user_claim            = "sub"
  groups_claim          = "groups"
  allowed_redirect_uris = [ "https://vault.gusek.info/ui/vault/auth/oidc/oidc/callback", "https://vault.gusek.info/oidc/callback", "http://localhost:8250/oidc/callback" ]
  token_ttl             = 43200
  token_max_ttl         = 43200
}