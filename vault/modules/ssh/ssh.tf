resource "vault_ssh_secret_backend_ca" "ca" {
    backend = var.ssh_backend
    generate_signing_key = true
}

 

resource "vault_ssh_secret_backend_role" "sshca" {
    name                    = "linux"
    backend                 = var.ssh_backend
    key_type                = "ca"
    algorithm_signer        = "rsa-sha2-512"
    allow_user_certificates = true
    default_user_template   = true
    default_user            = "*"
    allowed_users_template  = true
    allowed_users           = "*"
    allowed_extensions      = "permit-agent-forwarding,permit-port-forwarding,permit-pty,permit-x11-forwarding"
    default_extensions      = {
      permit-agent-forwarding = "",
      permit-port-forwarding  = "",
      permit-pty              = "",
      permit-X11-forwarding   = ""
    }
    ttl                     = "86400"
    max_ttl                 = "86400"
}