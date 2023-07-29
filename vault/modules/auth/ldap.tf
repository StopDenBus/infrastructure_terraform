resource "vault_ldap_auth_backend" "ldap" {
    path            = "ldap"
    url             = "ldaps://samba.gusek.info"
    insecure_tls    = true
    userdn          = "cn=users,dc=gusek,dc=info"
    userattr        = "sAMAccountName"
    upndomain       = "gusek.info"
    discoverdn      = false
    groupdn         = "dc=gusek,dc=info"
    groupfilter     = "(&(objectClass=group)(member:1.2.840.113556.1.4.1941:={{.UserDN}}))"
}