locals {
    grants = flatten([
        for user, value in var.users: [
            for privileg in value.privileges: {
                database = privileg.database
                user = "${user}"
                host = "${value.host}"
                privileges = privileg.grant
            }
        ]
    ])

    grants_map = {
        for obj in local.grants: "${obj.user}_${obj.database}_${obj.host}" => obj
    }
}

resource "mysql_grant" "grants" {
    for_each = local.grants_map

    user        = each.value["user"]
    host        = each.value["host"]
    database    = each.value["database"]
    privileges  = each.value["privileges"]
}