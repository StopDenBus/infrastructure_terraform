locals {
  passwords = {
    for key, value in var.secrets:
        "${key}" => {
            key = random_password.passwords["${key}"].result
        }
  }
}

resource "random_password" "passwords" {
    for_each = var.secrets

    length  = 24
    special = false

    lifecycle {
        ignore_changes = [
            length,
        ]
    }    
}

resource "vault_kv_secret_v2" "secrets" {
    for_each = var.secrets

    mount     = each.value["mount"]
    name      = each.value["name"]
    data_json = jsonencode(local.passwords[each.key])
}