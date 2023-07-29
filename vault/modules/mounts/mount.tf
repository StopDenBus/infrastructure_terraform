resource "vault_mount" "mount" {
    for_each = var.mounts

    path        = each.key
    type        = each.value["type"]
    description = each.value["description"]
}
