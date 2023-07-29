data "kubernetes_secret" "external-secrets" {
  metadata {
    name = "external-secrets"
    namespace = "external-secrets"
  }
}

resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_role" "external-secrets" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "external-secrets"
  bound_service_account_names      = ["external-secrets"]
  bound_service_account_namespaces = ["external-secrets"]
  token_ttl                        = 3600
  token_policies                   = ["external-secrets"]
}

resource "vault_kubernetes_auth_backend_config" "external-secrets" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = "https://stoppi.gusek.info:6443"
  kubernetes_ca_cert     = data.kubernetes_secret.external-secrets.data["ca.crt"]
  token_reviewer_jwt     = data.kubernetes_secret.external-secrets.data.token
  disable_iss_validation = "true"
}