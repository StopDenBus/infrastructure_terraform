resource "mysql_database" "databases" {
    for_each = var.databases

    name = each.key
    
    default_character_set   = each.value["default_character_set"]
    default_collation       = each.value["default_collation"]
}