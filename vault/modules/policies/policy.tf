resource "vault_policy" "policies" {
  for_each = var.policies

  name = each.key
  policy = jsonencode(each.value["policy"])
}