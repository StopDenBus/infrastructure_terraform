# Install vault
resource "system_packages_apt" "vault" {
    package {
        name = "vault"
    }
}

resource "linux_file" "vault_config" {
    path = "/etc/vault.d/vault.hcl"
    overwrite = true
    content = trimspace(<<EOT
# Full configuration options can be found at https://www.vaultproject.io/docs/configuration
ui = true
disable_mlock = true

storage "file" {
  path = "/opt/vault/data"
}

# HTTPS listener
listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_cert_file = "/opt/vault/tls/tls.crt"
  tls_key_file  = "/opt/vault/tls/tls.key"
}
EOT
  )

  depends_on = [
    system_packages_apt.vault,
  ]
}

# Enable and start vault service
resource "system_service_systemd" "vault" {
  name    = "vault"
  enabled = true
  status  = "started"

  #reload_on = [
  #  linux_file.vault_config.md5sum
  #]

  depends_on = [
    # Package must be installed
    system_packages_apt.vault,
  ]
}

resource "system_file" "unseal_vault" {
    path    = "/etc/systemd/system/unseal-vault.service"
    mode    = 644
    user    = "root"
    group   = "root"
    content = <<EOT
[Unit]
Description=Unseal vault
Requires=vault.service
Requires=nginx.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/sleep 5 
ExecStart=/root/bin/vault_unseal.sh

[Install]
WantedBy=multi-user.target
EOT
}

resource "system_service_systemd" "unseal_vault" {
  name    = "unseal-vault"
  enabled = true
  status  = "started"

  depends_on = [
    system_file.unseal_vault
  ]
}
