resource "mysql_user" "users" {
    for_each = var.users

    user                = each.key
    host                = each.value["host"]
    plaintext_password  = var.secrets["mysql_${each.key}"]["key"]
}