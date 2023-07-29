resource "vault_ldap_auth_backend_group" "group" {
    groupname = "kubernetes_admin"
    policies  = ["admin"]
    backend   = vault_ldap_auth_backend.ldap.path
}